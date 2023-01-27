#!/bin/bash
# Monitors for a lack of incoming connections to minecraft (ie, players) and counts up for each minute up to thirty minutes. Then shuts down
# Counts back down for each minute a user is connected until at zero minutes
#
# Author: Chuck Findlay <chuck@findlayis.me>
# License: LGPL v3.0

count=0
while true
do

    users=$(netstat -tnpa | grep 'ESTABLISHED.*java' | wc -l)

    # Count up for under threshold, and down for above
    if (( users == 0 ))
    then
        ((count+=1))
    elif ((count > 0))
    then
        ((count-=1))
    fi

    if ((count > 30))
    then
        sudo poweroff
    fi

    sleep 60

done