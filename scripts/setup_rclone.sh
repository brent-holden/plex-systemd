#!/usr/bin/env bash

source variables.sh

sudo yum install -y vim
sudo adduser $PLEXUSER --uid=$PLEXUID -U
sudo mkdir -p $DOWNLOADSDIR
sudo mkdir -p $RCLONEMEDIADIR
sudo mkdir -p $RCLONEBACKUPDIR
sudo mkdir -p $RCLONECONFIGDIR

read -p "Point me to rclone.conf (default value: /root/.config/rclone/rclone.conf): " RCLONECONF
RCLONECONF=${RCLONECONF:-/root/.config/rclone/rclone.conf}

if [ ! -f "$RCLONECONF" ]; then
	echo "File not found. Exiting"
	exit 1
else
	sudo cp $RCLONECONF $RCLONECONFIGDIR
fi

sudo yum install -y https://downloads.rclone.org/rclone-current-linux-amd64.rpm

sudo cp $SYSTEMDSVCFILESDIR/rclone* $SYSTEMDDIR
sudo systemctl daemon-reload

sudo systemctl enable rclone-media-drive
sudo systemctl start rclone-media-drive

sudo systemctl enable rclone-backup-drive
sudo systemctl start rclone-backup-drive

sudo systemctl enable rclone-web
sudo systemctl start rclone-web
