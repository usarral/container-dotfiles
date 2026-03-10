# Configuración de Starship

Prompt personalizado multi-shell con información contextual.

## Instalación

```bash
./scripts/setup/setup-starship-config.sh
```

El script crea un symlink de `starship/starship.toml` a `~/.config/starship.toml`.

## Características

Starship es un prompt rápido, personalizable y multi-shell que muestra información contextual sobre:
- Directorio actual
- Git (rama, estado, etc.)
- Lenguajes de programación y sus versiones
- Estado de comandos
- Y mucho más

## Configuración

Edita `starship/starship.toml` para personalizar el prompt. Ver [documentación oficial](https://starship.rs/config/).

## Restaurar

```bash
cd ~/work-scripts
./scripts/setup/setup-starship-config.sh
```
