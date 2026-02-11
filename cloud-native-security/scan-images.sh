#!/bin/bash
set -e

IMAGES_FILE="images.txt"
REPORT_DIR="security-reports"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

mkdir -p $REPORT_DIR

if [ ! -f "$IMAGES_FILE" ]; then
  echo "images.txt not found. Creating default list..."
  cat <<EOF > images.txt
nodegoat:vulnerable
nodegoat:secure
nginx:1.21-alpine
EOF
fi

echo "Starting vulnerability scan..."
echo "Report time: $TIMESTAMP"
echo "----------------------------------"

while read -r img; do
  echo "Scanning $img"
  trivy image \
    --severity HIGH,CRITICAL \
    --format json \
    --output $REPORT_DIR/${img//[:\/]/_}_$TIMESTAMP.json \
    $img
done < $IMAGES_FILE

echo "----------------------------------"
echo "Scan complete. Reports saved in $REPORT_DIR/"

