#!/bin/bash

while read line; do
	echo $line | cut -d' ' -f3
done < /var/lib/misc/dnsmasq.leases
