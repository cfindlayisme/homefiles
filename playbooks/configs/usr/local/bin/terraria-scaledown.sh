#!/bin/bash
# Monitors for a lack of incoming connections to terraria (ie, players) and counts up for each minute up to thirty minutes. Then shuts down
# Counts back down for each minute a user is connected until at zero minutes
#
# There are likely better ways to do this, but this is simple and shuts off the server for me if I forget to after a gaming session to save $,
# or if a buddy is playing for a bit after I logoff for the night
#
# If you're playing on a bare metal server or something that you're not paying per hour you don't really need this.
#
# Author: Chuck Findlay <chuck@findlayis.me>
# License: LGPL v3.0
count=0
while true
do

    users=$(netstat -tnpa | grep 'ESTABLISHED.*TerrariaServer' | wc -l)

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