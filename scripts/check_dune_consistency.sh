#!/bin/bash
echo "🔍 Checking for invalid public_name declarations..."
grep -r "public_name" src/ | while read -r line; do
  if [[ $line != *"veribound_clean."* ]]; then
    echo "⚠️  Suspicious public_name: $line"
  fi
done
