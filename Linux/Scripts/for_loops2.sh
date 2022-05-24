#!/bin/bash

# Variable list of numbers
num_list=(0 1 2 3 4 5 6 7 8 9)

# Variable that holds the output of the command ls
list=$(ls ~/)

# Prints out only the numbers 3,5 and 7 from list of numbers
for i in ${num_list[@]}
do
	if [ $i == 3 ] || [ $i == 5 ] || [ $i == 7 ]
	then
	  echo $i
	fi
done

echo

# Prints out each item of this variable
for l in ${list[0]}
do
	echo $l
done
