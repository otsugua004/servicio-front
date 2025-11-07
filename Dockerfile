FROM otsugua04/alphine-nginx-base:latest

#RUN chown -R appuser:appgroup /usr/share/nginx/html

#USER appuser

# Elimina la configuración por defecto
RUN rm /etc/nginx/conf.d/default.conf

# Copia tu configuración personalizada de Nginx
COPY nginx.conf /etc/nginx/conf.d/

COPY public/ /usr/share/nginx/html

# Crea todos los directorios temporales requeridos por Nginx
RUN mkdir -p /var/cache/nginx \
    /var/cache/nginx/client_temp \
    /var/cache/nginx/fastcgi_temp \
    /var/cache/nginx/proxy_temp \
    /var/cache/nginx/scgi_temp \
    /var/cache/nginx/uwsgi_temp \
    && chown -R nginx:nginx /var/cache/nginx \
    && chown -R nginx:nginx /usr/share/nginx/html



# Cambia al usuario nginx para todas las instrucciones siguientes
USER nginx

EXPOSE 80

# Inicia Nginx en modo foreground
CMD ["nginx", "-g", "daemon off;"]
