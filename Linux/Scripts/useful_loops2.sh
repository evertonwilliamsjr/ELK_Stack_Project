#!/bin/bash

commands=('date' 'uname' 'hostname' )

for i in ${commands[@]};
do
	if [ $i == 'date' ];
	then
	  echo "The results of the $i command is: $(date)";

	elif [ $i == 'uname' ];
	then
	  echo "The results of the $i command is: $(uname -a)";

	else
	  echo "The results of the $i command is: $(hostname -s)";
	fi
done
