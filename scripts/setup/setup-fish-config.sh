#!/usr/bin/env bash

# Script para crear symlink de la configuración de fish
# Este script enlaza la configuración de fish desde este repositorio
# a la ubicación esperada por fish (~/.config/fish)

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
FISH_CONFIG_DIR="$HOME/.config/fish"
REPO_FISH_DIR="$REPO_ROOT/fish"

echo "🐟 Configurando Fish Shell..."

# Verificar que existe el directorio en el repo
if [ ! -d "$REPO_FISH_DIR" ]; then
    echo "❌ Error: No se encuentra el directorio fish/ en el repositorio"
    exit 1
fi

# Si existe el directorio de fish, hacer backup
if [ -e "$FISH_CONFIG_DIR" ]; then
    BACKUP_DIR="$HOME/.config/fish.backup.$(date +%Y%m%d_%H%M%S)"
    echo "📦 Haciendo backup de la configuración actual en: $BACKUP_DIR"
    mv "$FISH_CONFIG_DIR" "$BACKUP_DIR"
fi

# Crear el directorio padre si no existe
mkdir -p "$(dirname "$FISH_CONFIG_DIR")"

# Crear el symlink
echo "🔗 Creando symlink de $REPO_FISH_DIR a $FISH_CONFIG_DIR"
ln -sf "$REPO_FISH_DIR" "$FISH_CONFIG_DIR"

echo "✅ Configuración de Fish instalada correctamente"
echo ""
echo "La configuración de Fish ahora apunta a: $REPO_FISH_DIR"
echo "Cualquier cambio en el repositorio se reflejará automáticamente"
