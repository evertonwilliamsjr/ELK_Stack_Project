#!/bin/bash

# Check if script was run as root. Exit if true.
if [ $UID -eq 0 ]
then
  echo "Please do not run this script as root."
  exit
fi

# Defining variables of script
output=$HOME/research/sys_info.txt
ip=$(ip addr | grep inet | tail -2 | head -1)
suids=$(sudo find / -type f -perm /4000 2> /dev/null)

if [ ! -d $HOME/research ]
then
	mkdir $HOME/research
fi

if [ -f $output ]
then
	> $output
fi

echo $ip

#echo $suids
# Challenge: Create a for loop to print out each file on it's own line
for i in $suids
do
	echo $i
done 
