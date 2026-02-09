#!/bin/bash
echo "Scanning for secrets..."
find ~/lab4-secrets -name "*.yaml" -exec grep -l "password\|secret\|key" {} \;
find ~/lab4-secrets -name "*.yaml" -exec grep -E "[A-Za-z0-9+/]{20,}={0,2}" {} \;
echo "Scan complete."
