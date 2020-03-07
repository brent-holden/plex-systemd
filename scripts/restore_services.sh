#!/usr/bin/env bash

source ${BASH_SOURCE%/*}/variables.sh

echo -e "\n\n### Restoring Services from Backups ###\n\n"

# Test to make sure we're mounted or exit
if $(mountpoint -q "$RCLONEBACKUPDIR"); then
    echo "$RCLONEBACKUPDIR is mounted. Let's do this!"
else
    echo "$RCLONEBACKUPDIR is not a mounted. Exiting"
    exit 1
fi

read -p "Set of backups to restore in DD-MM-YYYY (e.g. 13-01-2019) (default value: latest): " BACKUPDATE
BACKUPDATE=${BACKUPDATE:-latest}

# Change to temporary dir
cd $TMPDIR

# Loop over services defined
for SERVICE in "${SERVICES[@]}"; do

  # Set some variables
  LATEST=backup_$BACKUPDATE.tar.gz
  SRCDIR=$RCLONEBACKUPDIR/$SERVICE
  DESTDIR=$OPTDIR/$SERVICE

  # Stop service before config restoration
  echo "Stopping $SERVICE"
  sudo systemctl stop $SERVICE

  # Copy the backup over locally
  echo "Copying over backup $SRCDIR/$LATEST to $TMPDIR"
  sudo rsync --info=progress $SRCDIR/$LATEST $TMPDIR
  #cp $SRCDIR/$LATEST $TMPDIR

  # Extract the backup file
  echo "Extracting backup to $DESTDIR"
  sudo tar -zxf $TMPDIR/$LATEST --directory $DESTDIR
  echo "Done extracting files"

  # Change directory ownership
  echo "Changing directory ownership of $DESTDIR to $PLEXUSER.$PLEXGROUP"
  sudo chown -R $PLEXUSER.$PLEXUSER $DESTDIR

  # Start service
  #echo "Starting $SERVICE"
  #sudo systemctl start $SERVICE

done

echo "Finished restoring services from backup $BACKUPDATE"
