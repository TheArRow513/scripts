#!/bin/bash
echo "===================================================="
echo "			System Information"
echo "===================================================="

echo "Hostname: $(hostname)"
echo "User: $(whoami)"
echo "Date: $(date)"
echo ""

echo "===================================================="
echo "                  Operating System"
echo "===================================================="


if [ -f /etc/os-release ]; then
	grep PRETTY_NAME /etc/os-realease | cut -d '"' -f2
fi

echo "kernal	: $(uname -r)"
echo ""

echo "===================================================="
echo "                  CPU Information"
echo "===================================================="

echo "CPU	:$(lscpu | grep "Model name" | cut -d ':' -f2 | sed 's/^ *//')"
echo "cores	:$(nproc)"
echo ""

echo "===================================================="
echo "                  Memory"
echo "===================================================="

free -h

echo ""

echo "===================================================="
echo "                  Storage"
echo "===================================================="

df -h /

echo ""

echo "===================================================="
echo "                  Network"
echo "===================================================="

INTERFACE=$(ip route | grep default | awk '{print $5}')
echo "Interface: $INTERFACE"

echo "Local IP : $(ip -r addr show $INTERFACE | grep inet | awk '{print $2}' | cut -d/ -f1)"

echo "MAC addr : $(cat /sys/class/net/$INTERFACE/address)"

echo ""

echo "================================="
echo "        UPTIME"
echo "================================="
uptime -p

echo ""

echo "================================="
echo "        System Status"
echo "================================="

echo "Runing Processes: $(ps aux | wc -l)"
echo "Logged users: $(who | wc -l)"

echo ""
echo "================================="
echo "             DONE"
echo "================================="

