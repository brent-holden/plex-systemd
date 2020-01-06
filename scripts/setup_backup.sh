#!/usr/bin/env bash

source ${BASH_SOURCE%/*}/variables.sh

# Test to make sure we're mounted or exit
if $(mountpoint -q "$RCLONEBACKUPDIR"); then
    echo "$RCLONEBACKUPDIR is mounted. Let's do this!"
else
    echo "$RCLONEBACKUPDIR is not a mounted. Exiting"
    exit 1
fi

# Loop over services defined
for SERVICE in "${SERVICES[@]}"; do

BACKUPDIR=$RCLONEBACKUPDIR/$SERVICE

# Create backup directory
echo "Creating $BACKUPDIR"
sudo mkdir -p $BACKUPDIR
sudo chown -R $PLEXUSER.$PLEXGROUP $BACKUPDIR

done

# Get current directory of the repo
REPODIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )

# Setup cronjob
echo "Copying backup configuration to /etc/cron.d"
sudo sed -i "s~%%SCRIPT_REPO%%~${REPODIR}~" ${BASH_SOURCE%/*}/../cron/backup-plex
sudo cp ${BASH_SOURCE%/*}/../cron/backup-plex /etc/cron.d
sudo systemctl restart crond

echo "Done setting up backups"
