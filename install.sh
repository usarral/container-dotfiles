#!/bin/sh

# Script universal de instalación para contenedores de desarrollo (DevContainers)
# Detecta el gestor de paquetes (Debian/Ubuntu/Alpine), instala herramientas y aplica configuraciones.

set -e

# Configuración de instalación en modo no interactivo
export DEBIAN_FRONTEND=noninteractive
export CI=true

echo "🚀 Iniciando instalación de herramientas de desarrollo..."

# Detectar el gestor de paquetes
if [ -f /etc/debian_version ]; then
    OS="debian"
    PKG_MGR="apt-get"
elif [ -f /etc/alpine-release ]; then
    OS="alpine"
    PKG_MGR="apk"
else
    # Intento genérico por comando
    if command -v apt-get >/dev/null 2>&1; then OS="debian"; PKG_MGR="apt-get";
    elif command -v apk >/dev/null 2>&1; then OS="alpine"; PKG_MGR="apk";
    else
        echo "❌ OS no soportado directamente. Intentando continuar con comandos genéricos..."
        PKG_MGR="unknown"
    fi
fi

# Función para ejecutar con sudo si es necesario
run_as_root() {
    if [ "$(id -u)" -ne 0 ]; then
        if command -v sudo >/dev/null 2>&1; then
            sudo "$@"
        else
            echo "❌ Se requieren privilegios de root pero 'sudo' no está instalado."
            exit 1
        fi
    else
        "$@"
    fi
}

echo "📦 Sistema detectado: $OS ($PKG_MGR)"

# Actualizar e instalar dependencias base
case $PKG_MGR in
    apt-get)
        echo "🔄 Actualizando repositorios y base..."
        run_as_root apt-get update -q
        run_as_root apt-get install -y -q zoxide eza git curl wget unzip tar build-essential fish neovim bash
        ;;
    apk)
        echo "🔄 Actualizando repositorios y base..."
        run_as_root apk update
        run_as_root apk add git curl wget eza zoxide unzip tar build-base fish neovim bash
        ;;
    *)
        echo "⚠️ Gestor de paquetes desconocido. Por favor, asegúrate de tener instalados: git, curl, wget, unzip, tar, fish, neovim, bash"
        ;;
esac

# Instalar Starship (si no está)
if ! command -v starship >/dev/null 2>&1; then
    echo "⭐ Instalando Starship..."
    curl -sS https://starship.rs/install.sh | sh -s -- --yes
fi

# --- Detección de Arquitectura y Entornos ---
echo "🔍 Detectando arquitectura y entornos de desarrollo..."

# Detectar arquitectura
ARCH=$(uname -m)
case $ARCH in
    x86_64)  MVND_ARCH="linux-amd64" ;;
    aarch64|arm64) MVND_ARCH="linux-aarch64" ;;
    *)       MVND_ARCH="unknown" ;;
esac

echo "💻 Arquitectura detectada: $ARCH ($MVND_ARCH)"

# Asegurar directorios base para herramientas locales
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.local/lib"

# Node.js
if command -v node >/dev/null 2>&1; then
    NODE_VERSION=$(node -v)
    echo "🟢 Node.js detectado ($NODE_VERSION)"
    if ! command -v pnpm >/dev/null 2>&1; then
        echo "📦 Instalando pnpm..."
        if command -v npm >/dev/null 2>&1; then
            # Intentar instalación global primero, si falla usar el script oficial
            run_as_root npm install -g pnpm > /dev/null 2>&1 || curl -fsSL https://get.pnpm.io/install.sh | sh - > /dev/null 2>&1 || true
        else
            curl -fsSL https://get.pnpm.io/install.sh | sh - > /dev/null 2>&1 || true
        fi
    fi
fi

# Java
if command -v java >/dev/null 2>&1; then
    JAVA_VERSION=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}')
    echo "🟢 Java detectado ($JAVA_VERSION)"
    if ! command -v mvnd >/dev/null 2>&1 && [ "$MVND_ARCH" != "unknown" ]; then
        echo "📦 Instalando mvnd (Maven Daemon) para $MVND_ARCH..."
        MVND_VERSION="1.0.2"
        # Download and extract mvnd
        curl -L "https://github.com/apache/maven-mvnd/releases/download/$MVND_VERSION/maven-mvnd-$MVND_VERSION-$MVND_ARCH.tar.gz" -o /tmp/mvnd.tar.gz > /dev/null 2>&1
        if [ $? -eq 0 ]; then
            tar -xzf /tmp/mvnd.tar.gz -C "$HOME/.local/lib" > /dev/null 2>&1
            # El nombre del directorio extraído suele ser maven-mvnd-VERSION-PLATFORM
            ln -sf "$HOME/.local/lib/maven-mvnd-$MVND_VERSION-$MVND_ARCH/bin/mvnd" "$HOME/.local/bin/mvnd"
            rm /tmp/mvnd.tar.gz
            echo "✅ mvnd instalado en $HOME/.local/bin/mvnd"
        else
            echo "⚠️ No se pudo descargar mvnd para esta arquitectura."
        fi
    fi
fi

# Asegurar que los scripts de setup sean ejecutables
chmod +x scripts/setup/*.sh

# Ejecutar configuraciones
echo "⚙️ Aplicando configuraciones..."
./scripts/setup/setup-fish-config.sh
./scripts/setup/setup-git-config.sh
./scripts/setup/setup-starship-config.sh
./scripts/setup/setup-nvim-config.sh

# Configurar fish como shell por defecto
if command -v fish >/dev/null 2>&1; then
    FISH_PATH=$(command -v fish)
    echo "🐠 Estableciendo fish como shell por defecto ($FISH_PATH)..."
    
    # Asegurar que fish está en /etc/shells
    if ! grep -q "$FISH_PATH" /etc/shells; then
        echo "$FISH_PATH" | run_as_root tee -a /etc/shells > /dev/null
    fi
    
    # Cambiar la shell del usuario actual
    run_as_root chsh -s "$FISH_PATH" "$(id -un)"
fi

mkdir $HOME/.config/obsidian # Avoid error obsdian config

echo ""
echo "✅ ¡Instalación completada con éxito!"
echo "👉 La shell por defecto ahora es fish. Reinicia tu terminal o escribe: fish"
echo "👉 Para abrir neovim: nvim"
exit 0 # Exit success for avoid errors
