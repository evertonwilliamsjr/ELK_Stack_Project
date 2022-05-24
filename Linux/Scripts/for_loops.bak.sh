#!/bin/bash

# List of favorite U.S. states
states=(
	'New Jersey'
	'Georgia'
	'New York'
	'California'
	'Florida'
)
for i in $(state[@])
do
	if [$i = 'Florida'];
	then 
		echo "$i is the best!"
	else 
		echo "I'm not fond of $i."
	fi
done

