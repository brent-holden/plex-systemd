#!/bin/bash

# Setup rclone
source ${BASH_SOURCE%/*}/setup_rclone.sh

# Prep system for install
source ${BASH_SOURCE%/*}/prep_install.sh

# Setup services
source ${BASH_SOURCE%/*}/setup_services.sh

# Setup backup cron job
source ${BASH_SOURCE%/*}/setup_cron.sh



