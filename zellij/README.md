# Configuración de Zellij

Multiplexor de terminal moderno y configurable.

## Instalación

```bash
./scripts/setup/setup-zellij-config.sh
```

El script crea un symlink de `zellij/` a `~/.config/zellij/`.

## Contenido

- **`config.kdl`** - Configuración principal con keybindings personalizados
- **`layouts/`** - Layouts predefinidos para distintos flujos de trabajo
- **`plugins/`** - Plugins de Zellij

## Características

Zellij es un multiplexor de terminal que permite:
- Múltiples paneles y tabs en una terminal
- Keybindings personalizables
- Layouts guardables
- Sesiones persistentes
- Plugins extensibles

## Configuración

Los keybindings personalizados están en `config.kdl`. Principales modos:
- **Locked**: Modo normal (Ctrl+g para cambiar)
- **Pane**: Gestión de paneles (hjkl para navegar)
- **Tab**: Gestión de tabs
- **Scroll**: Navegación de scroll

## Restaurar

```bash
cd ~/work-scripts
./scripts/setup/setup-zellij-config.sh
```
