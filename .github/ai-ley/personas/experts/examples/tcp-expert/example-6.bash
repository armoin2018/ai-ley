#!/bin/bash
# TCP performance monitoring script
while true; do
    ss -i | grep cwnd
    cat /proc/net/netstat | grep Tcp
    tcpdump -c 1000 -i eth0 -w capture.pcap
    sleep 1
done