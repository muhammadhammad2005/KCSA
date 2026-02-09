#!/bin/bash
echo "=== Security Checks ==="

FRONTEND=$(kubectl get pod -l app=frontend-web -o jsonpath='{.items[0].metadata.name}')
BACKEND=$(kubectl get pod -l app=backend-api -o jsonpath='{.items[0].metadata.name}')

# Pod Security
kubectl get pods -o jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.spec.securityContext.runAsNonRoot}{"\t"}{.spec.containers[*].securityContext.allowPrivilegeEscalation}{"\n"}{end}'

# Network Policy
kubectl exec $FRONTEND -- wget -qO- http://backend-service:8080 && echo "Frontend → Backend: Allowed"
kubectl exec $FRONTEND -- nc -zv postgres-service 5432 && echo "Frontend → Database: Allowed (risk!)" || echo "Frontend → Database: Blocked"

kubectl exec $BACKEND -- nc -zv postgres-service 5432 && echo "Backend → Database: Allowed"
