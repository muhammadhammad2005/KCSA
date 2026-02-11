#!/bin/bash

TARGET=${1:-http://productpage.default.svc.cluster.local}
REQUESTS=${2:-100}
INTERVAL=${3:-2}

SUCCESS=0
FAIL=0

echo "Target: $TARGET"
echo "Requests: $REQUESTS"
echo "Interval: ${INTERVAL}s"
echo "--------------------------"

for ((i=1; i<=REQUESTS; i++)); do
  HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$TARGET")
  
  if [ "$HTTP_CODE" == "200" ]; then
    echo "[$i] OK"
    SUCCESS=$((SUCCESS+1))
  else
    echo "[$i] FAIL (HTTP $HTTP_CODE)"
    FAIL=$((FAIL+1))
  fi
  
  sleep $INTERVAL
done

echo "--------------------------"
echo "Success: $SUCCESS"
echo "Failed: $FAIL"

if [ $FAIL -gt 0 ]; then
  exit 1
else
  exit 0
fi

