#!/bin/bash
# Run as root to attach to console for minecraft
#
# Author: Chuck Findlay <chuck@findlayis.me>
# License: LGPL v3.0
sudo -u minecraft script /dev/null -qc "screen -r minecraft"