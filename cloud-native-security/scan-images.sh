#!/bin/bash
images=("nodegoat:vulnerable" "nodegoat:secure" "nginx:1.21-alpine")
for img in "${images[@]}"; do
  echo "Scanning $img"
  trivy image --severity HIGH,CRITICAL $img
  echo "---------------------"
done
