 bin/bash/!#
set -e

echo "===================================="
echo " 🚀 VPN Panel Installer - abbasai2020 "
echo "===================================="

# Update system
apt update -y && apt upgrade -y

# Install dependencies
apt install -y curl git unzip python3 python3-pip docker.io docker-compose nginx

# Install directory
INSTALL_DIR="/opt/vpn-panel"

# Clone project if not exists
if [ ! -d "$INSTALL_DIR" ]; then
    git clone https://github.com/abbasai2020/vpn-panel.git $INSTALL_DIR
else
    echo "📂 Project already exists in $INSTALL_DIR, skipping clone."
fi

# Python requirements
if [ -f "$INSTALL_DIR/requirements.txt" ]; then
    pip3 install -r $INSTALL_DIR/requirements.txt
else
    echo "⚠️ No requirements.txt found, skipping Python dependencies."
fi

# Nginx config placeholder
if [ -f "$INSTALL_DIR/nginx.conf" ]; then
    cp $INSTALL_DIR/nginx.conf /etc/nginx/sites-enabled/vpn-panel.conf
    systemctl restart nginx
else
    echo "⚠️ No nginx.conf found, skipping Nginx setup."
fi

# Docker compose
if [ -f "$INSTALL_DIR/docker-compose.yml" ]; then
    cd $INSTALL_DIR
    docker-compose up -d
else
    echo "⚠️ No docker-compose.yml found, skipping Docker setup."
fi

echo "✅ Installation finished!"
echo "------------------------------------"
echo " Panel directory: $INSTALL_DIR"
echo " Run panel manually with: python3 app.py"
