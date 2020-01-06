#!/usr/bin/env bash

source ${BASH_SOURCE%/*}/variables.sh

# Add the plex user and group with specified UID before doing anything
echo "Adding $PLEXUSER with UID:$PLEXUID"
sudo adduser $PLEXUSER --uid=$PLEXUID -U

# Install packages needed
echo "Installing packages: $PACKAGES"
sudo yum -y install $PACKAGES

# Set default zone to trusted assuming you're on a private net behind a firewall
echo "Setting FirewallD to live in a trusted zone. Comment this out if you're in a DMZ"
sudo firewall-cmd --set-default-zone=trusted

# Disable SELinux because reasons
echo "Disabling SELinux. This will require a reboot to take effect"
sudo sed -i 's/^SELINUX=.*/SELINUX=disabled/' /etc/sysconfig/selinux

# Create download directories
