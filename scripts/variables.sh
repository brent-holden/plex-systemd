#!/usr/bin/env bash

SERVICES=(lidarr sonarr radarr tautulli hydra2 sabnzbd nginx plex)
DATE=`date +%d-%m-%Y`
RCLONEDIR=/mnt/rclone/backup
SYSTEMDFILESDIR=../systemd
OPTDIR=/opt
TMPDIR=/tmp
SYSTEMDDIR=/usr/lib/systemd/systemd
PLEXUSER=plex
PLEXUID=1100
