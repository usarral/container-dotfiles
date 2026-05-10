#!/bin/sh

# Script universal de instalación para contenedores de desarrollo (DevContainers)
# Detecta el gestor de paquetes (Debian/Ubuntu/Alpine), instala herramientas y aplica configuraciones.
#
# Uso:
#   ./install.sh                    # Solo herramientas base
#   ./install.sh --lang node        # Base + Node.js
#   ./install.sh --lang java,node   # Base + Java + Node.js
#   DEVPOD_LANG=java ./install.sh   # Usando variable de entorno
#
# Lenguajes soportados: node, java, python, go, rust

set -e

export DEBIAN_FRONTEND=noninteractive
export CI=true

# --- Detectar arquitectura (necesario antes de cualquier descarga) ---
ARCH=$(uname -m)
case $ARCH in
    x86_64)           MVND_ARCH="linux-amd64"; GO_ARCH="amd64" ;;
    aarch64|arm64)    MVND_ARCH="linux-aarch64"; GO_ARCH="arm64" ;;
    *)                MVND_ARCH="unknown"; GO_ARCH="amd64" ;;
esac

# --- Parse --lang argument (overrides DEVPOD_LANG env var if provided) ---
LANG_LIST="${DEVPOD_LANG:-}"

while [ $# -gt 0 ]; do
    case "$1" in
        --lang) LANG_LIST="$2"; shift 2 ;;
        *)      shift ;;
    esac
done

# Normalize: replace spaces, lowercase
LANG_LIST=$(echo "$LANG_LIST" | tr '[:upper:]' '[:lower:]' | tr ' ' ',')

# Helper: check if a language is in the list
has_lang() {
    echo ",$LANG_LIST," | grep -q ",${1},"
}

echo "🚀 Iniciando instalación de herramientas de desarrollo..."
echo "🌐 Lenguajes activos: ${LANG_LIST:-ninguno (solo base)}"

# --- Detectar gestor de paquetes ---
if [ -f /etc/debian_version ]; then
    OS="debian"; PKG_MGR="apt-get"
elif [ -f /etc/alpine-release ]; then
    OS="alpine"; PKG_MGR="apk"
else
    if command -v apt-get >/dev/null 2>&1; then OS="debian"; PKG_MGR="apt-get"
    elif command -v apk >/dev/null 2>&1; then OS="alpine"; PKG_MGR="apk"
    else
        echo "❌ OS no soportado. Intentando continuar..."
        PKG_MGR="unknown"
    fi
fi

# Función para ejecutar con sudo si es necesario
run_as_root() {
    if [ "$(id -u)" -ne 0 ]; then
        if command -v sudo >/dev/null 2>&1; then sudo "$@"
        else echo "❌ Se requiere root pero 'sudo' no está instalado."; exit 1; fi
    else "$@"; fi
}

echo "📦 Sistema detectado: $OS ($PKG_MGR)"

# --- Instalar herramientas base ---
case $PKG_MGR in
    apt-get)
        echo "🔄 Actualizando repositorios y base..."
        run_as_root apt-get update -q
        run_as_root apt-get install -y -q git curl wget unzip tar build-essential fish bash ripgrep
        # bat: puede estar como 'bat' o 'batcat' según la distro
        run_as_root apt-get install -y -q bat 2>/dev/null || run_as_root apt-get install -y -q batcat 2>/dev/null || true
        mkdir -p ~/.local/bin
        ln -sf "$(command -v batcat 2>/dev/null || command -v bat)" ~/.local/bin/bat 2>/dev/null || true
        ;;
    apk)
        echo "🔄 Actualizando repositorios y base..."
        run_as_root apk update
        run_as_root apk add git bat curl wget unzip tar build-base fish bash ripgrep
        ;;
    *)
        echo "⚠️ Gestor desconocido. Asegurate de tener: git, curl, wget, unzip, fish, ripgrep"
        ;;
esac

# --- Instalar Neovim ---
echo "📦 Instalando la última versión de Neovim..."
if [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]; then
    NVIM_ARCHIVE="nvim-linux-arm64.tar.gz"
else
    NVIM_ARCHIVE="nvim-linux-x86_64.tar.gz"
fi
NVIM_DIR="${NVIM_ARCHIVE%.tar.gz}"
curl -LO "https://github.com/neovim/neovim/releases/latest/download/${NVIM_ARCHIVE}"
run_as_root rm -rf "/opt/${NVIM_DIR}"
run_as_root tar -C /opt -xzf "${NVIM_ARCHIVE}"
rm "${NVIM_ARCHIVE}"
run_as_root ln -sf "/opt/${NVIM_DIR}/bin/nvim" /usr/local/bin/nvim

# --- Ghostty terminfo (evita errores "unknown terminal: xterm-ghostty" al conectar desde Ghostty) ---
if command -v tic >/dev/null 2>&1 && ! toe 2>/dev/null | grep -q xterm-ghostty; then
    echo "🖥️  Instalando terminfo de Ghostty..."
    curl -sL "https://raw.githubusercontent.com/ghostty-org/ghostty/main/src/terminfo/ghostty.terminfo" \
        | tic -x - 2>/dev/null || true
fi

# --- Instalar Starship ---
if ! command -v starship >/dev/null 2>&1; then
    echo "⭐ Instalando Starship..."
    curl -sS https://starship.rs/install.sh | sh -s -- --yes
fi

mkdir -p "$HOME/.local/bin" "$HOME/.local/lib"

# --- Node.js (siempre, lo necesita Mason para algunos LSPs) ---
if ! command -v fnm >/dev/null 2>&1; then
    echo "📦 Instalando fnm (Fast Node Manager)..."
    curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell > /dev/null 2>&1
    export PATH="$HOME/.local/share/fnm:$PATH"
fi

if command -v fnm >/dev/null 2>&1 || [ -f "$HOME/.local/share/fnm/fnm" ]; then
    export PATH="$HOME/.local/share/fnm:$PATH"
    eval "$(fnm env --use-on-cd --shell bash 2>/dev/null)" || true
    echo "🟢 Instalando Node.js 22 via fnm..."
    fnm install 22 > /dev/null 2>&1 || true
    fnm default 22 > /dev/null 2>&1 || true
    fnm use 22 > /dev/null 2>&1 || true
    if command -v node >/dev/null 2>&1; then
        echo "✅ Node.js $(node -v) instalado."
        if ! command -v pnpm >/dev/null 2>&1 && has_lang "node"; then
            echo "📦 Instalando pnpm..."
            npm install -g pnpm > /dev/null 2>&1 || true
        fi
    fi
fi

# --- Java ---
if has_lang "java"; then
    echo "☕ Configurando entorno Java..."
    if command -v java >/dev/null 2>&1; then
        echo "✅ Java detectado: $(java -version 2>&1 | head -1)"
    else
        echo "⚠️  Java no encontrado. Asegurate de que el contenedor base incluye JDK."
    fi
    # Maven Daemon
    if ! command -v mvnd >/dev/null 2>&1 && [ "$MVND_ARCH" != "unknown" ]; then
        echo "📦 Instalando mvnd..."
        MVND_VERSION="1.0.2"
        curl -sL "https://github.com/apache/maven-mvnd/releases/download/$MVND_VERSION/maven-mvnd-$MVND_VERSION-$MVND_ARCH.tar.gz" -o /tmp/mvnd.tar.gz
        tar -xzf /tmp/mvnd.tar.gz -C "$HOME/.local/lib" > /dev/null 2>&1
        ln -sf "$HOME/.local/lib/maven-mvnd-$MVND_VERSION-$MVND_ARCH/bin/mvnd" "$HOME/.local/bin/mvnd"
        rm /tmp/mvnd.tar.gz
        echo "✅ mvnd instalado."
    fi
fi

# --- Python ---
if has_lang "python"; then
    echo "🐍 Configurando entorno Python..."
    if command -v python3 >/dev/null 2>&1; then
        echo "✅ Python detectado: $(python3 --version)"
        python3 -m pip install --quiet --upgrade pip 2>/dev/null || true
    else
        echo "⚠️  Python no encontrado. Asegurate de que el contenedor base incluye Python."
    fi
fi

# --- Go ---
if has_lang "go"; then
    echo "🐹 Configurando entorno Go..."
    if ! command -v go >/dev/null 2>&1; then
        echo "📦 Instalando Go..."
        GO_VERSION="1.23.4"
        curl -sLO "https://go.dev/dl/go${GO_VERSION}.linux-${GO_ARCH}.tar.gz"
        run_as_root rm -rf /usr/local/go
        run_as_root tar -C /usr/local -xzf "go${GO_VERSION}.linux-${GO_ARCH}.tar.gz"
        rm "go${GO_VERSION}.linux-${GO_ARCH}.tar.gz"
        export PATH="/usr/local/go/bin:$PATH"
        echo "✅ Go $(go version) instalado."
    else
        echo "✅ Go detectado: $(go version)"
    fi
fi

# --- Rust ---
if has_lang "rust"; then
    echo "🦀 Configurando entorno Rust..."
    if ! command -v rustc >/dev/null 2>&1; then
        echo "📦 Instalando Rust via rustup..."
        curl -sSf https://sh.rustup.rs | sh -s -- -y --quiet
        export PATH="$HOME/.cargo/bin:$PATH"
        echo "✅ Rust instalado."
    else
        echo "✅ Rust detectado: $(rustc --version)"
    fi
fi

# --- Aplicar configuraciones ---
chmod +x scripts/setup/*.sh

echo "⚙️  Aplicando configuraciones..."
./scripts/setup/setup-fish-config.sh
./scripts/setup/setup-git-config.sh
./scripts/setup/setup-starship-config.sh
./scripts/setup/setup-nvim-config.sh

# --- Persistir DEVPOD_LANG DESPUÉS del symlink de fish ---
# El setup-fish-config.sh crea el symlink ~/.config/fish -> dotfiles/fish
# Hay que escribir DESPUÉS para que el archivo quede en el directorio activo.
# También se escribe en ~/.profile para sesiones bash (DevPod SSH usa bash por defecto).
if [ -n "$LANG_LIST" ]; then
    echo "🐠 Persistiendo DEVPOD_LANG=$LANG_LIST..."
    mkdir -p "$HOME/.config/fish/conf.d"
    printf 'set -gx DEVPOD_LANG "%s"\n' "$LANG_LIST" > "$HOME/.config/fish/conf.d/devpod-lang.fish"
    # También en ~/.bash_profile para sesiones bash login (no ~/.profile, fish lo parsea y falla)
    printf '\nexport DEVPOD_LANG="%s"\n' "$LANG_LIST" >> "$HOME/.bash_profile"
fi

# --- Fish como shell por defecto ---
if command -v fish >/dev/null 2>&1; then
    FISH_PATH=$(command -v fish)
    echo "🐠 Estableciendo fish como shell por defecto ($FISH_PATH)..."
    if ! grep -q "$FISH_PATH" /etc/shells 2>/dev/null; then
        echo "$FISH_PATH" | run_as_root tee -a /etc/shells > /dev/null
    fi
    run_as_root chsh -s "$FISH_PATH" "$(id -un)" 2>/dev/null || true
fi

mkdir -p "$HOME/.config/obsidian"

# --- Pre-instalar LSPs via Mason (headless) ---
# Solo para lenguajes que tienen servidores pesados que tardan en bajar la primera vez.
if has_lang "java" || has_lang "node" || has_lang "python"; then
    echo "📦 Pre-instalando plugins de Neovim (headless, puede tardar ~2 min)..."
    DEVPOD_LANG="$LANG_LIST" nvim --headless "+Lazy! sync" +qa 2>/dev/null || true

    if has_lang "java"; then
        echo "☕ Pre-instalando jdtls via Mason..."
        DEVPOD_LANG="$LANG_LIST" nvim --headless "+MasonInstall jdtls" +qa 2>/dev/null || true
    fi
    if has_lang "node"; then
        echo "🟢 Pre-instalando vtsls y eslint via Mason..."
        DEVPOD_LANG="$LANG_LIST" nvim --headless "+MasonInstall vtsls eslint_d" +qa 2>/dev/null || true
    fi
    if has_lang "python"; then
        echo "🐍 Pre-instalando pyright y ruff via Mason..."
        DEVPOD_LANG="$LANG_LIST" nvim --headless "+MasonInstall pyright ruff" +qa 2>/dev/null || true
    fi
fi

echo ""
echo "✅ ¡Instalación completada con éxito!"
echo "👉 Shell por defecto: fish. Reiniciá el terminal o escribí: fish"
echo "👉 DEVPOD_LANG='${LANG_LIST:-}'"
echo "👉 Abrí nvim — plugins y LSPs ya instalados."
exit 0
