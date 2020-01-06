#!/usr/bin/env bash

source ${BASH_SOURCE%/*}/variables.sh

# Get claim token from https://plex.tv/claim
read -p "Enter your Plex claim token (default value: claim-XXXXX): " CLAIMTOKEN
CLAIMTOKEN=${CLAIMTOKEN:-claim-XXXXX}


# Setup cronjob
echo "Copying backup configuration to /etc/cron.d"
sudo sed -i "s~%%CLAIM_TOKEN%%~${CLAIMTOKEN}~" ${SYSTEMDDIR}/plex.service
sudo systemctl daemon-reload
sudo systemctl restart plex

echo "Done setting up Plex"
