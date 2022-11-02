#!/bin/bash

set -e

apt-get install -y mpv cage udisks2 git python3-click python3-dbus python3-gi xwayland
useradd -m kalkspace-player -G video,audio,plugdev -s /bin/bash

# default armbian "choose a password" workflow
rm -f /etc/systemd/system/getty@.service.d/override.conf
# instead remove root password. so maintenance is possible if you have physical access. you still won't be able to log in via network because of ssh settings however (which is intended)
passwd -d root

# kalkspace player stuff
mkdir -p /etc/systemd/system/getty@tty1.service.d/
cp /tmp/overlay/autologin.conf /etc/systemd/system/getty@tty1.service.d/
cp /tmp/overlay/usb-script-executor.service /etc/systemd/user

git clone https://github.com/kalkspace/usb-script-executor /tmp/usb-script-executor
mkdir -p /opt/kalkspace-player/{bin,share}
cp /tmp/usb-script-executor/usb_script_executor.py /opt/kalkspace-player/bin
cp /tmp/overlay/usb-update.sh /opt/kalkspace-player/share/usb-update.sh
chmod +x /opt/kalkspace-player/bin/*
chmod +x /opt/kalkspace-player/share/*

# local user stuff
cp /tmp/overlay/.bash_profile /home/kalkspace-player/
chown kalkspace-player:kalkspace-player /home/kalkspace-player/.bash_profile
mkdir /home/kalkspace-player/kalkspace-player
cp /tmp/overlay/{kalkspace.mp4,cage-options,mpv-options} /home/kalkspace-player/kalkspace-player
ln -s kalkspace.mp4 /home/kalkspace-player/kalkspace-player/video
chown -R kalkspace-player:kalkspace-player /home/kalkspace-player/kalkspace-player
mkdir -p /home/kalkspace-player/.config/systemd/user/default.target.wants/
chown -R kalkspace-player:kalkspace-player /home/kalkspace-player/.config
ln -s  /etc/systemd/user/usb-script-executor.service /home/kalkspace-player/.config/systemd/user/default.target.wants/usb-script-executor.service
