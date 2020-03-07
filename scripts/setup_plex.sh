#!/usr/bin/env bash

source ${BASH_SOURCE%/*}/variables.sh

echo -e "\n\n### Setting up Plex ###\n\n"

# Get claim token from https://plex.tv/claim
read -p "Enter your Plex claim token (default value: claim-XXXXX): " CLAIMTOKEN
CLAIMTOKEN=${CLAIMTOKEN:-claim-XXXXX}


# Setup cronjob
echo "Modifying plex service unit to include claim token $CLAIMTOKEN"
sudo sed -i "s~%%CLAIM_TOKEN%%~${CLAIMTOKEN}~" ${SYSTEMDDIR}/plex.service

# Reload systemd
echo "Reloading systemd"
sudo systemctl daemon-reload

#echo "Restarting Plex"
sudo systemctl restart plex

echo "Done setting up Plex"
