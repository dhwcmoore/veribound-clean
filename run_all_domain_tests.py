#!/usr/bin/env python3
import os
import subprocess

TEMPLATE_DIR = "templates/"
TEST_INPUT = "demo_valid.json"

for filename in os.listdir(TEMPLATE_DIR):
    if filename.endswith(".json"):
        template_path = os.path.join(TEMPLATE_DIR, filename)
        print(f"\n🔎 Testing template: {filename}")
        try:
            subprocess.run([
                "python3", "verify_file.py",
                TEST_INPUT,
                "--template", template_path
            ], check=True)
        except subprocess.CalledProcessError:
            print(f"❌ Validation failed for: {filename}")
