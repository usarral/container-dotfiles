#!/usr/bin/env bash

# Script para generar env.fish.example desde env.fish
# Elimina valores sensibles dejando solo los nombres de variables

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
ENV_FILE="$REPO_ROOT/fish/conf.d/env.fish"
TEMPLATE_FILE="$REPO_ROOT/fish/conf.d/env.fish.example"

echo "📝 Generando template de variables de entorno..."

if [ ! -f "$ENV_FILE" ]; then
    echo "❌ Error: No se encuentra $ENV_FILE"
    exit 1
fi

# Crear el archivo de ejemplo reemplazando valores por placeholders
{
    echo "# Configuración de variables de entorno"
    echo "# Copia este archivo a env.fish y configura tus valores reales"
    echo ""
    
    # Procesar cada línea del archivo original
    while IFS= read -r line; do
        # Si es un comentario o línea vacía, copiarla tal cual
        if [[ "$line" =~ ^[[:space:]]*# ]] || [[ -z "${line// }" ]]; then
            echo "$line"
        # Si es una línea con set -gx, reemplazar el valor
        elif [[ "$line" =~ ^set[[:space:]]+-gx[[:space:]]+([A-Z_]+)[[:space:]]+ ]]; then
            var_name="${BASH_REMATCH[1]}"
            echo "set -gx $var_name \"YOUR_${var_name}_HERE\""
        else
            echo "$line"
        fi
    done < "$ENV_FILE"
} > "$TEMPLATE_FILE"

echo "✅ Template generado en: $TEMPLATE_FILE"
echo ""
echo "Para restaurar:"
echo "  cp fish/conf.d/env.fish.example fish/conf.d/env.fish"
echo "  # Luego edita env.fish con tus valores reales"
