#!/bin/bash

TARGET_DIR=${1:-./lab4-secrets}
FOUND=0

echo "🔍 Scanning for secrets in: $TARGET_DIR"
echo "--------------------------------------"

echo "[+] Keyword-based scan"
matches=$(find "$TARGET_DIR" -type f -name "*.yaml" -exec grep -inE "password|secret|key|token|apikey" {} \;)

if [ -n "$matches" ]; then
  echo "$matches"
  FOUND=1
else
  echo "No keyword secrets found."
fi

echo
echo "[+] Base64 pattern scan"
b64matches=$(find "$TARGET_DIR" -type f -name "*.yaml" -exec grep -inE "[A-Za-z0-9+/]{20,}={0,2}" {} \;)

if [ -n "$b64matches" ]; then
  echo "$b64matches"
  FOUND=1
else
  echo "No base64-like secrets found."
fi

echo "--------------------------------------"

if [ $FOUND -eq 1 ]; then
  echo "❌ Secrets detected!"
  exit 1
else
  echo "✅ No secrets detected."
  exit 0
fi

