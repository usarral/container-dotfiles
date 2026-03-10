#!/usr/bin/env bash

# Script para crear symlink de la configuración de Neovim
# Este script enlaza la configuración de nvim desde este repositorio
# a la ubicación esperada por neovim (~/.config/nvim)

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
NVIM_CONFIG_DIR="$HOME/.config/nvim"
REPO_NVIM_DIR="$REPO_ROOT/nvim"

echo "💻 Configurando Neovim..."

# Verificar que existe el directorio en el repo
if [ ! -d "$REPO_NVIM_DIR" ]; then
    echo "❌ Error: No se encuentra el directorio nvim/ en el repositorio"
    exit 1
fi

# Si existe el directorio de nvim, hacer backup
if [ -e "$NVIM_CONFIG_DIR" ]; then
    BACKUP_DIR="$HOME/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)"
    echo "📦 Haciendo backup de la configuración actual en: $BACKUP_DIR"
    mv "$NVIM_CONFIG_DIR" "$BACKUP_DIR"
fi

# Crear el directorio padre si no existe
mkdir -p "$(dirname "$NVIM_CONFIG_DIR")"

# Crear el symlink
echo "🔗 Creando symlink de $REPO_NVIM_DIR a $NVIM_CONFIG_DIR"
ln -sf "$REPO_NVIM_DIR" "$NVIM_CONFIG_DIR"

echo "✅ Configuración de Neovim instalada correctamente"
echo ""
echo "La configuración de Neovim ahora apunta a: $REPO_NVIM_DIR"
echo "Cualquier cambio en el repositorio se reflejará automáticamente"
echo ""
echo "ℹ️  Al abrir Neovim por primera vez, se instalarán los plugins automáticamente"
