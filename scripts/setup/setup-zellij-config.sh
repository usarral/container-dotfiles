#!/usr/bin/env bash

# Script para crear symlink de la configuración de Zellij
# Este script enlaza la configuración de zellij desde este repositorio
# a la ubicación esperada por zellij (~/.config/zellij)

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
ZELLIJ_CONFIG_DIR="$HOME/.config/zellij"
REPO_ZELLIJ_DIR="$REPO_ROOT/zellij"

echo "📟 Configurando Zellij..."

# Verificar que existe el directorio en el repo
if [ ! -d "$REPO_ZELLIJ_DIR" ]; then
    echo "❌ Error: No se encuentra el directorio zellij/ en el repositorio"
    exit 1
fi

# Si existe el directorio de zellij, hacer backup
if [ -e "$ZELLIJ_CONFIG_DIR" ]; then
    BACKUP_DIR="$HOME/.config/zellij.backup.$(date +%Y%m%d_%H%M%S)"
    echo "📦 Haciendo backup de la configuración actual en: $BACKUP_DIR"
    mv "$ZELLIJ_CONFIG_DIR" "$BACKUP_DIR"
fi

# Crear el directorio padre si no existe
mkdir -p "$(dirname "$ZELLIJ_CONFIG_DIR")"

# Crear el symlink
echo "🔗 Creando symlink de $REPO_ZELLIJ_DIR a $ZELLIJ_CONFIG_DIR"
ln -sf "$REPO_ZELLIJ_DIR" "$ZELLIJ_CONFIG_DIR"

echo "✅ Configuración de Zellij instalada correctamente"
echo ""
echo "La configuración de Zellij ahora apunta a: $REPO_ZELLIJ_DIR"
echo "Cualquier cambio en el repositorio se reflejará automáticamente"
