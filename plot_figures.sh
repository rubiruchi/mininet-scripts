#!/bin/bash

if [ $# -ne 1 ]
then
    echo "Usage: `basename $0` {experiment_name}"
exit
fi

exp=$1
IP=`curl http://169.254.169.254/latest/meta-data/public-ipv4 2>/dev/null`
python plot_queue.py --maxy 500 --miny 0 -f ${exp}_sw0-qlen.txt -o ${exp}_queue.png >/dev/null
python plot_tcpprobe.py -f ${exp}_tcpprobe.txt -o ${exp}_tcp_cwnd_iperf.png -p 5001 >/dev/null
python plot_tcpprobe.py -f ${exp}_tcpprobe.txt -o ${exp}_tcp_cwnd_wget.png -p 80 --sport >/dev/null

echo "Use http://$IP:8888/FIGURE_NAME to see the figures on your browser"
echo "Figure Names"
echo "Queue : ${exp}_queue.png"
echo "IPERF CWND : ${exp}_tcp_cwnd_iperf.png"
echo "WGET CWND : ${exp}_tcp_cwnd_wget.png"
python -m SimpleHTTPServer 8888