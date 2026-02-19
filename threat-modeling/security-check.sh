#!/bin/bash
echo "=== Security Checks ==="
echo "Timestamp: $(date)"
echo "--------------------------"

FRONTEND_PODS=$(kubectl get pods -l app=frontend-web -o jsonpath='{.items[*].metadata.name}')
BACKEND_PODS=$(kubectl get pods -l app=backend-api -o jsonpath='{.items[*].metadata.name}')

echo "--- Pod Security Context ---"
kubectl get pods -o jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.spec.securityContext.runAsNonRoot}{"\t"}{range .spec.containers[*]}{.securityContext.allowPrivilegeEscalation}{" "} {end}{"\n"}{end}'

echo "--- Network Connectivity Checks ---"
for pod in $FRONTEND_PODS; do
    echo "Checking from frontend pod: $pod"
    if kubectl exec "$pod" -- wget -qO- http://backend-service:8080 >/dev/null 2>&1; then
        echo "Frontend → Backend: Allowed ✅"
    else
        echo "Frontend → Backend: Blocked ❌"
    fi

    if kubectl exec "$pod" -- nc -z -w 2 postgres-service 5432 >/dev/null 2>&1; then
        echo "Frontend → Database: Allowed (risk!) ⚠️"
    else
        echo "Frontend → Database: Blocked ✅"
    fi
done

for pod in $BACKEND_PODS; do
    echo "Checking from backend pod: $pod"
    if kubectl exec "$pod" -- nc -z -w 2 postgres-service 5432 >/dev/null 2>&1; then
        echo "Backend → Database: Allowed ✅"
    else
        echo "Backend → Database: Blocked ❌"
    fi
done

echo "--- Security Check Complete ---"

