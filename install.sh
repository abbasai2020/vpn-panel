   bin/bash/!#
set -e

echo "===================================="
echo " 🚀 VPN Panel Auto Installer - abbasai2020 "
echo "===================================="

# Step 1: Update system
echo "[*] Updating system..."
apt update -y && apt upgrade -y

# Step 2: Install dependencies
echo "[*] Installing dependencies..."
apt install -y curl git unzip python3 python3-pip nginx docker.io docker-compose

# Step 3: Define install directory
INSTALL_DIR="/opt/vpn-panel"

# Step 4: Clone or update repo
if [ ! -d "$INSTALL_DIR" ]; then
    echo "[*] Cloning vpn-panel repo..."
    git clone https://github.com/abbasai2020/vpn-panel.git $INSTALL_DIR
else
    echo "[*] Updating existing vpn-panel repo..."
    cd $INSTALL_DIR && git pull
fi

# Step 5: Python requirements
if [ -f "$INSTALL_DIR/requirements.txt" ]; then
    echo "[*] Installing Python packages..."
    pip3 install -r $INSTALL_DIR/requirements.txt
else
    echo "⚠️ No requirements.txt found, skipping Python deps."
fi

# Step 6: Setup Nginx
if [ -f "$INSTALL_DIR/nginx.conf" ]; then
    echo "[*] Setting up Nginx..."
    cp $INSTALL_DIR/nginx.conf /etc/nginx/sites-enabled/vpn-panel.conf
    systemctl restart nginx
else
    echo "⚠️ No nginx.conf found, skipping Nginx."
fi

# Step 7: Docker Compose (if available)
if [ -f "$INSTALL_DIR/docker-compose.yml" ]; then
    echo "[*] Running docker-compose..."
    cd $INSTALL_DIR
    docker-compose up -d
else
    echo "⚠️ No docker-compose.yml found, skipping Docker."
fi

# Step 8: Systemd service for panel
echo "[*] Creating systemd service..."
cat > /etc/systemd/system/vpn-panel.service <<EOF
[Unit]
Description=VPN Panel Flask App
After=network.target

[Service]
User=root
WorkingDirectory=$INSTALL_DIR
ExecStart=/usr/bin/python3 $INSTALL_DIR/app.py
Restart=always

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable vpn-panel
systemctl restart vpn-panel

echo "===================================="
echo " ✅ Installation Finished!"
echo " 🌐 Access your panel at: https://<your-domain>/panel"
echo " 🛠 Service managed with: systemctl status vpn-panel"
echo "===================================="
