#!/bin/bash
echo "=== Compliance Report ==="
kubectl get pods -n gatekeeper-system
kubectl get constrainttemplates
kubectl get constraints
for c in $(kubectl get constraints -o name); do
  echo "----"
  kubectl describe $c | grep -i violation
done
