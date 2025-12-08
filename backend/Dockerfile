# Multi-stage build para optimizar el tamaño de la imagen final

# Stage 1: Build stage - Compilar la aplicación
FROM maven:3.9-eclipse-temurin-21 AS build

WORKDIR /app

# Copiar archivos de configuración de Maven primero (para aprovechar cache de Docker)
COPY pom.xml .
COPY .mvn .mvn
COPY mvnw .

# Descargar dependencias (esta capa se cachea si pom.xml no cambia)
RUN mvn dependency:go-offline -B

# Copiar el código fuente
COPY src ./src

# Compilar y empaquetar la aplicación (excluyendo tests para producción)
RUN mvn clean package -DskipTests -B

# Stage 2: Runtime stage - Imagen final ligera para producción
FROM eclipse-temurin:21-jre-alpine

# Instalar dependencias necesarias y limpiar cache
RUN apk add --no-cache \
    tzdata \
    curl \
    && rm -rf /var/cache/apk/*

# Crear usuario no-root para ejecutar la aplicación (mejores prácticas de seguridad)
RUN addgroup -S springboot && adduser -S springboot -G springboot


ENV TZ={{ TIMEZONE }}
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Crear directorio de trabajo
WORKDIR /app

# Copiar el JAR desde el stage de build
COPY --from=build /app/target/*.jar app.jar

# Cambiar ownership de los archivos al usuario springboot
RUN chown -R springboot:springboot /app

# Cambiar al usuario no-root
USER springboot

# Exponer el puerto de la aplicación
EXPOSE 8080

# Variables de entorno por defecto (pueden ser sobrescritas en docker-compose o kubernetes)
ENV JAVA_OPTS="-XX:+UseContainerSupport -XX:MaxRAMPercentage=75.0 -XX:+UseG1GC -XX:+UseStringDeduplication"

# Health check para monitoreo (usando endpoint público disponible)
HEALTHCHECK --interval=30s --timeout=3s --start-period=40s --retries=3 \
    CMD curl -f http://localhost:8080/public/started || exit 1

# Punto de entrada optimizado para contenedores
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
