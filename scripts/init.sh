#!/bin/bash

user=$(whoami)

snmpget -v 1 -c public localhost NET-SNMP-EXTEND-MIB::nsExtendOutputFull.\"homedir\"

while [[ ! -d /home/$user ]]; do
  sleep 5
done

cd /home/$user

[[ ! -e /home/$user/.ssh/id_rsa.pub ]] && { ssh-keygen -t rsa -b 2048 -f id_rsa }

cat /home/$user/.ssh/id_rsa.pub | logger -p local5.info

/bin/bash
