#!/bin/bash
#
# Used to regularly backup code from ~/code to a folder called Code on Google Drive in a tar file
# Backed up seperately from other system backups done
# Assumes you have google-drive-ocamlfuse setup, and that /mnt/GoogleDrive exists
# Cron is your friend for it
#
# Author: Chuck Findlay <chuck@findlayis.me>
# License: LGPL v3.0
cd ~

if ! grep -qs '/mnt/GoogleDrive ' /proc/mounts; then
    google-drive-ocamlfuse ~/GoogleDrive
fi

if grep -qs '/mnt/GoogleDrive ' /proc/mounts; then
    hostname=$(hostname)
    name=$(date '+%Y-%m-%d %H:%M')

    tar -zcf "/tmp/$hostname $name.tar.gz" code
    mv "/tmp/$hostname $name.tar.gz" /mnt/GoogleDrive/Code
fi