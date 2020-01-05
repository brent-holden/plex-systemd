#!/usr/bin/env bash

sudo cp ${BASH_SOURCE%/*}/../cron/backup-plex /etc/cron.d
sudo systemctl restart crond
