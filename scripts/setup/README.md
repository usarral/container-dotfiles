# Scripts de Setup

Scripts para instalar y configurar herramientas del entorno de desarrollo.

## Scripts Disponibles

### `install-butler-ci-cli.sh`
Instala Butler CI CLI, herramienta de integración continua.

```bash
./install-butler-ci-cli.sh
```

### `setup-fish-config.sh`
Configura Fish Shell creando un symlink desde el repositorio a `~/.config/fish`.

```bash
./setup-fish-config.sh
```

**Características:**
- Hace backup automático de configuración existente
- Crea symlink para versionar la configuración
- Los cambios se reflejan automáticamente

### `setup-git-config.sh`
Configura Git creando un symlink desde el repositorio a `~/.gitconfig`.

```bash
./setup-git-config.sh
```

**Características:**
- Hace backup automático de .gitconfig existente
- Crea symlink para versionar la configuración
- Centraliza la configuración de Git

### `setup-starship-config.sh`
Configura Starship creando un symlink desde el repositorio a `~/.config/starship.toml`.

```bash
./setup-starship-config.sh
```

### `setup-zellij-config.sh`
Configura Zellij creando un symlink desde el repositorio a `~/.config/zellij`.

```bash
./setup-zellij-config.sh
```

### `setup-nvim-config.sh`
Configura Neovim creando un symlink desde el repositorio a `~/.config/nvim`.

```bash
./setup-nvim-config.sh
```

## Uso

Ejecutar desde la raíz del repositorio:

```bash
./scripts/setup/install-butler-ci-cli.sh
./scripts/setup/setup-fish-config.sh
./scripts/setup/setup-git-config.sh
./scripts/setup/setup-starship-config.sh
./scripts/setup/setup-zellij-config.sh
./scripts/setup/setup-nvim-config.sh
```
