#!/usr/bin/env bash

sudo cp ../cron/backup-plex /etc/cron.d
sudo systemctl restart crond
