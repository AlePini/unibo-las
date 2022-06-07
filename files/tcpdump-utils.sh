#!/bin/bash

# 14:28:00.337695 IP 10.10.10.254.59574 > 10.10.10.101.22: Flags [.], ack 373, win 1002, options [nop,nop,TS val 2109176016 ecr 524796248], length 0
function parse-tcp() {
  tcpdump -i eth1 -nl tcp | while read TS IP SRC DIR DST RESTO; do
    DST=$(cut -f1 -d: <<<$DST)
    SIP=$(cut -f1-4 -d. <<<$SRC)
    DIP=$(cut -f1-4 -d. <<<$DST)
    SPT=$(cut -f5 -d. <<<$SRC)
    DPT=$(cut -f5 -d. <<<$DST)

    echo "${SIP}:${SPT} $DIR ${DIP}:${DPT} - ${RESTO}"
  done
}

# 14:42:06.022146 IP 10.10.10.101.46193 > 10.10.10.254.53: 3835+ A? google.com. (28)
function parse-udp() {
  tcpdump -i eth1 -nl udp | while read TS IP SRC DIR DST RESTO; do
    DST=$(cut -f1 -d: <<<$DST)
    SIP=$(cut -f1-4 -d. <<<$SRC)
    DIP=$(cut -f1-4 -d. <<<$DST)
    SPT=$(cut -f5 -d. <<<$SRC)
    DPT=$(cut -f5 -d. <<<$DST)

    echo "${SIP}:${SPT} $DIR ${DIP}:${DPT} - ${RESTO}"
  done
}

# 14:38:00.401013 IP 10.10.10.254 > 10.10.10.101: ICMP echo request, id 50409, seq 1, length 64
function parse-icmp() {
  tcpdump -i eth1 -nl icmp | while read TS IP SRC DIR DST RESTO; do
    DST=$(cut -f1 -d: <<<$DST)
    SIP=$(cut -f1-4 -d. <<<$SRC)
    DIP=$(cut -f1-4 -d. <<<$DST)

    echo "${SIP} $DIR ${DIP} - ${RESTO}"
  done
}
