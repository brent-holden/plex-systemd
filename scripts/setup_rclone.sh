#!/usr/bin/env bash

source variables.sh

sudo yum install -y vim
sudo adduser $PLEXUSER --uid=$PLEXUID -U
sudo mkdir -p /mnt/downloads
sudo mkdir -p /mnt/rclone/{media,backup,cache,cache-db}
sudo mkdir -p /opt/rclone

read -p "Point me to rclone.conf (ex. /root/.config/rclone/rclone.conf): " RCLONECONF
if [ ! -f "$RCLONECONF" ]; then
	echo "File not found. Exiting"
	exit 1
else
	sudo cp $RCLONECONF /opt/rclone
fi

sudo yum install -y https://downloads.rclone.org/rclone-current-linux-amd64.rpm

sudo cp ../systemd/rclone* /usr/lib/systemd/system
sudo systemctl daemon-reload

sudo systemctl enable rclone-media-drive
sudo systemctl start rclone-media-drive

sudo systemctl enable rclone-backup-drive
sudo systemctl start rclone-backup-drive

sudo systemctl enable rclone-web
sudo systemctl start rclone-web
