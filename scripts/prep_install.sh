#!/usr/bin/env bash

source ${BASH_SOURCE%/*}/variables.sh

# Add the plex user and group with specified UID before doing anything
echo "Adding $PLEXUSER with UID:$PLEXUID"
sudo adduser $PLEXUSER --uid=$PLEXUID -U

# Install packages needed
echo "Installing packages: $PACKAGES"
sudo yum -y install $PACKAGES

# Set default zone to trusted assuming you're on a private net behind a firewall
sudo firewall-cmd --set-default-zone=trusted

