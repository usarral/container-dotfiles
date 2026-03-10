# Configuración de Git

Este directorio contiene la configuración global de Git.

## Archivos

- **`.gitconfig`** - Configuración global de Git

## Instalación

Para crear el symlink y usar esta configuración:

```bash
./scripts/setup/setup-git-config.sh
```

El script:
1. Hace backup de tu `.gitconfig` actual (si existe)
2. Crea un symlink de `git/.gitconfig` a `~/.gitconfig`
3. Los cambios en el repositorio se reflejan automáticamente

## Configuración Incluida

- **Credenciales** - Configuración de almacenamiento de credenciales
- **Usuario** - Nombre y email del autor
- **Editor** - Editor predeterminado (nvim)
- **Delta** - Pager mejorado para diffs
- **Push/Pull** - Comportamiento automático de ramas remotas

## ⚠️ Importante

Revisa y ajusta los datos personales en `.gitconfig`:
- `user.name`
- `user.email`
- Credenciales específicas de tu empresa

## Restaurar en un nuevo equipo

```bash
# Clonar el repositorio
git clone <repo-url> ~/work-scripts

# Instalar la configuración
cd ~/work-scripts
./scripts/setup/setup-git-config.sh
```
