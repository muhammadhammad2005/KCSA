#!/bin/bash
# Accept full image name with optional tag
INPUT_IMAGE="$1"
DEFAULT_TAG="v1.0.1"

# Check if input already contains a tag
if [[ "$INPUT_IMAGE" == *":"* ]]; then
    FULL_IMAGE_NAME="$INPUT_IMAGE"
else
    FULL_IMAGE_NAME="$INPUT_IMAGE:$DEFAULT_TAG"
fi

# Build, scan, sign, verify
cd ../app/src
docker build -t "$FULL_IMAGE_NAME" .
cd ../../pipeline
./scan-image.sh "$FULL_IMAGE_NAME" HIGH,CRITICAL json
./sign-image.sh "$FULL_IMAGE_NAME"

