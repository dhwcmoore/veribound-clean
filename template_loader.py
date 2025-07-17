import json
import hashlib
from pathlib import Path

TEMPLATE_DIR = Path(__file__).parent / "trusted_templates"
REGISTRY_FILE = Path(__file__).parent / "template_registry.json"

def load_registry():
    if not REGISTRY_FILE.exists():
        raise FileNotFoundError("Template registry not found.")
    with open(REGISTRY_FILE) as f:
        return json.load(f)

def compute_hash(template_obj):
    return hashlib.sha256(json.dumps(template_obj, sort_keys=True).encode()).hexdigest()

def validate_signature(entry):
    # Placeholder: in production, use cryptographic public key
    expected_prefix = f"SIGNATURE({entry['hash'][:12]}"
    return entry["signature"].startswith(expected_prefix)

def load_verified_template(name):
    registry = load_registry()
    entry = registry.get(name)
    if not entry:
        raise ValueError(f"Template '{name}' not found in registry.")

    template_path = TEMPLATE_DIR / entry["file"]
    if not template_path.exists():
        raise FileNotFoundError(f"Template file {entry['file']} not found.")

    with open(template_path) as f:
        template = json.load(f)

    actual_hash = compute_hash(template)
    if actual_hash != entry["hash"]:
        raise ValueError("Template hash mismatch — possible tampering detected.")

    if not validate_signature(entry):
        raise ValueError("Signature validation failed — untrusted template.")

    return template
