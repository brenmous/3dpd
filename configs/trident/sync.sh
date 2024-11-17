#! /bin/bash

set -e

rsync -v -r --delete --exclude=*.log* --exclude=*.gcode --exclude=*.png --exclude=*.db pi@trident:/home/pi/printer_data .
