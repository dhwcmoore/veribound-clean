from flask import Flask, request, jsonify
from flask_cors import CORS
import hashlib
import hmac
import json
import os
from datetime import datetime
from template_loader import load_verified_template

app = Flask(__name__)
CORS(app)

LICENSE_KEY = os.environ.get("VERIBOUND_LICENSE_KEY", "demo_secret_key")
LOG_DIR = os.path.join(os.path.dirname(__file__), "logs")
os.makedirs(LOG_DIR, exist_ok=True)

def load_institutional_status():
    auth_dir = os.path.expanduser("~/.veribound_auth")
    real_id_path = os.path.join(auth_dir, "credential_id")
    demo_path = os.path.join(auth_dir, "demo_credential.json")

    if os.path.exists(real_id_path):
        with open(real_id_path) as f:
            return "VERIFIED", "Institutional Authority", f.read().strip()
    elif os.path.exists(demo_path):
        with open(demo_path) as f:
            demo = json.load(f)
            return "DEMO", demo.get("institution"), None
    else:
        return None, None, None

def compute_seal(data):
    raw = json.dumps(data, sort_keys=True)
    return hashlib.sha256(raw.encode()).hexdigest()

def compute_hmac(seal, key):
    return hmac.new(key.encode(), seal.encode(), hashlib.sha256).hexdigest()

def generate_marker(seal, issuer, mode):
    base = sum(ord(c) for c in seal) % 10000
    marker = str(base / 1137.0)
    if mode == "VERIFIED":
        watermark = "⚡ArcField:Fusion"
    elif mode == "DEMO":
        watermark = "✴️TrialSphere:Echo"
    else:
        watermark = "..."
    return f"{marker} {watermark}"

@app.route('/verify', methods=['POST'])
def verify():
    req = request.get_json()
    data = req.get("data")
    template_name = req.get("template")

    try:
        template = load_verified_template(template_name)
    except Exception as e:
        return jsonify({ "status": "FAILED", "error": str(e) }), 400

    status = "VERIFIED" if data and template.get("rules") else "FAILED"

    seal = compute_seal(data)
    mode, issuer, credential_id = load_institutional_status()
    hmac_seal = compute_hmac(seal, LICENSE_KEY)
    marker = generate_marker(seal, issuer, mode)

    template_hash = hashlib.sha256(json.dumps(template, sort_keys=True).encode()).hexdigest()

    result = {
        "status": status if mode else "FAILED",
        "seal": seal,
        "signed_seal": hmac_seal,
        "marker": marker,
        "issuer": issuer,
        "mode": mode,
        "timestamp": datetime.utcnow().isoformat(),
        "credential_expires": "2025-08-15" if mode == "VERIFIED" else "N/A",
        "license_fingerprint": hashlib.sha256(f"{issuer}-VERIBOUND-2025".encode()).hexdigest(),
        "regime": {
            "name": template.get("name", "Unknown"),
            "domain": template.get("domain", "unknown"),
            "version": template.get("version", "unspecified")
        },
        "template_hash": template_hash
    }

    # Save to log file
    timesafe = result["timestamp"].replace(":", "-")
    filename = f"verification_log_{timesafe}.json"
    filepath = os.path.join(LOG_DIR, filename)
    with open(filepath, "w") as f:
        json.dump(result, f, indent=2)

    return jsonify(result)

if __name__ == '__main__':
    app.run(debug=True)
