#!/usr/bin/env bash

source variables.sh

# Test to make sure rclone is mounted or exit
if $(mountpoint -q "$RCLONEDIR"); then
    echo "$RCLONEDIR is mounted. Let's do this"
else
    echo "$RCLONEDIR is not a mounted. Exiting"
    exit 1
fi

CWD=$(pwd)
# Loop over services defined
for SERVICE in "${SERVICES[@]}"; do

# Define variables per service
FILENAME=backup-$SERVICE-$DATE.tar.gz
LATEST=backup-$SERVICE-latest.tar.gz
SRCDIR=$OPTDIR/$SERVICE
DESTDIR=$RCLONEDIR/$SERVICE

# Stop the service
echo "Stopping $SERVICE"
systemctl stop $SERVICE

# Change into service directory
cd $SRCDIR

# Create the backup file
echo "Backing up $SRCDIR"
tar -cpzf $TMPDIR/$FILENAME . 2>/dev/null

# Start service back up
echo "Starting $SERVICE"
systemctl start $SERVICE

# Move it to the right place
echo "Moving $FILENAME to $DESTDIR"
mv $TMPDIR/$FILENAME $DESTDIR 

# Copy to a latest version
rm $DESTDIR/$LATEST
cp $DESTDIR/$FILENAME $DESTDIR/$LATEST

done

# Remove all backups older than 30 days
find $RCLONEDIR -type f -name '*.tar.gz' -mtime +30 -exec rm {} \;

cd $CWD
