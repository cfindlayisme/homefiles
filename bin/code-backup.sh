#!/bin/bash
#
# Used to regularly backup code from ~/code to a folder called Code on Google Drive in a tar file
# Github stores this code obviously, but it's good to have backups and any secrets kept (ie, playbook var files)
# Assumes you have google-drive-ocamlfuse setup, and that ~/GoogleDrive exists
# Cron is your friend for it
#
# Author: Chuck Findlay <chuck@findlayis.me>
# License: LGPL v3.0
cd ~

if ! grep -qs $HOME'/GoogleDrive ' /proc/mounts; then
    google-drive-ocamlfuse ~/GoogleDrive
fi

if grep -qs $HOME'/GoogleDrive ' /proc/mounts; then
    name=$(date '+%Y-%m-%d %H:%M')

    tar -zcf "/tmp/$name.tar.gz" code
    mv "/tmp/$name.tar.gz" ~/GoogleDrive/Code
fi