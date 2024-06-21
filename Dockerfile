# Usa una imagen base de Nginx
FROM nginx:latest

# Copia tu archivo index.html al directorio de contenido web de Nginx
COPY index.html /usr/share/nginx/html/index.html

# Exponer el puerto 80 para el servidor web
EXPOSE 80
