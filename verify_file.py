
import sys
import json
import hashlib
from datetime import datetime, timezone
import os

# ANSI color codes
GREEN = "\033[92m"
RED = "\033[91m"
YELLOW = "\033[93m"
RESET = "\033[0m"

def generate_sha256(content: str):
    return hashlib.sha256(content.encode('utf-8')).hexdigest()

def write_log(file_path, result, seal, input_hash, color, template_name, memory_symbol=None):
    base_name = os.path.splitext(os.path.basename(file_path))[0]
    color_seal_input = f"{input_hash}:{color}"
    color_seal = generate_sha256(color_seal_input)

    log_entry = {
        "file": file_path,
        "timestamp": datetime.now(timezone.utc).isoformat(),
        "status": result.upper(),
        "color": color,
        "color_seal": color_seal,
        "input_sha256": input_hash,
        "seal": seal,
        "template_used": template_name,
        "verified_by": "VeriBound 0.1.3",
        "signature_algorithm": "SHA-256",
        "legal_basis": "Basel III IRB model validation"
    }
    if memory_symbol:
        log_entry["memory_symbol"] = memory_symbol

    log_file = f"{base_name}_verification_log.json"
    with open(log_file, "w") as f:
        json.dump(log_entry, f, indent=2)

def apply_template(data, template):
    for rule in template.get("rules", []):
        try:
            if eval(rule["expression"], {}, data):
                continue
            else:
                return ("fail", rule["color"], rule.get("memory_symbol"))
        except Exception as e:
            return ("fail", "RED", f"error evaluating rule: {str(e)}")
    return ("pass", template.get("default_color", "GREEN"), None)

def main():
    if len(sys.argv) < 4 or sys.argv[2] != "--template":
        print("Usage: python3 verify_file.py <input_file.json> --template <template_file.json>")
        return

    file_path = sys.argv[1]
    template_path = sys.argv[3]

    with open(file_path) as f:
        data_str = f.read()
        data = json.loads(data_str)

    with open(template_path) as tf:
        template = json.load(tf)

    template_name = template.get("template_name", os.path.basename(template_path))
    input_hash = generate_sha256(data_str)
    result, color, memory_symbol = apply_template(data, template)
    seal = generate_sha256(data_str + result)

    if result == "pass":
        print(f"{GREEN}✅ Verification PASSED{RESET}", flush=True)
        print(f"🔒 Seal: {seal}")
    elif result == "fail" and color == "YELLOW":
        print(f"{YELLOW}⚠️ Borderline or Symbolic Threshold Breach{RESET}", flush=True)
        print(f"🟡 Seal: {seal}")
        print(f"🧠 Memory encoding color: {YELLOW}YELLOW{RESET} — symbolic alert", flush=True)
    else:
        print(f"{RED}❌ Verification FAILED: rule violation detected.{RESET}", flush=True)
        print(f"🔒 Seal: {seal}")

    write_log(file_path, result, seal, input_hash, color, template_name, memory_symbol)
from pathlib import Path

def main():
    if len(sys.argv) < 4 or sys.argv[2] != "--template":
        print("Usage: python3 verify_file.py <input_file.json> --template <template_file.json>")
        return

    file_path = sys.argv[1]
    template_path = sys.argv[3]

    with open(file_path) as f:
        data_str = f.read()
        data = json.loads(data_str)

    with open(template_path) as tf:
        template = json.load(tf)

    template_name = template.get("template_name", os.path.basename(template_path))
    input_hash = generate_sha256(data_str)
    result, color, memory_symbol = apply_template(data, template)
    seal = generate_sha256(data_str + result)

    if result == "pass":
        print(f"{GREEN}✅ Verification PASSED{RESET}", flush=True)
        print(f"🔒 Seal: {seal}")
    elif result == "fail" and color == "YELLOW":
        print(f"{YELLOW}⚠️ Borderline or Symbolic Threshold Breach{RESET}", flush=True)
        print(f"🟡 Seal: {seal}")
        print(f"🧠 Memory encoding color: {YELLOW}YELLOW{RESET} — symbolic alert", flush=True)
    else:
        print(f"{RED}❌ Verification FAILED: rule violation detected.{RESET}", flush=True)
        print(f"🔒 Seal: {seal}")

    write_log(file_path, result, seal, input_hash, color, template_name, memory_symbol)

    # Prepare output directory
    Path("results").mkdir(exist_ok=True)

    # You may need to rename this if your rule result variable is not called 'flags'
    flags = []  # TODO: Replace with your actual list of rule violations or symbolic results
    memory_overlay = {}  # Optional: replace with your memory output structure if available

    # Timestamped output name
    timestamp = datetime.now(timezone.utc).strftime("%Y%m%d_%H%M%S")
    output_file = f"results/veribound_output_{timestamp}.json"

    # Construct full result object
    output_data = {
        "input": data,
        "template": template,
        "flags": flags,
        "memory_overlay": memory_overlay,
        "seal": seal,
        "timestamp": datetime.now(timezone.utc).isoformat(),
        "color": color,
        "verified_by": "VeriBound 0.1.3"
    }

    # Save full dashboard-compatible JSON
    with open(output_file, "w") as f:
        json.dump(output_data, f, indent=2)
    print(f"🟢 Full verification result saved to {output_file}")

    # Save legacy-style log as well
    summary_log = {
        "file": file_path,
        "timestamp": output_data["timestamp"],
        "status": "PASS" if len(flags) == 0 else "FAIL",
        "color": color,
        "seal": seal,
        "template_used": template_path,
        "verified_by": "VeriBound 0.1.3"
    }

    with open("results/last_summary_log.json", "w") as f:
        json.dump(summary_log, f, indent=2)
    print("📄 Summary log saved to results/last_summary_log.json")

if __name__ == "__main__":
    main()
import hashlib

salt = os.getenv("VERIBOUND_SALT")
irrational_number = None
salt_used = False

if salt:
    combined = (seal + salt).encode()
    irrational_seed = hashlib.sha256(combined).hexdigest()
    irrational_number = int(irrational_seed, 16) / 10**77
    salt_used = True

# Reserve structure for future TPM/HSM hardware upgrade
hardware_id = "MAC-XYZ-123456"  # Placeholder
hardware_entropy = None         # Reserved for future hardware integration

# Inject into output_data
output_data["irrational_marker"] = f"{irrational_number:.40f}" if salt_used else "(not generated)"
