#!/bin/bash
echo "start ccp expr"
sudo sysctl -w net.ipv4.tcp_congestion_control=reno
sudo sysctl -w net.ipv4.tcp_min_tso_segs=1
myexpr=$1
python bufferbloat.py --bw-host 1000 \
                --bw-net 1.5 \
                --delay 30 \
                --dir ./ \
                --nflows 1 \
                --maxq 10000 \
                -n 3 \
                --myexpr $myexpr

echo "cleaning up..."
killall -9 iperf ping
mn -c > /dev/null 2>&1
echo "end"
