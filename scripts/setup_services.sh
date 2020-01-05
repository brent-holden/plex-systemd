#!/usr/bin/env bash

source ${BASH_SOURCE%/*}/variables.sh

# Loop over services defined
for SERVICE in "${SERVICES[@]}"; do
SVCDIR=$OPTDIR/$SERVICE

# Create the service directory
echo "Creating service directory: $SVCDIR"
sudo mkdir -p $SVCDIR

# Change directory ownership
echo "Changing ownership to $PLEXUSER.$PLEXGROUP"
sudo chown -R $PLEXUSER.$PLEXGROUP $SVCDIR

# Copy service file over
echo "Copying $SERVICE.service to $SYSTEMDDIR"
sudo cp ${BASH_SOURCE%/*}/$SYSTEMDSVCFILESDIR/$SERVICE.service $SYSTEMDDIR

# Reload systemd
echo "Reloading systemd"
sudo systemctl daemon-reload

# Enable and start services
echo "Enabling and starting $SERVICE"
sudo systemctl enable $SERVICE
sudo systemctl start $SERVICE

done

echo "Done installing services"
