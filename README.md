# plex-scripts
This is a collection of scripts and systemd configurations I used to setup Plex and associated services using podman on CentOS 8


Clone this repository using:
```
git clone https://github.com/brent-holden/plex-scripts.git
```

The setup_rclone.sh script assumes you're running with access to sudo. This script will create a user 'plex' for you with uid/gid 1100. RClone will have permissions set to allow this user for our rclone drive(s), and on the directories we create in /opt and /mnt
```
cd plex-scripts/scripts
./setup_rclone.sh
```
My Google drive has two directories in /, Media and Backups. The rclone-media-drive mounts /Media, and rclone-backup-drive mounts /Backups

Here's what my /mnt directory looks like once setup_rclone.sh is run:
```
mnt/
├── downloads
└── rclone
    ├── backup
    │   ├── hydra2
    │   ├── letsencrypt
    │   ├── lidarr
    │   ├── nginx
    │   ├── plex
    │   ├── radarr
    │   ├── sabnzbd
    │   ├── sonarr
    │   └── tautulli
    ├── cache-db
    │   ├── backup-cache
    │   └── media-cache
    └── media
        ├── Movies
        ├── Movies-3d
        ├── Movies-Kids
        ├── Music
        └── TV
```


Assuming you have backups in the appropriate folders, the restore_services script will look for backup-$SERVICE-latest.tar.gz and untar it into the appropriate directory in /opt. If you don't have any backups, it will fail the tar stages but continue and setup all of the systemd service files for you. restore-services will also put your server in the default firewall zone of 'trusted' which means every port will be exposed. If that's undesirable for you, you'll have to work out the correct ports to add via firewalld.

```
./restore_services.sh

```

Here's what /opt looks like:
```
opt/
├── hydra2
├── letsencrypt
├── lidarr
├── nginx
├── plex
├── radarr
├── rclone
├── sabnzbd
├── sonarr
└── tautulli
```

Once you're done, nginx will be sitting on a reverse proxy on your host. You can access your services via their port, or ${HOSTNAME}/service, like ${HOSTNAME}/tautulli


