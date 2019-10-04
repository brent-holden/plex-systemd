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
for SERVICE in "${SERVICES[@]}"; do
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

# Copy service file over
echo "Copying $SERVICE.service"
cp $SYSTEMDFILESDIR/$SERVICE.service $SYSTEMDDIR
echo "Done extracting files"

systemctl daemon-reload

# Enable and start services
systemctl enable $SERVICE
systemctl start $SERVICE

done

# Change directory ownership
chown -R $PLEXUSER.$PLEXUSER $OPTDIR

# Copy in cron job to /etc/cron.d
source setup_cron.sh

# Set default zone to trusted assuming you're on a private net behind a firewall
sudo firewall-cmd --set-default-zone=trusted

echo "Done"
