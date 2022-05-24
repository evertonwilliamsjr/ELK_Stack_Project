#!/bin/bash

# List of favorite U.S. states
states=('Hawaii' 'Georgia' 'Texas' 'California' 'Florida' )

for i in ${states[@]};
do
     if [ $i == 'Hawaii' ]
     then
	echo "$i is the best!"
     else
	echo "I'm not fond of $i."
     fi
done

