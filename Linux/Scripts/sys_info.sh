#!/bin/bash


# Check if script was run as root. Exit if false.
if [ $UID -ne 0 ]
then
  echo "Please run this script with sudo."
  exit
fi
# if [ $USER = 'root' ]
# if [ $(whoami) = 'root' ]


# Define Variables
output=$HOME/research/sys_info.txt
ip=$(ip addr | grep -w inet | head -2 | tail -1 | sed -e 's/^[ \t]*//')
execs=$(find /home -type f -perm 777)

# Check for research directory. Create it if false.
if [ ! -d $HOME/research ]
then
  mkdir $HOME/research
fi

# Check for output file. Clear it if needed.
if [ -f $output ]
then
  rm $output
fi


echo -e "A Quick System Audit Script" > $output 
date >> $output
echo -e "\nMachine Type Info:\n"$MACHTYPE >> $output
echo -e "\nUname Info:\n"$(uname -a) >> $output
echo -e "\nIP Address Info:" >> $output
echo $ip >> $output
echo -e "\nHostname Info:\n"$(hostname -s) >> $output
echo -e "\nDNS Servers:" >> $output
cat /etc/resolv.conf | sed 1,5d >> $output
echo -e "\nMemory Info:" >> $output
free -h >> $output
echo -e "\nCPU Info:\n"$(lscpu | grep CPU) >> $output
echo -e "\nDisk Usage:" >> $output
df -h | head -2 >> $output
echo -e "\nWho is logged in: \n$(who)" >> $output
echo -e "\nexec Files:" >> $output
echo $execs >> $output
echo -e "\nTop 10 Processes:" >> $output
ps aux --sort -%mem | awk '{print $1, $2, $3, $4, $11}' | head >> $output

