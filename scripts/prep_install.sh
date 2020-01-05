#!/usr/bin/env bash

source ${BASH_SOURCE%/*}/variables.sh

# Test to make sure we're mounted or exit
if $(mountpoint -q "$RCLONEBACKUPDIR"); then
    echo "$RCLONEBACKUPDIR is mounted. Let's do this"
else
    echo "$RCLONEBACKUPDIR is not a mounted. Exiting"
    exit 1
fi

# Loop over services defined
for SERVICE in "${SERVICES[@]}"; do

SVCCONFDIR=$OPTDIR/$SERVICE
BACKUPDIR=$RCLONEBACKUPDIR/$SERVICE

echo "Creating $BACKUPDIR"
# Create the service backup directory
sudo mkdir -p $BACKUPDIR
sudo chown -R $PLEXUSER.$PLEXUSER $BACKUPDIR

done

sudo yum -y install vim rsync

