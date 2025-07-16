#!/usr/bin/env python3
"""
VeriBound Level 2 Institutional Authorization Module
Provides regulatory compliance verification with institutional authority
"""
import os
import sys
sys.path.append(os.path.dirname(__file__))
from irrational_generator import generate_irrational_signature

# ANSI color codes
GREEN = "\033[92m"
YELLOW = "\033[93m"
RESET = "\033[0m"

def has_institutional_authorization():
    """Check if institutional credentials are present"""
    cred_path = os.path.expanduser('~/.veribound_auth/institutional_id')
    return os.path.exists(cred_path)

def get_institutional_id():
    """Get the institutional ID if present"""
    cred_path = os.path.expanduser('~/.veribound_auth/institutional_id')
    if os.path.exists(cred_path):
        with open(cred_path) as f:
            return f.read().strip()
    return None

def institutional_verify(seal, verification_status):
    """
    Perform Level 2 institutional verification
    Returns: (enhanced_status, irrational_signature, institutional_id)
    """
    if not has_institutional_authorization():
        return verification_status, None, None
    
    institutional_id = get_institutional_id()
    irrational_signature = generate_irrational_signature(seal)
    
    # Enhance status to institutional level
    if verification_status == "PASSED":
        enhanced_status = "VERIFIED"  # Green institutional verification
    else:
        enhanced_status = verification_status  # Keep original status
    
    return enhanced_status, irrational_signature, institutional_id

def print_institutional_result(status, seal, irrational_signature=None, institutional_id=None):
    """Print verification result with institutional formatting"""
    if irrational_signature is not None:
        print(f"{GREEN}✅ Verification {status} (INSTITUTIONAL AUTHORITY){RESET}")
        print(f"🔒 Seal: {seal}")
        print(f"🔢 Irrational Signature: {irrational_signature}")
        print(f"🏛️ Institutional ID: {institutional_id}")
        print(f"{GREEN}🟢 REGULATORY COMPLIANCE VERIFIED{RESET}")
    else:
        print(f"{YELLOW}✅ Verification {status} (Basic Validation Only){RESET}")
        print(f"🔒 Seal: {seal}")
        print(f"{YELLOW}⚠️ No institutional authorization detected{RESET}")

if __name__ == "__main__":
    # Test the institutional verifier
    test_seal = "837c1a951993c94def72b8b669bf8a482dd553244e4c4a7ba68445dc68bd3f0f"
    
    print("🧪 Testing Institutional Verification System:")
    print("=" * 60)
    
    status, signature, inst_id = institutional_verify(test_seal, "PASSED")
    print_institutional_result(status, test_seal, signature, inst_id)
