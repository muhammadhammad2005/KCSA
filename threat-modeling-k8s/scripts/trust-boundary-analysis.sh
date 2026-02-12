#!/bin/bash
echo "=== TRUST BOUNDARY ANALYSIS ==="
echo "1. EXTERNAL TRUST BOUNDARY: Internet -> LoadBalancer -> Frontend Service (UNTRUSTED)"
echo "2. FRONTEND TRUST BOUNDARY: Frontend Pods -> Backend Service (SEMI-TRUSTED)"
echo "3. BACKEND TRUST BOUNDARY: Backend Pods -> Database Service (TRUSTED)"
echo "4. INTERNAL CLUSTER BOUNDARIES: Pod-to-Pod, Service-to-Service, Node-to-Node"
echo "=== NETWORK POLICIES ANALYSIS ==="
kubectl get networkpolicies -n threat-modeling-lab || echo "No network policies - ALL TRAFFIC ALLOWED"
echo "=== SERVICE ACCOUNT ANALYSIS ==="
kubectl get serviceaccounts -n threat-modeling-lab
kubectl describe serviceaccount default -n threat-modeling-lab
