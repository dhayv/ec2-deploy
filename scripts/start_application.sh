#!/bin/bash
sudo cat > cd /etc/nginx/sites-enabled/default << 'EOF'
server {
    listen 80;
    server_name _;

    root /var/www/html;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }
}
EOF

# Restart nginx
sudo systemctl restart nginx