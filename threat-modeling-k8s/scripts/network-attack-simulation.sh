#!/bin/bash
echo "=== NETWORK ATTACK SIMULATION ==="
echo "Testing connectivity to other services:"
kubectl exec vulnerable-pod -- nc -zv backend-service 8080 2>&1 | grep -E "(open|succeeded)"
kubectl exec vulnerable-pod -- nc -zv database-service 5432 2>&1 | grep -E "(open|succeeded)"
echo "Service discovery within namespace:"
kubectl exec vulnerable-pod -- nslookup backend-service
kubectl exec vulnerable-pod -- nslookup database-service
echo "DNS enumeration:"
kubectl exec vulnerable-pod -- cat /etc/resolv.conf
echo "Kubernetes API accessibility:"
kubectl exec vulnerable-pod -- nc -zv kubernetes.default.svc 443 2>&1 | grep -E "(open|succeeded)"
