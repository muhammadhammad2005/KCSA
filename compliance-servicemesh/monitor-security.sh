#!/bin/bash
kubectl logs -n istio-system -l app=istiod --tail=50 | grep -i tls
kubectl logs -l app=productpage -c istio-proxy --tail=20
