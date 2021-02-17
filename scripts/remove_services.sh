#!/usr/bin/env bash

source ${BASH_SOURCE%/*}/variables.sh

echo -e "\n\n### Removing Installed Services ###\n\n"

# Loop over services defined
for SERVICE in "${SERVICES[@]}"; do

  # Disable
  echo "Stopping and disabling ${SERVICE}"
  sudo systemctl disable --now ${SERVICE}

  # Remove the unit file
  echo "Removing systemd unit file for ${SERVICE}"
  sudo rm -f ${SYSTEMDDIR}/${SERVICE}.service

  # Reload systemd
  echo "Reloading systemd"
  sudo systemctl daemon-reload

done

echo "Done removing services"
