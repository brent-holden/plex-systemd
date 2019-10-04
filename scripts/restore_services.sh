#!/usr/bin/env bash

source variables.sh

# Test to make sure we're mounted or exit
if $(mountpoint -q "$RCLONEBACKUPDIR"); then
    echo "$RCLONEBACKUPDIR is mounted. Let's do this"
else
    echo "$RCLONEBACKUPDIR is not a mounted. Exiting"
    exit 1
fi

# Change to temporary dir
cd $TMPDIR

# Loop over services defined
for SERVICE in "${SERVICES[@]}"; do
LATEST=backup-$SERVICE-latest.tar.gz
SRCDIR=$RCLONEBACKUPDIR/$SERVICE
DESTDIR=$OPTDIR/$SERVICE

# Create the service directory
sudo mkdir -p $DESTDIR

# Copy the backup over locally
cp $SRCDIR/$LATEST $TMPDIR

# Extract the backup file
echo "Extracting backup to $DESTDIR"
sudo tar -zxf $TMPDIR/$LATEST --directory $DESTDIR

# Copy service file over
echo "Copying $SERVICE.service"
sudo cp $SYSTEMDSVCFILESDIR/$SERVICE.service $SYSTEMDDIR
echo "Done extracting files"

sudo systemctl daemon-reload

# Enable and start services
sudo systemctl enable $SERVICE
sudo systemctl start $SERVICE

done

# Change directory ownership
sudo chown -R $PLEXUSER.$PLEXUSER $OPTDIR

# Copy in cron job to /etc/cron.d
source setup_cron.sh

# Set default zone to trusted assuming you're on a private net behind a firewall
sudo firewall-cmd --set-default-zone=trusted

echo "Done"
