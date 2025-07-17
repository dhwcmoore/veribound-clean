# sign_templates.py
# Signs a given JSON template using both GPG and Ed25519

import json
import hashlib
import nacl.signing
import nacl.encoding
import subprocess
from pathlib import Path
import sys

if len(sys.argv) != 2:
    print("Usage: python3 sign_templates.py <template.json>")
    sys.exit(1)

template_path = Path(sys.argv[1])
if not template_path.exists():
    print(f"Template not found: {template_path}")
    sys.exit(1)

# Load and hash template
with open(template_path, 'r') as f:
    template_data = json.load(f)

template_hash = hashlib.sha256(json.dumps(template_data, sort_keys=True).encode()).hexdigest()
print(f"🔐 SHA256 hash: {template_hash}")

# --- GPG SIGNING ---
gpg_output = subprocess.run([
    "gpg", "--armor", "--output", f"{template_path}.asc",
    "--detach-sign", template_path.as_posix()
], capture_output=True)

if gpg_output.returncode != 0:
    print("❌ GPG signing failed:", gpg_output.stderr.decode())
else:
    print(f"✅ GPG signature written to {template_path}.asc")

# --- Ed25519 SIGNING ---
ed25519_private_key_path = Path("ed25519_signing.key")
if not ed25519_private_key_path.exists():
    print("Generating new Ed25519 key...")
    signing_key = nacl.signing.SigningKey.generate()
    with open(ed25519_private_key_path, "wb") as f:
        f.write(signing_key.encode())
else:
    with open(ed25519_private_key_path, "rb") as f:
        signing_key = nacl.signing.SigningKey(f.read())

signed = signing_key.sign(template_hash.encode())
with open(f"{template_path}.sig", "wb") as f:
    f.write(signed.signature)

print(f"✅ Ed25519 signature written to {template_path}.sig")
