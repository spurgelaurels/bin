#!/bin/bash
# Script to rsync home directory somewhere else 

$USER=`whoami`
$HOSTNAME=`hostname`

if [ ! -f /var/tmp/ignorelist ]; then
    echo "File not found!"
    wget https://raw.githubusercontent.com/rubo77/rsync-homedir-excludes/master/rsync-homedir-excludes.txt -O /var/tmp/ignorelist
fi
 
echo "Backing up!"
rsync -aP --exclude-from=/var/tmp/ignorelist /home/$USER/ /mnt/backup/$HOSTNAME/

