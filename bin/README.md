# Work Scripts - Ejecutables

Este directorio contiene enlaces simbólicos a todos los scripts de work-scripts, permitiendo ejecutarlos desde cualquier ubicación sin necesidad de navegar a la carpeta.

## Instalación

Los scripts ya están añadidos al PATH de fish (`/home/csesmau/work-scripts/fish/conf.d/path.fish`). 

Para activar los cambios, recarga la configuración:
```fish
source ~/.config/fish/config.fish
```

## Scripts Disponibles

### Setup (configuración de herramientas)
- `setup-fish` - Configura la shell fish
- `setup-git` - Configura Git
- `setup-nvim` - Configura Neovim
- `setup-starship` - Configura Starship prompt
- `setup-zellij` - Configura Zellij
- `install-butler-ci` - Instala Butler CI CLI


## Uso Desde Cualquier Carpeta

Una vez recargada la configuración, puedes usar los scripts directamente:

```fish
# Ejemplo
setup-fish
pull-all
check-deploy
```

## Estructura Original

Los scripts se encuentran organizados en:
- `../scripts/setup/` - Scripts de configuración
- `../scripts/utils/` - Scripts de utilidades
