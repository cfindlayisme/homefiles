#!/bin/bash
# Monitors the load on the server and if very low for awhile assumes no one is playing, so shuts down 
# Based off of http://rohitrawat.com/automatically-shutting-down-google-cloud-platform-instance/
#
# Should apply to other cloud services like AWS, providing VM is sized properly
# Assuming n1-standard GCS instance:
# - Average one player: 0.33 active idle (ie, sitting in a lowly populated area, no redtone)
# - Average no players: 0.01
#
# Gives a 30 minute buffer to login and do stuff
#
# Author: Chuck Findlay <chuck@findlayis.me>
# License: LGPL v3.0
threshold=0.2

count=0
while true
do

    load=$(uptime | sed -e 's/.*load average: //g' | awk '{ print $3 }')
    res=$(echo $load'<'$threshold | bc -l)

    # Count up for under threshold, and down for above
    if (( $res ))
    then
        ((count+=1))
    else
        ((count-=1))
    fi

    if ((count == 15))
    then
        # Fifteen minute warning. Enough time to abort it with activity
        sudo -u minecraft script /dev/null -qc "/usr/bin/screen -p 0 -S minecraft -X eval 'stuff \"say Server appears idle! It will shut down in fifteen minutes if it stays this way.\"\\015'"
    fi

    if ((count > 30))
    then
        # Quick warning to connected clients
        sudo -u minecraft script /dev/null -qc "/usr/bin/screen -p 0 -S minecraft -X eval 'stuff \"say Server has appeared idle for the past thirty minutes, shutdown now scheduled for five minutes from this message. Data will be saved.\"\\015'"
        sleep 300
        sudo poweroff
    fi

    sleep 60

done