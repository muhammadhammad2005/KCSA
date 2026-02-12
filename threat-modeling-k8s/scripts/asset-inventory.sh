#!/bin/bash
echo "=== CRITICAL ASSETS INVENTORY ==="
echo "DATA: Customer DB, Secrets, Config"
echo "COMPUTE: Nodes, Pods, Container runtime"
echo "NETWORK: Cluster network, Load balancer"
echo "SECRETS ANALYSIS:"
kubectl get secrets -n threat-modeling-lab
echo "CONFIGMAPS ANALYSIS:"
kubectl get configmaps -n threat-modeling-lab
echo "PERSISTENT VOLUMES:"
kubectl get pv
kubectl get pvc -n threat-modeling-lab
