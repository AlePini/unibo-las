# snmpwalk
```bash
snmpwalk -v 1 -c public 10.2.2.2 .1.3.6.1.4.1.2021.2
```
# snmpset
```bash
snmpset -v 1 -c supercom 192.168.56.203 .1.3.6.1.2.1.1.4.0 s "me@unibo.it"
```
# extend mib
/etc/snmp/snmp.conf
```
extend-sh comando echo comando
NET-SNMP-EXTEND-MIB::nsExtendOutputFull."comando"
```
interrogandolo con
```bash
snmpwalk -v 1 -c public  192.168.56.203 NET-SNMP-EXTEND-MIB::nsExtendOutputFull
```