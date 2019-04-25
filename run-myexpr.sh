#!/bin/bash
echo "start ccp expr"
sudo sysctl -w net.ipv4.tcp_congestion_control=reno
sudo sysctl -w net.ipv4.tcp_min_tso_segs=1
if [[ $# == 0 ]]; then
    echo "Error: Please specify 1~2 congestion control algorithm"
    exit
fi
cc1=$1

if [[ $# == 2 ]]; then
    cc2=$2
elif [[ $# > 2 ]]; then
    echo "Error: Fail to parse the parameters."
    exit
fi

if [[ $# == 1 ]]; then
    python bufferbloat.py --bw-host 1000 \
                --bw-net 1.5 \
                --delay 30 \
                --dir ./ \
                --nflows 1 \
                --maxq 10000 \
                -n 3 \
                --cc1 $cc1

elif [[ $# == 2 ]]; then
    python bufferbloat.py --bw-host 1000 \
                --bw-net 1.5 \
                --delay 30 \
                --dir ./ \
                --nflows 1 \
                --maxq 10000 \
                -n 3 \
                --cc1 $cc1 \
                --cc2 $cc2
fi

echo "cleaning up..."
killall -9 iperf ping
mn -c > /dev/null 2>&1
echo "end"
