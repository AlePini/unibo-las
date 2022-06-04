#!/bin/bash

SNMP_CREATE='NET-SNMP-EXTEND-MIB::nsExtendOutputFull."createdump"'
SNMP_DELETE='NET-SNMP-EXTEND-MIB::nsExtendOutputFull."deletedump"'

LOG_FILE="/var/log/dump.log"

if [[ $((($(date +%M) / 3) % 2)) -eq 0 ]]; then
  AGENT_IP="10.10.10.101"
else
  AGENT_IP="10.10.10.102"
fi
echo "Agent IP: $AGENT_IP"

# start script via snmp
snmpget -v 1 -c public $AGENT_IP $SNMP_CREATE &

# wait for the dump to be created
dump_file=$(tail -n 0 -f $LOG_FILE | head -n 1 | awk -F 'dump-created:' '{print $2}')
echo "Dump file: $dump_file"
scp -i /home/vagrant/.ssh/id_rsa -o StrictHostKeyChecking=no vagrant@$AGENT_IP:$dump_file $HOME || exit 1
logger -n $AGENT_IP -p local0.info "dump-downloaded:$dump_file"
snmpget -v 1 -c public $AGENT_IP $SNMP_DELETE
