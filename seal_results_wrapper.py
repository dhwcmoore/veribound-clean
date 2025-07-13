import json
import hashlib
import random

# Load array of results
with open("results/fixed_results.json", "r") as f:
    result_array = json.load(f)

# Convert to canonical string for hashing
result_str = json.dumps(result_array, sort_keys=True)

# Generate seal hash
seal_hash = hashlib.sha256(result_str.encode("utf-8")).hexdigest()[:16]

# Generate dummy irrational signature (or use actual logic if available)
irrational_signature = random.uniform(1e15, 1e16)

# Wrap into sealed object
sealed = {
    "seal_hash": seal_hash,
    "irrational_signature": irrational_signature,
    "results": result_array
}

# Write output
with open("veribound_clean.json", "w") as f:
    json.dump(sealed, f, indent=2)

print("✅ Sealed result written to veribound_clean.json")

