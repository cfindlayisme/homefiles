#!/bin/sh
# Runs a apt update and upgrade on all ansible hosts
ansible all -m apt -a "upgrade=yes update_cache=yes cache_valid_time=86400" --become
