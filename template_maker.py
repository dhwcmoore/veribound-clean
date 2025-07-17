import json
from pathlib import Path

print("🛠 VeriBound Template Maker")
template = {}

# Basic metadata
template['name'] = input("Template Display Name: ").strip()
template['version'] = input("Version (e.g., 1.0): ").strip()
template['domain'] = input("Domain (e.g., medical, financial, environmental): ").strip()

# Rules
rules = []
print("\nAdd validation rules (leave field name blank to finish):")
while True:
    field = input(" Field name: ").strip()
    if not field:
        break
    expr = input(f" Validation expression for '{field}': ").strip()
    rules.append({
        "field": field,
        "expression": expr
    })

template["rules"] = rules

# Output
TEMPLATE_DIR = Path("trusted_templates")
TEMPLATE_DIR.mkdir(exist_ok=True)
template_id = input("\nSave as template ID (e.g., clinical_trial_v1): ").strip()
out_path = TEMPLATE_DIR / f"{template_id}.json"

with open(out_path, "w") as f:
    json.dump(template, f, indent=2)
    print(f"✅ Template saved to {out_path}")
