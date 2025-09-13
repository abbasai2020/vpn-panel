from flask import Flask, jsonify, request
import utils, os

app = Flask(__name__)

@app.route("/")
def index():
    return "✅ VPN Panel API is running"

@app.route("/create/reality")
def create_reality():
    user = request.args.get("user", "user1")
    cfg, qr = utils.create_reality_config(user)
    return jsonify({"config": cfg, "qr": qr})

@app.route("/create/hysteria2")
def create_hysteria2():
    user = request.args.get("user", "user1")
    cfg, qr = utils.create_hysteria2_config(user)
    return jsonify({"config": cfg, "qr": qr})

@app.route("/create/tuic")
def create_tuic():
    user = request.args.get("user", "user1")
    cfg, qr = utils.create_tuic_config(user)
    return jsonify({"config": cfg, "qr": qr})

@app.route("/create/outline")
def create_outline():
    api_url = os.getenv("OUTLINE_API_URL")
    cert = os.getenv("OUTLINE_API_CERT_SHA256")
    key, qr = utils.create_outline_key(api_url, cert)
    return jsonify({"key": key, "qr": qr})

if __name__ == "__main__":
    app.run(host="127.0.0.1", port=23111)
