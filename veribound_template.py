
import os
import sys
import json

TEMPLATE_DIR = os.path.join(os.path.dirname(__file__), "templates")

def list_templates():
    print("📂 Available Templates:")
    for filename in os.listdir(TEMPLATE_DIR):
        if filename.endswith(".json"):
            print(f" - {filename}")

def validate_template(template_path):
    try:
        with open(template_path, "r") as f:
            template = json.load(f)
        required_keys = ["template_name", "rules", "required_fields", "default_color"]
        for key in required_keys:
            if key not in template:
                print(f"❌ Missing key: {key}")
                return
        print(f"✅ Template '{template['template_name']}' is valid.")
    except Exception as e:
        print(f"❌ Error validating template: {e}")

def main():
    if len(sys.argv) < 2:
        print("Usage: python3 veribound_template.py <command> [template_file]")
        print("Commands: list, validate <template_file>")
        return

    cmd = sys.argv[1]
    if cmd == "list":
        list_templates()
    elif cmd == "validate" and len(sys.argv) == 3:
        validate_template(sys.argv[2])
    else:
        print("Invalid command or missing argument.")

if __name__ == "__main__":
    main()
