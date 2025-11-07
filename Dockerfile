FROM otsugua04/alphine-nginx-base:latest

#RUN chown -R appuser:appgroup /usr/share/nginx/html

#USER appuser

# Elimina la configuración por defecto
RUN rm /etc/nginx/conf.d/default.conf

# Copia tu configuración personalizada de Nginx
COPY nginx.conf /etc/nginx/conf.d/

COPY public/ /usr/share/nginx/html

RUN mkdir -p /var/cache/nginx/client_temp \
    && chown -R nginx:nginx /var/cache/nginx

EXPOSE 80

# Inicia Nginx en modo foreground
CMD ["nginx", "-g", "daemon off;"]
