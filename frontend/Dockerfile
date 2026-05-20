# Frontend Dockerfile - Nginx based
# Build a lightweight production image for the frontend

FROM nginx:latest

# Remove default nginx config
RUN rm /etc/nginx/conf.d/default.conf

# Copy static files to nginx
COPY index.html /usr/share/nginx/html/
COPY style.css /usr/share/nginx/html/
COPY script.js /usr/share/nginx/html/

# Create custom nginx config for SPA support
RUN echo 'server { \
    listen 80; \
    server_name _; \
    root /usr/share/nginx/html; \
    index index.html; \
    \
    location / { \
        try_files $uri $uri/ /index.html; \
    } \
    \
    error_page 404 /index.html; \
}' > /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
