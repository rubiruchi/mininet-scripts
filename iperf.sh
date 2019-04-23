#!/bin/bash 
#qsize=$1
cong=$1
iperf -c 10.0.0.2 -p 5001 -t 3600 -i 1 -w 10m -Z $cong > iperf.txt &
echo started iperf

