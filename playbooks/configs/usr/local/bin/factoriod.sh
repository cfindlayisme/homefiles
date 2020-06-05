#!/bin/bash
#
# Provides an easy way to inject stuff into factorio, or to attach to the screen
#
# Author: Chuck Findlay <chuck@findlayis.me>
# License: LGPL v3.0
send="`printf \"$*\r\"`"
attach='script /dev/null -qc "screen -r factorio"'
inject="screen -S factorio -X stuff $send"

if [ "$1" = "attach" ] ; then cmd="$attach" ; else cmd="$inject" ; fi

if [ "`stat -c '%u' /var/run/screen/S-factorio/`" = "$UID" ]
then
    $cmd
else
    su - factorio -c "$cmd"
fi