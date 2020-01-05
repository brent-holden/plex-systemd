#!/usr/bin/env bash

source variables.sh

read -p "Point me to rclone.conf (default value: /root/.config/rclone/rclone.conf): " RCLONECONF
RCLONECONF=${RCLONECONF:-/root/.config/rclone/rclone.conf}

if [ ! -f "$RCLONECONF" ]; then
  echo "File not found. Exiting"
  exit 1
fi

echo "Adding $PLEXUSER with UID:$PLEXUID"
sudo adduser $PLEXUSER --uid=$PLEXUID -U

echo "Making service directories"
sudo mkdir -p $DOWNLOADSDIR
sudo mkdir -p $RCLONEMEDIADIR
sudo mkdir -p $RCLONEBACKUPDIR
sudo mkdir -p $RCLONECONFIGDIR

sudo cp $RCLONECONF $RCLONECONFIGDIR

echo "Installing rclone"
sudo yum install -y https://downloads.rclone.org/rclone-current-linux-amd64.rpm

echo "Copying service files over"
sudo cp $SYSTEMDSVCFILESDIR/rclone* $SYSTEMDDIR
sudo systemctl daemon-reload

echo "Enabling and starting rclone services"
sudo systemctl enable rclone-media-drive
sudo systemctl start rclone-media-drive

sudo systemctl enable rclone-backup-drive
sudo systemctl start rclone-backup-drive

echo "Waiting 5 seconds for rClone to start"
sleep 5

sudo systemctl enable rclone-web
sudo systemctl start rclone-web

# Set default zone to trusted assuming you're on a private net behind a firewall
sudo firewall-cmd --set-default-zone=trusted

echo "rClone Installed"
