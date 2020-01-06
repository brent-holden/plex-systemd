#!/usr/bin/env bash

source ${BASH_SOURCE%/*}/variables.sh

# Test to make sure rclone is mounted or exit
if $(mountpoint -q "$RCLONEBACKUPDIR"); then
    echo "$RCLONEBACKUPDIR is mounted. Let's do this"
else
    echo "$RCLONEBACKUPDIR is not a mounted. Exiting"
    exit 1
fi

CWD=$(pwd)
# Loop over services defined
for SERVICE in "${SERVICES[@]}"; do

# Define variables per service
FILENAME=backup_$DATE.tar.gz
LATEST=backup_latest.tar.gz
SRCDIR=$OPTDIR/$SERVICE
DESTDIR=$RCLONEBACKUPDIR/$SERVICE

# Stop the service
echo "Stopping $SERVICE"
sudo systemctl stop $SERVICE

# Change into service directory
cd $SRCDIR

# Create the backup file
echo "Backing up $SRCDIR"
sudo tar -cpzf $TMPDIR/$FILENAME . 2>/dev/null

# Start service back up
echo "Starting $SERVICE"
sudo systemctl start $SERVICE

# Move it to the right place
echo "Moving $FILENAME to $DESTDIR"
sudo mv $TMPDIR/$FILENAME $DESTDIR 

# Copy to a latest version
sudo rm $DESTDIR/$LATEST
sudo cp $DESTDIR/$FILENAME $DESTDIR/$LATEST

done


cd $CWD
