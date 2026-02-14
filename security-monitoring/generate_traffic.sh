#!/bin/bash

TARGET="http://localhost:8080"
LOGFILE="traffic.log"

echo "Starting traffic simulation at $(date)" > $LOGFILE

# Normal user behavior
for i in {1..50}; do
  curl -s -w "USERS %{} %{http_code}\n" -o /dev/null "$TARGET/api/v1/users" >> $LOGFILE &
done

# Failed login attempts (brute force simulation)
for i in {1..20}; do
  curl -s -w "LOGIN_FAIL %{} %{http_code}\n" -o /dev/null \
       -X POST "$TARGET/api/v1/login" \
       -d "username=admin&password=wrongpass" >> $LOGFILE
done

# Suspicious endpoint probing
for i in {1..10}; do
  curl -s -w "PROBE %{} %{http_code}\n" -o /dev/null \
       "$TARGET/admin" >> $LOGFILE
done

echo "Traffic simulation completed at $(date)" >> $LOGFILE

