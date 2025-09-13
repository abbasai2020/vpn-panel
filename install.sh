#!/bin/bash
set -e

echo "=============================="
echo "   AbbasAI VPN Panel Setup    "
echo "=============================="

# 1. Update system
echo "[*] Updating system packages..."
apt update -y && apt upgrade -y

# 2. Install dependencies
echo "[*] Installing dependencies..."
apt install -y curl wget git jq nano socat

# 3. Install Xray (base)
echo "[*] Installing Xray core..."
bash <(curl -Ls https://raw.githubusercontent.com/XTLS/Xray-install/main/install-release.sh) install

# 4. Create config directories
echo "[*] Creating config directories..."
mkdir -p /opt/configs/reality
mkdir -p /opt/configs/hysteria1
mkdir -p /opt/configs/hysteria2

# 5. Create panel placeholder
echo "[*] Creating panel placeholder..."
mkdir -p /opt/vpn-panel
echo "Panel coming soon..." > /opt/vpn-panel/index.html

# 6. Done
echo "=============================="
echo "✅ Base setup complete!"
echo "You can now start adding protocol modules (Reality, Hysteria, etc.)"
echo "=============================="
