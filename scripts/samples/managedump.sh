#!/bin/bash

SNMP_CREATE='NET-SNMP-EXTEND-MIB::nsExtendOutputFull."createdump"'
SNMP_DELETE='NET-SNMP-EXTEND-MIB::nsExtendOutputFull."deletedump"'

LOG_FILE="/var/log/dump.log"
LOCK_FILE="/tmp/dump.lock"

LAST_HOST="/tmp/last_host"
AGENT_1="10.10.10.101"
AGENT_2="10.10.10.102"
AGENT_IP=""

if [[ -f "$LOCK_FILE" ]]; then
  echo "Dump already in progress"
  exit 1
fi
touch "$LOCK_FILE" && echo "Created lock file"

if [[ -f "$LAST_HOST" ]]; then
  AGENT_IP=$(cat "$LAST_HOST")
else
  echo $AGENT_1 >$LAST_HOST
  AGENT_IP=$AGENT_2
fi

if [[ "$AGENT_IP" == "$AGENT_1" ]]; then
  AGENT_IP=$AGENT_2
else
  AGENT_IP=$AGENT_1
fi
echo "Agent IP: $AGENT_IP"
echo $AGENT_IP >$LAST_HOST

# start script via snmp
snmpget -v 1 -c public $AGENT_IP $SNMP_CREATE

# wait for the dump to be created
dump_file=$(tail -n 0 -f $LOG_FILE | head -n 1 | awk -F 'dump-created:' '{print $2}')
echo "Dump file: $dump_file"
scp -i /home/vagrant/.ssh/id_rsa -o StrictHostKeyChecking=no vagrant@$AGENT_IP:$dump_file $HOME || exit 1
logger -n $AGENT_IP -p local0.info "dump-downloaded:$dump_file"
snmpget -v 1 -c public $AGENT_IP $SNMP_DELETE

rm $LOCK_FILE || echo "Cannot remove lock file"
