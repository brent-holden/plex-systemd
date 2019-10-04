#!/usr/bin/env bash

SERVICES=(lidarr sonarr radarr tautulli hydra2 sabnzbd nginx plex)
DATE=`date +%d-%m-%Y`
OPTDIR=/opt
TMPDIR=/tmp
RCLONEDIR=/mnt/rclone
RCLONEMEDIADIR=$RCLONEDIR/media
RCLONECACHEDIR=$RCLONEDIR/cache-db
RCLONEBACKUPDIR=$RCLONEDIR/backup
RCLONECONFIGDIR=$OPTDIR/rclone
DOWNLOADSDIR=/mnt/downloads
SYSTEMDSVCFILESDIR=../systemd
SYSTEMDDIR=/usr/lib/systemd/systemd
PLEXUSER=plex
PLEXUID=1100
