#!/bin/bash
#
# Runs a apt update and upgrade on all ansible hosts
#
# Author: Chuck Findlay <chuck@findlayis.me>
# License: LGPL v3.0
ansible all -m apt -a "upgrade=yes update_cache=yes cache_valid_time=86400" --become
