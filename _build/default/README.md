# VeriBound

**_Where Data Compliance Meets Mathematical Certainty_**

VeriBound is a formal data classification and verification system designed for safety-critical and compliance-intensive environments. Built on strong mathematical principles, VeriBound ensures the integrity and provability of your audit results through cryptographic seals and precise classification.

---

## 📦 Project Structure

```

veribound-clean/
├── src/                    # Core libraries
│   ├── verifier.ml         # Parses and verifies sealed audit files
│   └── veribound\_hash\_seal.ml  # Seal generation logic
├── test/                   # Executable tests
│   └── test\_verifier.ml    # Sample audit verification
├── results/                # Sample JSON, HTML, PNG outputs
├── docs/                   # Logo, visual exports, reports
├── scripts/                # Helper tools (dashboard gen, consistency checks)
├── README.md
└── dune-project            # Dune workspace configuration

````

---

## ✅ Features

- Deterministic classification with hash sealing
- Recomputable signatures for traceable audit trails
- JSON → PNG + HTML export
- Lightweight verifier executable
- Audit integrity enforcement by mathematical contract

---

## 🚀 Usage

### 1. Build the project

```bash
dune build
````

### 2. Run the verifier test

```bash
dune exec test/test_verifier.exe
```

### 3. Expected output

```text
Verification result for results/veribound_output_YYYYMMDD_HHMM.json:
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

* **Hash** of classification results
* **Signature**: a deterministic floating-point trace summary
* Ensures tamper-evidence and verifiability

---

## 🛠️ Developer Tools

* `scripts/generate_dashboard.py` – Generates PNG and HTML visualisations from JSON
* `scripts/veribound_report.sh` – Generates timestamped report bundles
* `scripts/check_dune_consistency.sh` – Warns about Dune `public_name` errors

---

## 🧪 Testing

```bash
dune exec test/test_verifier.exe
```

If output matches the computed seal and signature, the audit file is **verified**.

---

## 📜 License

MIT License © 2025 Duston Moore / VeriSys
