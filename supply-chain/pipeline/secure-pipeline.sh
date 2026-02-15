#!/bin/bash
set -e

INPUT_IMAGE="$1"
DEFAULT_TAG="v1.0.1"
SEVERITY="HIGH,CRITICAL"

if [[ -z "$INPUT_IMAGE" ]]; then
  echo "Usage: ./secure-pipeline.sh <image-name[:tag]>"
  exit 1
fi

if [[ "$INPUT_IMAGE" == *":"* ]]; then
  FULL_IMAGE_NAME="$INPUT_IMAGE"
else
  FULL_IMAGE_NAME="$INPUT_IMAGE:$DEFAULT_TAG"
fi

echo "Building image: $FULL_IMAGE_NAME"
cd ../app/src
docker build -t "$FULL_IMAGE_NAME" .
cd ../../pipeline

echo "Running vulnerability scan..."
./scan-image.sh "$FULL_IMAGE_NAME" "$SEVERITY" json

echo "Evaluating scan results..."
CRITICAL_COUNT=$(jq '.Results[].Vulnerabilities[] | select(.Severity=="CRITICAL")' ../app/src/scan-report.json | wc -l)
HIGH_COUNT=$(jq '.Results[].Vulnerabilities[] | select(.Severity=="HIGH")' ../app/src/scan-report.json | wc -l)

echo "CRITICAL: $CRITICAL_COUNT"
echo "HIGH: $HIGH_COUNT"

if [[ "$CRITICAL_COUNT" -gt 0 ]]; then
  echo "Pipeline blocked due to CRITICAL vulnerabilities."
  exit 2
fi

echo "Signing image..."
./sign-image.sh "$FULL_IMAGE_NAME"

echo "Secure pipeline completed successfully."

