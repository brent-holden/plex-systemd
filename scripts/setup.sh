#!/bin/bash

# Prep system for install
source ${BASH_SOURCE%/*}/prep_install.sh

# Setup rclone
source ${BASH_SOURCE%/*}/setup_rclone.sh

# Setup services
source ${BASH_SOURCE%/*}/setup_services.sh

# Setup backups
source ${BASH_SOURCE%/*}/setup_backup.sh


