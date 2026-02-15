#!/bin/bash

NAMESPACE="threat-modeling-lab"

echo "=== KUBERNETES ASSET INVENTORY REPORT ==="
echo "Generated at: $(date)"
echo

echo "=== CLUSTER NODES ==="
kubectl get nodes -o wide
echo

echo "=== NAMESPACES ==="
kubectl get namespaces
echo

echo "=== WORKLOADS ($NAMESPACE) ==="
kubectl get pods -n $NAMESPACE -o wide
kubectl get deployments -n $NAMESPACE
kubectl get services -n $NAMESPACE
echo

echo "=== SECRETS ($NAMESPACE) ==="
kubectl get secrets -n $NAMESPACE
echo

echo "=== CONFIGMAPS ($NAMESPACE) ==="
kubectl get configmaps -n $NAMESPACE
echo

echo "=== STORAGE ==="
kubectl get pv
kubectl get pvc -n $NAMESPACE
echo

echo "=== RBAC ROLES ==="
kubectl get roles -n $NAMESPACE
kubectl get rolebindings -n $NAMESPACE
kubectl get clusterroles | head -20
echo

echo "=== NETWORK POLICIES ==="
kubectl get networkpolicies -n $NAMESPACE
echo

echo "=== SECURITY CONTEXTS ==="
kubectl get pods -n $NAMESPACE -o jsonpath='{range .items[*]}{.metadata.name}{" -> runAsUser="}{.spec.securityContext.runAsUser}{"\n"}{end}'
echo

echo "Asset inventory completed."

