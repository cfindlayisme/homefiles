#!/bin/bash
#
# Pipe config files into this to rip the comments out.
# Used to clean up config files after first setup
#
# Author: Chuck Findlay <chuck@findlayis.me>
# License: LGPL v3.0
egrep -v "^\s*(#|$)"