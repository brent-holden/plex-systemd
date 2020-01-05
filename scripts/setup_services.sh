#!/usr/bin/env bash

source ${BASH_SOURCE%/*}/variables.sh

# Loop over services defined
for SERVICE in "${SERVICES[@]}"; do
SVCDIR=$OPTDIR/$SERVICE

# Create the service directory
sudo mkdir -p $SVCDIR

# Change directory ownership
sudo chown -R $PLEXUSER.$PLEXUSER $SVCDIR

# Copy service file over
echo "Copying $SERVICE.service"
sudo cp ${BASH_SOURCE%/*}/$SYSTEMDSVCFILESDIR/$SERVICE.service $SYSTEMDDIR

# Reload systemd
sudo systemctl daemon-reload

# Enable and start services
sudo systemctl enable $SERVICE
sudo systemctl start $SERVICE

done

echo "Done installing services"
