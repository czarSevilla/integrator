#!/bin/bash
set -e

# Directorio del tablespace
TABLESPACE_DIR="{{ DB_KEYCLOAK_TABLESPACE_LOCATION }}"

echo "=========================================="
echo "Verificando directorio del tablespace"
echo "Ruta: $TABLESPACE_DIR"
echo "=========================================="

# Verificar que el directorio existe
if [ ! -d "$TABLESPACE_DIR" ]; then
    echo "ERROR: El directorio del tablespace no existe: $TABLESPACE_DIR"
    echo "El servicio init-tablespace debería haberlo creado."
    exit 1
fi

# Verificar permisos del directorio
CURRENT_OWNER=$(stat -c '%U:%G (%u:%g)' "$TABLESPACE_DIR" 2>/dev/null || stat -f '%Su:%Sg (%u:%g)' "$TABLESPACE_DIR" 2>/dev/null)
echo "Propietario actual: $CURRENT_OWNER"

# Verificar que el directorio esté vacío (requisito de PostgreSQL)
if [ "$(ls -A $TABLESPACE_DIR 2>/dev/null)" ]; then
    echo "ADVERTENCIA: El directorio no está vacío. PostgreSQL requiere un directorio vacío para crear el tablespace."
    echo "Contenido del directorio:"
    ls -la "$TABLESPACE_DIR"
    echo "Limpiando el directorio..."
    rm -rf "$TABLESPACE_DIR"/*
    echo "Directorio limpiado."
else
    echo "El directorio está vacío (correcto para crear el tablespace)"
fi

# Verificar que el usuario postgres puede escribir en el directorio
if [ -w "$TABLESPACE_DIR" ]; then
    echo "El usuario postgres tiene permisos de escritura en el directorio."
else
    echo "ERROR: El usuario postgres NO tiene permisos de escritura en el directorio."
    echo "Verifica que el servicio init-tablespace se ejecutó correctamente."
    exit 1
fi

echo "=========================================="
echo "Verificación completada:"
echo "  Directorio: $TABLESPACE_DIR"
echo "  Estado: Listo para crear el tablespace"
echo "=========================================="

