#!/bin/bash

# Shows free memory output to a free_mem.txt file
free -hw > ~/backups/freemem/free_mem.txt

# Shows disk usage output to a disk_usage.txt file
du -h > ~/backups/diskuse/disk_usage.txt

# List open files to a open_list.txt file
sudo lsof > ~/backups/openlist/open_list.txt

# Shows free disk space to a free_disk.txt file
df -h > ~/backups/freedisk/free_disk.txt
