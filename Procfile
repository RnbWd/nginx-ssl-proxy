nginx: nginx
dockergen: docker-gen -watch -only-exposed -notify "nginx -s reload" /app/nginx.tmpl /etc/nginx/sites-enabled/default /etc/nginx/certs/server.key /etc/nginx/certs/server.crt
