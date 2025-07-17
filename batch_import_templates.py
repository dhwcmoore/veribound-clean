import csv
import json
import hashlib
import subprocess
from pathlib import Path
import nacl.signing

# Config
CSV_FILE = "veribound_batch_templates.csv"
OUTPUT_DIR = Path("trusted_templates")
ED_KEY_PATH = Path("ed25519_signing.key")
OUTPUT_DIR.mkdir(exist_ok=True)

# Load CSV
templates = {}
with open(CSV_FILE, newline='') as f:
    reader = csv.DictReader(f)
    for row in reader:
        tid = row["id"]
        if tid not in templates:
            templates[tid] = {
                "name": row["name"],
                "domain": row["domain"],
                "version": row["version"],
                "rules": []
            }
        templates[tid]["rules"].append({
            "field": row["field"],
            "expression": row["expression"]
        })

# Ed25519 signer
if not ED_KEY_PATH.exists():
    signing_key = nacl.signing.SigningKey.generate()
    with open(ED_KEY_PATH, "wb") as f:
        f.write(signing_key.encode())
else:
    signing_key = nacl.signing.SigningKey(open(ED_KEY_PATH, "rb").read())

# Process each template
for tid, tpl in templates.items():
    json_path = OUTPUT_DIR / f"{tid}.json"
    sig_path = json_path.with_suffix(".json.sig")
    asc_path = json_path.with_suffix(".json.asc")

    # Write JSON
    with open(json_path, "w") as f:
        json.dump(tpl, f, indent=2)

    # Hash
    h = hashlib.sha256(json.dumps(tpl, sort_keys=True).encode()).hexdigest()

    # Ed25519 signature
    sig = signing_key.sign(h.encode()).signature
    with open(sig_path, "wb") as f:
        f.write(sig)

    # GPG signature
    subprocess.run([
        "gpg", "--armor", "--output", str(asc_path),
        "--detach-sign", str(json_path)
    ])

    print(f"✅ {tid} → signed .json, .sig, .asc")

print("✅ All templates imported.")
