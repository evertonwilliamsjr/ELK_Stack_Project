#!/bin/bash

cd ../Dealer_Analysis

echo
read -p "Enter the Date [MMDD] : " date
read -p "Enter the Time [HH:MM:SS am/pm] : " time_ampm
read -p "Enter Game Number (1-BlackJack, 2-Roulette, 3-Texas Hold EM): " game_number
echo
echo
echo  "Date:" $date 
echo
grep -i "$time_ampm" "$date"_Dealer_schedule |
case "$game_number" in
       "1") awk '{print "- Time: " $1, $2 "] BlackJack Dealer: " $3, $4}'
       ;;
       "2") awk '{print "- Time: " $1, $2 "] Roulette Dealer: " $5, $6}'
       ;;
       "3") awk '{print "- Time: " $1, $2 "] Texas Hold EM Dealer: " $7, $8}'
       ;;
esac
echo


