#!/usr/bin/env bash

# Prep system for install
source ${BASH_SOURCE%/*}/prep_install.sh

# Setup rclone
source ${BASH_SOURCE%/*}/setup_rclone.sh

# Setup services
source ${BASH_SOURCE%/*}/setup_services.sh

# Setup Plex with claim token
source ${BASH_SOURCE%/*}/setup_plex.sh

# Setup backups
source ${BASH_SOURCE%/*}/setup_backup.sh

read -r -p "Would you like to restore service configs from backups? [y/N] " RESPONSE
RESPONSE=${RESPONSE,,}
if [[ "$RESPONSE" =~ ^(yes|y)$ ]]
  source ${BASH_SOURCE%/*}/restore_services.sh
fi

echo -e "\n\n"
echo "You should now be able to reach all of your services at https://<hostname> using /lidarr, /radarr, /sonarr, etc."
echo "Done."
