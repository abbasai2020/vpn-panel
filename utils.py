import json, os, qrcode

CONFIG_DIR = "/opt/configs/"

def save_config(name, content):
    path = os.path.join(CONFIG_DIR, name)
    with open(path, "w") as f:
        f.write(content)
    return path

def generate_qr(data, filename):
    img = qrcode.make(data)
    qr_path = os.path.join(CONFIG_DIR, filename)
    img.save(qr_path)
    return qr_path

def create_reality_config(user="user1", server="net.abbasai.fun", port=443):
    config = {"server": f"{server}:{port}", "protocol": "reality", "user": user, "uuid": "auto"}
    text = json.dumps(config, indent=2)
    filename = f"reality-{user}.json"
    save_config(filename, text)
    qrfile = generate_qr(text, f"reality-{user}.png")
    return text, qrfile

def create_hysteria2_config(user="user1", server="net.abbasai.fun", port=8443, password="133"):
    config = {"server": f"{server}:{port}", "protocol": "hysteria2", "password": password, "user": user}
    text = json.dumps(config, indent=2)
    filename = f"hysteria2-{user}.json"
    save_config(filename, text)
    qrfile = generate_qr(text, f"hysteria2-{user}.png")
    return text, qrfile

def create_tuic_config(user="user1", server="net.abbasai.fun", port=4443, password="233"):
    config = {"server": f"{server}:{port}", "protocol": "tuic", "password": password, "user": user}
    text = json.dumps(config, indent=2)
    filename = f"tuic-{user}.json"
    save_config(filename, text)
    qrfile = generate_qr(text, f"tuic-{user}.png")
    return text, qrfile

def create_outline_key(api_url, cert_sha):
    key = f"outline://{api_url}?cert={cert_sha}"
    filename = "outline-key.txt"
    save_config(filename, key)
    qrfile = generate_qr(key, "outline.png")
    return key, qrfile
