#!/usr/bin/env python3
"""
Integration script to add institutional verification to verify_file_institutional.py
"""

# Read the original verification script
with open('verify_file_institutional.py', 'r') as f:
    original_code = f.read()

# Add institutional imports at the top (after existing imports)
institutional_imports = '''
# Institutional Authorization System
import sys
import os
sys.path.append(os.path.expanduser('~/.veribound_auth'))
try:
    from institutional_verifier import institutional_verify, print_institutional_result
    INSTITUTIONAL_AVAILABLE = True
except ImportError:
    INSTITUTIONAL_AVAILABLE = False
'''

# Find where to insert imports (after the existing imports)
import_insertion_point = original_code.find('def generate_sha256(content: str):')
modified_code = original_code[:import_insertion_point] + institutional_imports + '\n' + original_code[import_insertion_point:]

# Replace the final verification output section
old_output_section = '''    if result == "pass":
        print(f"{GREEN}✅ Verification PASSED{RESET}", flush=True)
        print(f"🔒 Seal: {seal}")
    elif result == "fail" and color == "YELLOW":
        print(f"{YELLOW}⚠️ Borderline or Symbolic Threshold Breach{RESET}", flush=True)
        print(f"🟡 Seal: {seal}")
        print(f"🧠 Memory encoding color: {YELLOW}YELLOW{RESET} — symbolic alert", flush=True)
    else:
        print(f"{RED}❌ Verification FAILED: rule violation detected.{RESET}", flush=True)
        print(f"🔒 Seal: {seal}")'''

new_output_section = '''    if result == "pass":
        # Check for institutional authorization (Level 2)
        if INSTITUTIONAL_AVAILABLE:
            enhanced_status, irrational_signature, institutional_id = institutional_verify(seal, "PASSED")
            if irrational_signature is not None:
                print_institutional_result(enhanced_status, seal, irrational_signature, institutional_id)
            else:
                print(f"{GREEN}✅ Verification PASSED{RESET}", flush=True)
                print(f"🔒 Seal: {seal}")
                print(f"{YELLOW}⚠️ Basic validation only - no institutional authorization{RESET}")
        else:
            print(f"{GREEN}✅ Verification PASSED{RESET}", flush=True)
            print(f"🔒 Seal: {seal}")
    elif result == "fail" and color == "YELLOW":
        print(f"{YELLOW}⚠️ Borderline or Symbolic Threshold Breach{RESET}", flush=True)
        print(f"🟡 Seal: {seal}")
        print(f"🧠 Memory encoding color: {YELLOW}YELLOW{RESET} — symbolic alert", flush=True)
    else:
        print(f"{RED}❌ Verification FAILED: rule violation detected.{RESET}", flush=True)
        print(f"🔒 Seal: {seal}")'''

# Apply the replacement
final_code = modified_code.replace(old_output_section, new_output_section)

# Write the enhanced version
with open('verify_file_institutional.py', 'w') as f:
    f.write(final_code)

print("✅ Institutional verification integrated!")
print("🔧 Enhanced script: verify_file_institutional.py")
