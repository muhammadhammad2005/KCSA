#!/bin/bash

echo "=== Kubernetes Security Compliance ==="

echo
echo "1. RBAC check:"
if kubectl auth can-i get pods --as=system:anonymous 2>/dev/null; then
  echo "❌ Anonymous access allowed"
else
  echo "✅ Anonymous access blocked"
fi

echo
echo "2. Pods running as root:"
kubectl get pods --all-namespaces -o jsonpath='{range .items[*]}{.metadata.name}{" "}{.spec.securityContext.runAsUser}{"\n"}{end}'

echo
echo "3. Network Policies:"
kubectl get networkpolicies --all-namespaces

echo
echo "4. Service Accounts:"
kubectl get serviceaccounts --all-namespaces

echo "=== Done ==="
