# Config Scripts

Scripts para configuración del entorno de desarrollo.

## Scripts Disponibles

- **generate-env-template.sh** - Genera plantillas de archivos `.env` con las variables necesarias

## Uso

```fish
# Generar plantilla de configuración
gen-env

# Con nombre de archivo personalizado
gen-env --output .env.custom

# Para un servicio específico
gen-env --service tramitacio
```

## Propósito

Automatizar la creación de archivos de configuración con:
- Variables de entorno necesarias
- Valores por defecto
- Documentación de cada variable
- Validación de requerimientos
