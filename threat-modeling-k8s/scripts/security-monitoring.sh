#!/bin/bash
echo "=== SECURITY MONITORING ==="
kubectl get events --field-selector reason=FailedMount -n threat-modeling-lab
kubectl get pods -o jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.spec.securityContext.privileged}{"\n"}{end}' -n threat-modeling-lab
kubectl get pods -o jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.spec.securityContext.runAsUser}{"\n"}{end}' -n threat-modeling-lab
kubectl top pods -n threat-modeling-lab 2>/dev/null || echo "Metrics not available"
