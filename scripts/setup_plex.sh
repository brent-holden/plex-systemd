#!/usr/bin/env bash

source ${BASH_SOURCE%/*}/variables.sh

# Get current directory of the repo
REPODIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )

# Setup cronjob
echo "Copying backup configuration to /etc/cron.d"
sudo sed -i "s~%%CLAIM_TOKEN%%~${CLAIMTOKEN}~" ${SYSTEMDDIR}/plex.service
sudo systemctl daemon-reload
sudo systemctl restart plex

echo "Done setting up backups"
