#!/bin/bash
IMAGE_NAME=$1
PRIVATE_KEY_PATH="../keys/cosign.key"

cosign sign --key "$PRIVATE_KEY_PATH" "$IMAGE_NAME"
cosign verify --key "../keys/cosign.pub" "$IMAGE_NAME"
