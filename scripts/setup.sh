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
then
  source ${BASH_SOURCE%/*}/restore_services.sh
else
  echo "Skipping restoration process"
fi

echo -e "\n"
echo "You should now be able to reach Ombi at https://<hostname>"
echo "Plex will be available at http://<hostname>:32400/web/"
echo "Services will be available at https://<hostname>/{radarr,sonarr,lidarr,tautulli,hydra2,sabnzbd}"
echo -e "\n"
echo "Done with installation. Exiting"
