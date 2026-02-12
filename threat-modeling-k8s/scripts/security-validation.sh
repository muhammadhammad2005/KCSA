#!/bin/bash
echo "=== SECURITY VALIDATION ==="
kubectl auth can-i --list --as=system:serviceaccount:threat-modeling-lab:restricted-sa
kubectl exec secure-pod -- nc -zv database-service 5432 2>&1 | grep -E "(refused|timeout|failed)" || echo "Connection unexpectedly succeeded"
kubectl exec secure-pod -- id
kubectl exec secure-pod -- ls -la /
kubectl exec vulnerable-pod -- id 2>/dev/null || echo "Vulnerable pod not accessible"
kubectl get networkpolicies -n threat-modeling-lab
