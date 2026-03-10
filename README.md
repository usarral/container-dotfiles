# work-scripts

Scripts y configuraciones para automatizar tareas de trabajo.

## 📁 Estructura

```
.
├── scripts/
│   ├── setup/        # Scripts de instalación y configuración
│   └── utils/        # Utilidades generales
├── fish/             # Configuración de Fish Shell
├── git/              # Configuración de Git
├── starship/         # Configuración de Starship (prompt)
├── zellij/           # Configuración de Zellij (multiplexor)
├── nvim/             # Configuración de Neovim
└── .github/          # Configuración de GitHub
```

## 🚀 Scripts Disponibles

### Instalación y Configuración (`scripts/setup/`)
- **`install-butler-ci-cli.sh`** - Instala Butler CI CLI
- **`setup-fish-config.sh`** - Configura Fish Shell mediante symlink
- **`setup-git-config.sh`** - Configura Git mediante symlink
- **`setup-starship-config.sh`** - Configura Starship mediante symlink
- **`setup-zellij-config.sh`** - Configura Zellij mediante symlink
- **`setup-nvim-config.sh`** - Configura Neovim mediante symlink

### Utilidades (`scripts/utils/`)
- **`generate-env-template.sh`** - Genera template de variables de entorno

## 🐟 Configuración de Fish Shell

### Instalación Rápida

```bash
./scripts/setup/setup-fish-config.sh
```

Esto creará un symlink de `fish/` a `~/.config/fish`, permitiendo versionar tu configuración.

### Estructura de Fish

- `fish/config.fish` - Configuración principal
- `fish/conf.d/` - Configuraciones adicionales (carga automática)
- `fish/functions/` - Funciones personalizadas
- `fish/completions/` - Completados personalizados
- `fish/fish_plugins` - Plugins instalados con fisher

Ver [fish/README.md](fish/README.md) para más detalles.

## 🔧 Configuración de Git

### Instalación Rápida

```bash
./scripts/setup/setup-git-config.sh
```

Esto creará un symlink de `git/.gitconfig` a `~/.gitconfig`, permitiendo versionar tu configuración de Git.

⚠️ **Importante:** Revisa y ajusta los datos personales (nombre, email, credenciales) después de la instalación.

Ver [git/README.md](git/README.md) para más detalles.

## ⭐ Configuración de Starship

```bash
./scripts/setup/setup-starship-config.sh
```

Prompt personalizado multi-shell. Ver [starship/README.md](starship/README.md).

## 📟 Configuración de Zellij

```bash
./scripts/setup/setup-zellij-config.sh
```

Multiplexor de terminal moderno. Ver [zellij/README.md](zellij/README.md).

## 💻 Configuración de Neovim

```bash
./scripts/setup/setup-nvim-config.sh
```

Configuración personalizada con Lazy.nvim. Ver [nvim/README.md](nvim/README.md).

### Variables de Entorno

Las variables sensibles se configuran en `fish/conf.d/env.fish` (no versionado):

```bash
# 1. Copiar el template
cp fish/conf.d/env.fish.example fish/conf.d/env.fish

# 2. Editar con tus valores reales
nano fish/conf.d/env.fish

# 3. Regenerar template si añades variables
./scripts/utils/generate-env-template.sh
```

## 📝 Notas

- Los scripts asumen que estás usando Fish Shell
- Ejecuta los scripts desde la raíz del repositorio
- `env.fish` está en `.gitignore` para proteger credenciales
