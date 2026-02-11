#!/bin/bash
set -e

REPORT="compliance-report.txt"
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

echo "Compliance Report - $TIMESTAMP" > $REPORT
echo "===============================" >> $REPORT

echo "Checking Gatekeeper status..." >> $REPORT
kubectl get pods -n gatekeeper-system >> $REPORT

echo "" >> $REPORT
echo "Installed ConstraintTemplates:" >> $REPORT
kubectl get constrainttemplates >> $REPORT

echo "" >> $REPORT
echo "Active Constraints:" >> $REPORT
kubectl get constraints >> $REPORT

VIOLATIONS=0

for c in $(kubectl get constraints -o name); do
  echo "" >> $REPORT
  echo "Checking $c" >> $REPORT
  OUTPUT=$(kubectl describe $c | grep -i violation || true)
  if [ -z "$OUTPUT" ]; then
    echo "No violations found" >> $REPORT
  else
    echo "Violations:" >> $REPORT
    echo "$OUTPUT" >> $REPORT
    VIOLATIONS=1
  fi
done

echo "" >> $REPORT
if [ $VIOLATIONS -eq 0 ]; then
  echo "COMPLIANCE STATUS: PASS" >> $REPORT
  echo "All policies enforced successfully."
  exit 0
else
  echo "COMPLIANCE STATUS: FAIL" >> $REPORT
  echo "Policy violations detected."
  exit 1
fi

