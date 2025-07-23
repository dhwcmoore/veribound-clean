# VeriBound
**Where Data Compliance Meets Mathematical Certainty**

**VeriBound** is a formal data classification and verification system designed for safety-critical and compliance-intensive environments. Built on strong mathematical principles, VeriBound ensures the integrity and provability of your audit results through cryptographic seals and deterministic classification.

---

## 📦 Project Structure

```
veribound-clean/
├── src/                    # Core libraries
│   ├── verifier.ml         # Parses and verifies sealed audit files
│   └── veribound_hash_seal.ml  # Seal generation logic
├── test/                   # Executable tests and demonstrations
│   ├── test_verifier.ml        # Baseline verification test
│   ├── demonstration_1.ml     # Financial service audit examples
│   ├── demonstration_2.ml     # Complex edge cases
│   └── demonstration_3.ml     # Known limits and failures
├── results/                # Sample JSON, HTML, PNG outputs
├── docs/                   # Logo, visual exports, reports
├── scripts/                # Helper tools (dashboard gen, consistency checks)
├── README.md
└── dune-project            # Dune workspace configuration
```

---

## ✅ Features

- Deterministic classification with hash sealing  
- Recomputable signatures for traceable audit trails  
- JSON → PNG + HTML export  
- Lightweight verifier executable  
- Audit integrity enforced by mathematical contract  

---

## 🚀 Usage

1. **Build the project**
   ```bash
   dune build
   ```

2. **Run tests**
   ```bash
   dune exec test/test_verifier.exe
   dune exec test/demonstration_1.exe
   dune exec test/demonstration_2.exe
   dune exec test/demonstration_3.exe
   ```

3. **Expected output**
   ```
   Seal: <computed hash>
   Signature: <computed float>
   Entries: N
   ```

---

## 📂 Input Format

Expected JSON audit file structure:
```json
{
  "entries": [
    { "category": "Accept", "value": 42.0 },
    { "category": "Reject", "value": -1.2 }
  ],
  "seal": "abcd1234...",
  "signature": 0.00234124
}
```

---

## 🔒 Cryptographic Seal

Each audit file is sealed by:
- A hash of classification results  
- A deterministic floating-point signature summarising classification trajectory

This ensures tamper-evidence, recomputability, and mathematical auditability.

---

## 🧪 Demonstration Tests

- `demonstration_1.ml` – Real-world financial service audits (e.g., Basel III reporting, Know-Your-Customer logs)  
- `demonstration_2.ml` – Extreme edge cases: ambiguous categories, malformed sequences, fuzzy thresholds  
- `demonstration_3.ml` – Designed failure cases that reveal the known boundaries of VeriBound

---

## 🛠️ Developer Tools

- `scripts/generate_dashboard.py` – Generates PNG and HTML visualisations from JSON  
- `scripts/veribound_report.sh` – Generates timestamped report bundles  
- `scripts/check_dune_consistency.sh` – Warns about Dune public_name errors  

---

## 📜 License

MIT © 2025 Duston Moore / VeriSys
