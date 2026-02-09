#!/bin/bash
IMAGE_NAME=$1
SEVERITY_THRESHOLD=${2:-HIGH,CRITICAL}
OUTPUT_FORMAT=${3:-table}

if [ -z "$IMAGE_NAME" ]; then
    echo "Usage: $0 <image_name> [severity_threshold] [output_format]"
    exit 1
fi

mkdir -p ../reports

if [ "$OUTPUT_FORMAT" = "json" ]; then
    trivy image --severity "$SEVERITY_THRESHOLD" --format json --output "../reports/$(basename $IMAGE_NAME)-scan.json" "$IMAGE_NAME"
    VULN_COUNT=$(jq '[.Results[]?.Vulnerabilities // []] | add | length' "../reports/$(basename $IMAGE_NAME)-scan.json")
    echo "Found $VULN_COUNT vulnerabilities"
    if [ "$VULN_COUNT" -gt 0 ]; then
        echo "❌ Vulnerabilities found!"
        exit 1
    else
        echo "✅ No vulnerabilities found!"
        exit 0
    fi
else
    trivy image --severity "$SEVERITY_THRESHOLD" "$IMAGE_NAME"
fi
