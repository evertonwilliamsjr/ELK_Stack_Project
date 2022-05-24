#!/bin/bash

# Quick setup script for new server

# Make sure the script is run as root.
if [ $UID -ne 0 ]
then
echo "Please run this script with sudo."
  exit
fi

# Create a log file that our script will use to track its progress
log_file=/var/log/setup_script.log

# Log file header
echo "#########################################" >> $log_file
echo "Log file for general server setup script." >> $log_file
echo "#########################################" >> $log_file
echo "Log generated on: $(date)" >> $log_file
echo "#########################################" >> $log_file
echo "" >> $log_file

# List of necessary packages
packages=(
  'nano'
  'wget'
  'net-tools'
  'python'
  'tripwire'
  'tree'
  'curl'
)

# Ensure all packages are installed
for package in ${packages[@]}
do
  if [ ! $(which $package) ]
  then
    apt install -y $package
  fi
done


# Print it out and Log it
echo "$(date) Installed needed pacakges: ${packages[@]}." | tee -a $log_file

# Create the user sysd with no password (password to be created upon login)
useradd ryan
chage -d 0 ryan

# Add the sysd user to the `sudo` group
usermod -aG sudo ryan

# Print and log
echo "$(date) Created ryan user. Password to be created upon login." | tee -a $log_file

# Remove roots login shell and lock the root account (hardening).
usermod -s /sbin/nologin root
usermod -L root

# Print and log
echo "$(date) Disabled root shell. Root user cannot login." | tee -a $log_file

# Change permissions on sensitive files
chmod 600 /etc/shadow
chmod 600 /etc/gshadow
chmod 644 /etc/group
chmod 644 /etc/passwd

# Print and log
echo "$(date) Changed permissions on sensitive /etc files." | tee -a $log_file


# Setup scripts folder
if [ ! -d /home/ryan/scripts ]
then
mkdir -p /home/ryan/scripts
chown ryan:ryan /home/ryan/scripts
fi

# Add scripts folder to .bashrc for ryan 
echo "" >> /home/ryan/.bashrc
echo "PATH=$PATH:/home/ryan/scripts" >> /home/ryan/.bashrc
echo "" >> /home/ryan/.bashrc

# Print and log
echo "$(date) Added ~/scripts directory to ryan's PATH." | tee -a $log_file

#Adding a few customer aliases might be nice too!

# Add custom aliases to /home/ryan/.bashrc
echo "#Custom Aliases" >> /home/ryan/.bashrc
echo "alias reload='source ~/.bashrc && echo Bash config reloaded'" >> /home/ryan/.bashrc
echo "alias lsa='ls -a'" >> /home/ryan/.bashrc
echo "alias docs='cd ~/Documents'" >> /home/ryan/.bashrc
echo "alias dwn='cd ~/Downloads'" >> /home/ryan/.bashrc
echo "alias etc='cd /etc'" >> /home/ryan/.bashrc
echo "alias rc='nano ~/.bashrc'" >> /home/ryan/.bashrc

# Print and log
echo "$(date) Added custom alias collection to ryan's .bashrc." | tee -a $log_file

#Print out and log Exit
echo "$(date) Script Finished. Exiting."
echo "$(date) Script Finished. Exiting." >> $log_file

exit
