#!/usr/bin/env bash

# Script para crear symlink de la configuración de Starship
# Este script enlaza starship.toml desde este repositorio a ~/.config/starship.toml

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
STARSHIP_TARGET="$HOME/.config/starship.toml"
REPO_STARSHIP="$REPO_ROOT/starship/starship.toml"

echo "⭐ Configurando Starship..."

# Verificar que existe el archivo en el repo
if [ ! -f "$REPO_STARSHIP" ]; then
    echo "❌ Error: No se encuentra starship/starship.toml en el repositorio"
    exit 1
fi

# Si existe starship.toml, hacer backup
if [ -e "$STARSHIP_TARGET" ]; then
    BACKUP_FILE="$HOME/.config/starship.toml.backup.$(date +%Y%m%d_%H%M%S)"
    echo "📦 Haciendo backup de starship.toml actual en: $BACKUP_FILE"
    mv "$STARSHIP_TARGET" "$BACKUP_FILE"
fi

# Crear el directorio si no existe
mkdir -p "$(dirname "$STARSHIP_TARGET")"

# Crear el symlink
echo "🔗 Creando symlink de $REPO_STARSHIP a $STARSHIP_TARGET"
ln -sf "$REPO_STARSHIP" "$STARSHIP_TARGET"

echo "✅ Configuración de Starship instalada correctamente"
echo ""
echo "La configuración de Starship ahora apunta a: $REPO_STARSHIP"
echo "Cualquier cambio en el repositorio se reflejará automáticamente"
