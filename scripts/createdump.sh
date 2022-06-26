#!/bin/bash

DUMP_NAME=$(date "+%F-%H-%M")
DUMP_DIR="/tmp"
DUMP_FILE="$DUMP_DIR/$DUMP_NAME.pcap"
PCK_COUNT=10
CTRL_IP="10.10.10.254"

if [[ -f "$DUMP_FILE" ]]; then
  echo "Dump file already exists"
  exit 1
fi

tcpdump -c $PCK_COUNT -w $DUMP_FILE -i eth1

logger -n $CTRL_IP -p local0.info "dump-created:$DUMP_FILE"
