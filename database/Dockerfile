FROM postgres:17.7

# Instalar locales necesarios para México
RUN apt-get update && \
    apt-get install -y --no-install-recommends locales && \
    sed -i '/es_MX.UTF-8/s/^# //g' /etc/locale.gen || echo "es_MX.UTF-8 UTF-8" >> /etc/locale.gen && \
    locale-gen es_MX.UTF-8 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Verificar que el locale esté disponible
RUN locale -a | grep -i es_mx || (echo "ERROR: Locale es_MX.UTF-8 no encontrado" && locale -a && exit 1)

# Establecer variables de entorno para los locales
ENV LANG=es_MX.UTF-8
ENV LC_ALL=es_MX.UTF-8

