#!/bin/bash

LOG_FILE="/var/log/dump.log"
KEYWORD="dump-downloaded:"

grep $KEYWORD $LOG_FILE | awk -F $KEYWORD '{print $2}' | while read dump_file; do
  if [[ -f "$dump_file" ]]; then
    echo "Removing $dump_file"
    rm "$dump_file" || exit 1
  fi
done
