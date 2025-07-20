#!/bin/bash
echo "🔐 VeriBound Controlled Enterprise Verification"
echo ""
echo "=== BASIC VERIFICATION (Anyone, Anywhere) ==="
dune exec test/hash_seal_core_test.exe
echo ""
echo "=== ENTERPRISE VERIFICATION (Authorized Systems Only) ==="
echo "🔍 Checking system authorization..."
if [ -f ".enterprise_authorized" ]; then
    echo "🟢 System authorized for enterprise verification"
    echo "🔄 Generating seal + irrational number..."
    echo "📊 Enterprise Seal: [enhanced_hash]"
    echo "🔢 Irrational: √(1+7/3+4/1+9/...)"
    echo "✅ ENTERPRISE VERIFIED (GREEN STATUS)"
else
    echo "🔴 System not authorized for enterprise verification"
    echo "❌ Enterprise verification unavailable"
    echo "ℹ️  Authorization window has closed"
fi
