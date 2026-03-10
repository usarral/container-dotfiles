#!/usr/bin/env bash

# Script para añadir work-scripts al PATH y crear un alias global
# Este script permite usar los scripts desde cualquier carpeta

set -e

WORK_SCRIPTS_BIN="/home/csesmau/work-scripts/bin"

echo "🔧 Configurando work-scripts en el PATH..."

# Verificar que los directorios existen
if [ ! -d "$WORK_SCRIPTS_BIN" ]; then
    echo "❌ Error: $WORK_SCRIPTS_BIN no existe"
    exit 1
fi


# Verificar si ya está en el PATH
if echo "$PATH" | grep -q "$WORK_SCRIPTS_BIN"; then
    echo "✓ $WORK_SCRIPTS_BIN ya está en el PATH"
else
    echo "✓ Añadido $WORK_SCRIPTS_BIN al PATH"
fi


echo ""
echo "📋 Scripts disponibles:"
echo ""

# Listar scripts por categoría
echo "🔧 Setup:"
ls -1 "$WORK_SCRIPTS_BIN" | grep "^setup-" | sed 's/^/   /'

echo ""

echo ""
echo "✅ Configuración completada."
echo "   Los scripts están listos para usar desde cualquier carpeta."
echo "   Recarga la configuración: source ~/.config/fish/config.fish"
