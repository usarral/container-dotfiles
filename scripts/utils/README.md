# Scripts de Utilidades

Herramientas auxiliares para mantenimiento, gestión de repositorios, testing y configuración.

## Organización

Los scripts están organizados en subcarpetas temáticas:


### ⚙️ [config/](config/)
Configuración del entorno
- `gen-env` - Generar plantillas de configuración

## Uso

Desde cualquier carpeta (una vez configurado el PATH):

```fish
# Gestión de repos
pull-all
switch-all develop
install-all

# Verificar despliegues
check-deploy


# Configuración
gen-env
```

## Instalación

Los scripts ya están accesibles desde el PATH. Para verificar:

```fish
which pull-all
which check-deploy
```
