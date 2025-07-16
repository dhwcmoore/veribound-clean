
import json
import sys
import os

WHITELIST_KEYS = {"score", "flag", "summary", "irrational_seal", "graph_path"}

def strip_to_public(input_path, output_path=None):
    with open(input_path, "r") as f:
        data = json.load(f)

    public_data = {k: v for k, v in data.items() if k in WHITELIST_KEYS}

    if not output_path:
        base, ext = os.path.splitext(input_path)
        output_path = f"{base}_public{ext}"

    with open(output_path, "w") as f:
        json.dump(public_data, f, indent=2)

    print(f"✅ Public JSON written to: {output_path}")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python strip_for_public.py <audit_json_file>")
        sys.exit(1)

    input_file = sys.argv[1]
    strip_to_public(input_file)
