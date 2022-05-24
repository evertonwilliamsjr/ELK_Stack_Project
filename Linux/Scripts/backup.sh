#!/bin/bash

# Create /var/backup if it doesn't exist
mkdir -p /var/backup

# Creates a compressed archive of '/home' and saves it to '/var/backup/home.tar.gz'
tar czvf /var/backup/home.tar.gz /home

# Moves the file '/var/backup/home.tar' to '/var/backup/home.MMDDYYYY.tar'
mv /var/backup/home.tar.gz /var/backup/home.03172022.tar.gz

# List all files in '/var/backup', including file sizes, and save the output to '/var/backup/file_report.txt'
ls -lh /var/backup > /var/backup/file_report.txt

# Prints how much free memory your machine has left. Save this to a file called '/var/backup/disk_report.txt'
free -h > /var/backup/disk_report.txt
