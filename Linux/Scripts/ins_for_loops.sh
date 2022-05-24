#!/bin/bash

# for <item> in <list>
# do
#   <run_this_command>
#   <run_this_command>
# done

# List Variables
months=(
    'January'
    'February'
    'March'
    'April'
    'May'
    'June'
    'July'
    'August'
    'September'
    'October'
    'November'
    'December'
)
days=('Mon' 'Tues' 'Wed' 'Thur' 'Fri' 'Sat' 'Sun')

# Create for loops

# Print out months
for month in ${months[@]}
do
    echo $month
done
echo

#print out the days of the week
for day in ${days[@]}
do
    if [ $day = 'Sun' ] || [ $day = 'Sat' ]
    then
        echo "It is $day! Take it easy."
    else
        echo "It is a $day! Get to work!"
    fi
done
echo

# Run a command on each file
for file in $(ls)
do
    ls -lah $file
done
echo

# Dislay the number if it's a 1 or 4
for num in {0..5}
do
     if [ $num = 1 ] || [ $num = 4 ]
     then
	  echo $num
     fi
done
