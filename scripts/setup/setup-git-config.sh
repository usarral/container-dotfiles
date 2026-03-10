#!/usr/bin/env bash

# Script para crear symlink de la configuración de git
# Este script enlaza .gitconfig desde este repositorio a ~/.gitconfig

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
GITCONFIG_TARGET="$HOME/.gitconfig"
REPO_GITCONFIG="$REPO_ROOT/git/.gitconfig"

echo "🔧 Configurando Git..."

# Verificar que existe el archivo en el repo
if [ ! -f "$REPO_GITCONFIG" ]; then
    echo "❌ Error: No se encuentra git/.gitconfig en el repositorio"
    exit 1
fi

# Si existe .gitconfig, hacer backup
if [ -e "$GITCONFIG_TARGET" ]; then
    BACKUP_FILE="$HOME/.gitconfig.backup.$(date +%Y%m%d_%H%M%S)"
    echo "📦 Haciendo backup de .gitconfig actual en: $BACKUP_FILE"
    mv "$GITCONFIG_TARGET" "$BACKUP_FILE"
fi

# Crear el symlink
echo "🔗 Creando symlink de $REPO_GITCONFIG a $GITCONFIG_TARGET"
ln -sf "$REPO_GITCONFIG" "$GITCONFIG_TARGET"

echo "✅ Configuración de Git instalada correctamente"
echo ""
echo "La configuración de Git ahora apunta a: $REPO_GITCONFIG"
echo "Cualquier cambio en el repositorio se reflejará automáticamente"
echo ""
echo "⚠️  IMPORTANTE: Verifica tus credenciales y datos personales en:"
echo "   git/.gitconfig"
