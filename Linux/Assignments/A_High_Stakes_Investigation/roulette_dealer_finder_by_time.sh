#!/bin/bash


# Syntax for script: ./<script> [MMDD] '[HH:MM:SS AM/PM]'
#Example: ./roulette_dealer_finder_by_time.sh 0310 '08:00:00 AM'
#echo
#echo Date"  "$1
#head -n1 $1_Dealer_schedule | awk '{print $1," " $2, $5, $6}'
#cat $1_Dealer_schedule | awk '{print $1, $2, $5, $6}' |grep -i "$2"
#echo
cd ../Dealer_Analysis

echo
read -p "Enter the Date [MMDD] : " date
read -p "Enter the Time [HH:MM:SS am/pm] : " time_ampm
echo
echo
echo  -n "[Date:" $date -
grep -i "$time_ampm" "$date"_Dealer_schedule |
awk '{print "- Time: " $1, $2 "] Roulette Dealer: " $5, $6}'
echo

