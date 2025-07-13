#!/bin/bash

echo "🔄 Cleaning up previous build..."
dune clean

echo "📦 Rebuilding project..."
if dune build; then
  echo "✅ Build successful."
else
  echo "❌ Build failed."
  exit 1
fi

echo "🚀 Running verifier_exec..."
if dune exec src/verifier/verifier_exec.exe; then
  echo "✅ verifier_exec ran successfully."
else
  echo "❌ Failed to run verifier_exec."
  exit 1
fi

