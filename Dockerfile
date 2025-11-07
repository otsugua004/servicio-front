FROM otsugua04/alphine-nginx-base:latest

# Elimina configuración por defecto
RUN rm /etc/nginx/conf.d/default.conf

# Copia configuración principal y por servidor
COPY nginx.conf /etc/nginx/nginx.conf
COPY conf.d/default.conf /etc/nginx/conf.d/default.conf

# Copia archivos estáticos del frontend
COPY public/ /usr/share/nginx/html

# Crea y da permisos a todos los directorios temporales
RUN mkdir -p /var/cache/nginx/client_temp \
    /var/cache/nginx/fastcgi_temp \
    /var/cache/nginx/proxy_temp \
    /var/cache/nginx/scgi_temp \
    /var/cache/nginx/uwsgi_temp \
    /tmp \
    && chown -R nginx:nginx /var/cache/nginx /usr/share/nginx/html /tmp

# Usa el usuario nginx (no root)
USER nginx

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]

