#!/bin/bash
set -e

echo "===================================="
echo " 🚀 VPN Panel Installer - abbasai2020"
echo "===================================="

# Update system
apt update -y && apt upgrade -y

# Install dependencies
apt install -y curl git unzip python3 python3-pip docker.io docker-compose nginx

# Clone project (if not already cloned)
INSTALL_DIR="/opt/vpn-panel"
if [ ! -d "$INSTALL_DIR" ]; then
    git clone https://github.com/abbasai2020/vpn-panel.git $INSTALL_DIR
fi

# Setup python requirements
pip3 install -r $INSTALL_DIR/requirements.txt || echo "No requirements.txt found, skipping."

# Setup nginx config (placeholder)
cp $INSTALL_DIR/nginx.conf /etc/nginx/sites-enabled/vpn-panel.conf || echo "No nginx.conf found, skipping."
systemctl restart nginx

# Create systemd service
cat > /etc/systemd/system/vpn-panel.service <<EOF
[Unit]
Description=VPN Panel Flask App
After=network.target

[Service]
User=root
WorkingDirectory=/opt/vpn-panel
ExecStart=/usr/bin/python3 /opt/vpn-panel/app.py
Restart=always

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable vpn-panel
systemctl start vpn-panel

echo "===================================="
echo " ✅ Installation Finished!"
echo " Panel running as a systemd service."
echo "===================================="
