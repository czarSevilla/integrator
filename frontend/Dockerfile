# Stage 1: Build
FROM node:20-alpine AS builder

# Establecer directorio de trabajo
WORKDIR /app

# Copiar archivos de dependencias
COPY package*.json ./

# Instalar dependencias
RUN npm ci --only=production=false

# Copiar código fuente
COPY . .

# Construir la aplicación para producción
RUN npm run build -- --configuration production

# Stage 2: Production
FROM nginx:1.25-alpine

# Instalar tzdata para configuración de zona horaria
RUN apk add --no-cache tzdata && rm -rf /var/cache/apk/*


# ENV TZ={{ TIMEZONE }}
#RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Copiar archivos construidos desde el stage de build
COPY --from=builder /app/dist/ps-frontend-app/browser /usr/share/nginx/html

# Copiar configuración personalizada de nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Exponer puerto 80
EXPOSE 80

# Comando para iniciar nginx
CMD ["nginx", "-g", "daemon off;"]
