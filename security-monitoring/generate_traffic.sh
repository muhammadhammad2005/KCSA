#!/bin/bash
for i in {1..50}; do
  curl -s http://localhost:8080/api/v1/users > /dev/null &
done

for i in {1..20}; do
  curl -s http://localhost:8080/api/v1/login > /dev/null
done
