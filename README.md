# plex-scripts
This is a collection of scripts and systemd configurations I used to setup Plex and associated services which has been tested on CentOS 7/8

All scripts use 'sudo' and it's presumed you've cloned this repo into an account that has access to sudo, .

Clone this repository using:
```console
$ mkdir Code && cd "$_"
$ git clone https://github.com/brent-holden/plex-scripts.git
$ cd plex-scripts
```

Before running the next commands, you'll need to make sure you have a valid rclone configuration. You can find the instructions on how to do that on the [RClone Drive instructions](https://rclone.org/drive/). I've included an [example rclone configuration file](rclone/rclone.conf.example) for reference in this repository.

The setup.sh script assumes you're running with access to sudo. This script will prepare the system for installation of rclone, installing additional services and Plex. To complete the installation, you'll need three things:
* A working rclone configuration. Your rclone mount must have /Media and /Backups on it. This script will install but but won't configure it for you. You'll need to follow the guide above and provide the configuration file (rclone.conf) during the install.
* A Plex claim token. You can get this from plex.tv/claim once the script asks for it during installation


```console
$ ./setup_rclone.sh
```
My Google drive has two directories in /, Media and Backups. The rclone-media-drive mounts /Media, and rclone-backup-drive mounts /Backups

Here's what my /mnt directory looks like once setup_rclone.sh is run:
```console
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
        ├── Music
        └── TV
```
Assuming you have backups in the appropriate folders, the restore_services script will look for backup-$SERVICE-latest.tar.gz and untar it into the appropriate directory in /opt. If you don't have any backups, it will fail the tar stages but continue and setup all of the systemd service files for you. restore-services will also put your server in the default firewall zone of 'trusted' which means every port will be exposed. If that's undesirable for you, you'll have to work out the correct ports to add via firewalld.

```console
$ ./restore_services.sh

```

Here's what /opt looks like:
```console
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

Once you're done, nginx will be sitting on your host in a reverse proxy configuration. You can access your services via their port using http://${HOSTNAME}:${PORT}, or using http://${HOSTNAME}/${SERVICE}

As an example, to access Tautulli, you would use:  
http://your.hostname.here:8181  
or  
http://your.hostname.here/tautulli  

You'll have to log into each service and configure the reverse proxy base URL. I have included a [sample nginx configuration](nginx/default.example) in this repository. Good luck!


