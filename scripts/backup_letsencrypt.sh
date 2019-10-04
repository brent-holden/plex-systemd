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
SERVICE=letsencrypt
FILENAME=backup-$SERVICE-$DATE.tar.gz
LATEST=backup-$SERVICE-latest.tar.gz
SRCDIR=$OPTDIR/$SERVICE
DESTDIR=$RCLONEDIR/$SERVICE

# Change into service directory
cd $SRCDIR

# Create the backup file
echo "Backing up $SRCDIR"
tar -cpzf $TMPDIR/$FILENAME . 2>/dev/null

# Move it to the right place
echo "Moving $FILENAME to $DESTDIR"
mv $TMPDIR/$FILENAME $DESTDIR 

# Copy to a latest release because softlinks don't work yet
cp $DESTDIR/$FILENAME $DESTDIR/$LATEST

# Remove all backups older than 30 days
find $RCLONEDIR/$SERVICE -type f -name '*.tar.gz' -mtime +30 -exec rm {} \;
cd $CWD
