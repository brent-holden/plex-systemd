#!/usr/bin/env bash

source variables.sh

# Test to make sure we're mounted or exit
if $(mountpoint -q "$RCLONEDIR"); then
    echo "$RCLONEDIR is mounted. Let's do this"
else
    echo "$RCLONEDIR is not a mounted. Exiting"
    exit 1
fi

# Change to temporary dir
cd $TMPDIR

# Loop over services defined
SERVICE=letsencrypt
LATEST=backup-$SERVICE-latest.tar.gz
SRCDIR=$RCLONEDIR/$SERVICE
DESTDIR=$OPTDIR/$SERVICE

# Create the service directory
mkdir -p $DESTDIR

# Copy the backup over locally
cp $SRCDIR/$LATEST $TMPDIR

# Extract the backup file
echo "Extracting backup to $DESTDIR"
tar -zxf $TMPDIR/$LATEST --directory $DESTDIR

echo "Done extracting files"

# Change directory ownership
chown -R $PLEXUSER.$PLEXUSER $OPTDIR

echo "Done"
