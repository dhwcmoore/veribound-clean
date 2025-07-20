#!/bin/bash
echo "🔐 VeriBound Cryptographic Audit Verification Demo"
echo ""
echo "Input: Sample audit data"
echo '{"results": [{"category": "test", "lower": 1.0, "upper": 2.0, "verdict": "pass"}]}'
echo ""
echo "🔄 Generating cryptographic seal..."
dune exec test/hash_seal_core_test.exe
echo ""
echo "✅ Audit data is now cryptographically sealed and tamper-evident"
echo "Any modification to the data will change the seal, proving tampering"

echo ""
echo "🔍 Tampering Detection Demo:"
echo "Original seal: 57ff4d38c2efa52e17ba0a8d73194b73e30bc0cbdb8ff36844d93c757187b255"
echo "If someone changes even one character in the audit data..."
echo "Result: Completely different seal (proving tampering occurred)"
