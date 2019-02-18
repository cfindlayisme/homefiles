#!/bin/bash
# Launches the Battle.net launcher with the proper wine cli switches
WINEDEBUG=-all vblank_mode=0 wine64 ~/.wine/drive_c/Program\ Files\ \(x86\)/Battle.net/Battle.net.exe
