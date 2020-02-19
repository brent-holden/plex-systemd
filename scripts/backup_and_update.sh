#!/usr/bin/env bash

#source ${BASH_SOURCE%/*}/update_container_images.sh
source ${BASH_SOURCE%/*}/backup_services.sh
source ${BASH_SOURCE%/*}/prune_backups.sh
source ${BASH_SOURCE%/*}/prune_container_images.sh
source ${BASH_SOURCE%/*}/prune_downloads.sh
