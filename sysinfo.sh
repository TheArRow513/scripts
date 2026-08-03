#!/bin/bash
echo "===================================================="
echo "			System Information"
echo "===================================================="

echo "Hostname: $(hostname)"
echo "User: $(whoami)"
echo "Date: $(date)"
echo""

echo "OS:"
cat /etc/os-release | grep PRETTY_NAME

echo ""

echo "kernal:"
uname -r

echo "CPU"
lscpu | grep "Model name" | cut -d ':' -f2

echo""

echo "Memory"
free -h

echo""

echo "Disk:"
df -h /

echo""

echo"Uptime:"
uptime -p

echo""

