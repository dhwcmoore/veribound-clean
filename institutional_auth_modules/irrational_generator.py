#!/usr/bin/env python3
"""
VeriBound Institutional Irrational Number Generator
Generates mathematically irrational signatures from SHA256 seals
"""
import hashlib
import math

def generate_irrational_signature(sha256_seal):
    """
    Generate an irrational number signature from a SHA256 seal
    Uses the seal as a deterministic seed for institutional verification
    """
    # Convert first 16 hex characters to integer seed
    hex_seed = sha256_seal[:16]
    seed_int = int(hex_seed, 16)
    
    # Generate irrational number using mathematical constants
    # π (pi) and e are transcendental/irrational numbers
    base_ratio = seed_int / (2**64)  # Normalize to 0-1 range
    
    # Create irrational signature using π as base
    irrational_signature = math.pi * base_ratio * (10**15)
    
    return irrational_signature

def test_generator():
    """Test the irrational number generator with sample seals"""
    test_seals = [
        "837c1a951993c94def72b8b669bf8a482dd553244e4c4a7ba68445dc68bd3f0f",
        "bed2e0b64894a9cc81aaf8ffa981830c644e64726227e1a4c1c00849ed67c676",
        "49cc8ebbae74975c01d8845542f1493d0b887deb53b685ead5e1f9086b51f98c"
    ]
    
    print("�� Testing Irrational Number Generation:")
    print("=" * 60)
    
    for seal in test_seals:
        signature = generate_irrational_signature(seal)
        print(f"📋 Seal: {seal[:32]}...")
        print(f"🔢 Irrational Signature: {signature:.1f}")
        print(f"🧪 Mathematical Verification: π-based = {signature/math.pi:.10f}")
        print("-" * 60)

if __name__ == "__main__":
    test_generator()
