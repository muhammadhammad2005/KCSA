#!/bin/bash
for i in {1..100}; do
  curl -s "http://:80/productpage" > /dev/null
  sleep 2
done
