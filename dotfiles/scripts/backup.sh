#!/bin/bash

ADDRESS='192.168.1.138'
USERNAME='jackelofnar'
BACKUP_SRC="$HOME/Documents $HOME/Music $HOME/Videos"
BACKUP_DST="$HOME/.backups"
BACKUP_DATE=$(date +%Y%m%d)
BACKUP_FILENAME="backup-$BACKUP_DATE.tar.gz"

if [ ! -d "$BACKUP_DST" ]; then
	mkdir -p $BACKUP_DST
fi

find $BACKUP_SRC -mtime +31 -delete

tar cvfz $BACKUP_DST/$BACKUP_FILENAME ~/Music ~/Documents

if [ $? -eq 0 ]; then
    rsync -a ~/.backups $USERNAME@$ADDRESS:/volume1/Backups/linux/
    notify-send 'System backup done'
else
    notify-send "Backup failed"
fi