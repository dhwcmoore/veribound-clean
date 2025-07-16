#!/bin/bash
set -e

echo "🔧 Starting VeriBound project cleanup and reorganization..."

mkdir -p src/verifier
mkdir -p src/hash
mkdir -p test
mkdir -p data
mkdir -p demo
mkdir -p scripts
mkdir -p docs

echo "📦 Moving OCaml sources..."
mv veribound_hash_seal.ml src/verifier/
mv veribound_hash_seal.mli src/verifier/
mv src/verifier.ml src/verifier/verifier.ml 2>/dev/null || true
mv src/verifier.mli src/verifier/verifier.mli 2>/dev/null || true

echo "📦 Organizing tests..."
mv test/hash_seal_core_test.ml test/
mv test/test_verifier*.ml test/
mv test/working_test_dune.ml test/ 2>/dev/null || true

echo "📦 Moving JSON and CSV data files..."
mv *.json data/
mv *.csv data/
mv veribound_clean.json data/

echo "📦 Keeping existing results folder (results/)..."

echo "📦 Moving Python and shell scripts..."
mv generate_dashboard.py scripts/
mv seal_results_wrapper.py scripts/
mv rebuild_verifier.sh scripts/ 2>/dev/null || true
mv enhanced_veribound_demo.sh scripts/ 2>/dev/null || true
mv simple_veribound_demo.sh scripts/ 2>/dev/null || true
mv simple_veribound_demo\ \(1\).sh scripts/ 2>/dev/null || true
mv scripts/check_dune_consistency.sh scripts/

echo "📦 Moving demo input files..."
mv veribound-clean_demo/* demo/
rmdir veribound-clean_demo 2>/dev/null || true

echo "📦 Moving logo and visual assets..."
mv docs/verisys-logo.png docs/

echo "🧹 Removing unused/temporary files..."
rm -rf nano* bool string Digest.to_hex *.cmi *.cmo demo_*.ml training/ domains/ required/ archive_conflicts/ 2>/dev/null || true

echo "✅ Cleanup and reorganization complete."
