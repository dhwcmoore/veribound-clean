#!/bin/bash

# veribound_report.sh - One-click dashboard generator
# Usage: ./veribound_report.sh results/veribound_output_*.json

if [ $# -ne 1 ]; then
  echo "Usage: $0 <path-to-json-output>"
  exit 1
fi

INPUT="$1"

if [ ! -f "$INPUT" ]; then
  echo "❌ File not found: $INPUT"
  exit 1
fi

echo "🔍 Generating report from: $INPUT"
python3 generate_dashboard.py "$INPUT"
