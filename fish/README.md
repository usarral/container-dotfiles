# Fish Shell Configuration

Esta carpeta contiene toda la configuración de Fish Shell.

## Instalación

Para crear el symlink y usar esta configuración:

```bash
./setup-fish-config.sh
```

El script:
1. Hace backup de tu configuración actual de fish (si existe)
2. Crea un symlink de `~/work-scripts/fish` a `~/.config/fish`
3. Los cambios en este repositorio se reflejarán automáticamente

## Estructura

- `config.fish` - Configuración principal
- `conf.d/` - Archivos de configuración adicionales (se cargan automáticamente)
- `functions/` - Funciones personalizadas de fish
- `completions/` - Completados personalizados
- `fish_plugins` - Lista de plugins instalados con fisher
- `fish_variables` - Variables universales de fish
- `themes/` - Temas personalizados

## Nota

Después de ejecutar el script de instalación, cualquier cambio que hagas en `~/.config/fish` 
estará modificando los archivos en este repositorio, permitiendo versionar tu configuración.
