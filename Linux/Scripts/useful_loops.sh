#!/bin/bash

# Paths of the shadow and passwd files
paths=('/etc/shadow' '/etc/passwd')

# Add a sentence to display before listing the permissions
echo -e "\nThe permissions for sensitive /etc files: \n"


# Print the permissions of the shadow and passwd files
for p in ${paths[@]};
do 
     ls -l $p
done

