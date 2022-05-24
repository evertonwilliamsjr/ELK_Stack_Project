#!/bin/bash


mkdir ~/research 2> /dev/null

# Naming variables
output=$HOME/research/sys_info.txt

echo -e "A Quick System Audit Script" > $output 
date >> $output
echo -e "\nMachine Type Info:\n"$MACHTYPE >> $output
echo -e "\nUname Info:\n"$(uname -a) >> $output
#echo -e "\nIP Address Info:\n"$(ip addr | head -9 | tail -1 | awk '{print $2}') >> $output
echo -e "\nIP Address Info:\n"$(ip addr | grep -w inet | head -2 | tail -1 | sed -e 's/^[ \t]*//') >> $output
echo -e "\nHostname Info:\n"$(hostname -s) >> $output

echo -e "\nDNS Servers:" >> $output
cat /etc/resolv.conf | sed 1,5d >> $output
echo -e "\nMemory Info:" >> $output
free -h >> $output
echo -e "\nCPU Info:\n"$(lscpu | grep CPU) >> $output
echo -e "\nDisk Usage:" >> $output
df -h | head -2 >> $output
echo -e "\nWho is logged in: \n$(who) \n" >> $output

#echo -e "\n777 Files:"; find / -type f -perm 777 >> $output
#echo -e "\nSUID Files:"; sudo find / -type f -perm /4000 >> $output
echo -e "\nTop 10 Processes:"; ps aux -m | awk '{print $1, $2, $3, $4, $11}' head >> $output

