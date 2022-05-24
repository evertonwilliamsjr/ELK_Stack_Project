#!/bin/bash

echo "Today's date"
date
echo
echo "Machine name"
uname -mo
echo
echo "IP address" 
ip addr | head -9 | tail -1 | awk -F " " '{print $2}'
#ip addr | grep -w inet | head -2 | tail -1
echo
echo "The Hostname"
hostname
