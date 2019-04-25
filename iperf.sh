#!/bin/bash 
#qsize=$1
cong=$1
iperf -c 10.0.0.3 -p 5001 -t 3600 -i 1 -Z $cong > iperf.txt &
echo started iperf

