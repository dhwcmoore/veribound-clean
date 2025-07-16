#!/bin/bash
# VeriBound Institutional Authorization System Installation
echo "🔧 Installing VeriBound Institutional Authorization System..."

# Create institutional auth directory
mkdir -p ~/.veribound_auth
chmod 700 ~/.veribound_auth

# Copy institutional verification modules
if [ -d "institutional_auth_modules" ]; then
    cp institutional_auth_modules/* ~/.veribound_auth/
    chmod +x ~/.veribound_auth/*.py
    echo "✅ Institutional modules installed"
else
    echo "❌ Error: institutional_auth_modules directory not found"
    exit 1
fi

# Generate new institutional ID
echo "VERIBOUND_INSTITUTIONAL_AUTH_$(date +%s)" > ~/.veribound_auth/institutional_id
chmod 600 ~/.veribound_auth/institutional_id

echo "✅ Institutional authorization system installed"
echo "🆔 New institutional ID generated"
echo "🟢 Level 2 verification capabilities enabled"
echo ""
echo "Test with: python3 verify_file_institutional.py <data.json> --template <template.json>"
