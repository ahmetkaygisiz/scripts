#!/bin/bash

# For notification problem in crontab 
# https://askubuntu.com/questions/298608/notify-send-doesnt-work-from-crontab
eval "export $(egrep -z DBUS_SESSION_BUS_ADDRESS /proc/$(pgrep -u $LOGNAME plasma)/environ)";

# Parse URL
_URL="https://www.hepsiburada.com/hp-1kf75aa-omen-by-hp-600-12-000-dpi-oyuncu-mouse-p-HBV000008HST3"

# For 
VALUE=`curl -X GET $_URL | grep "class=\"extra-discount-price\"" | cut -d'>' -f3 | cut -d ',' -f1`

if [ $VALUE -lt 300 ]
then
	/usr/bin/notify-send  "Product discount" 
fi

# the actual notification
#export DISPLAY=:0 notify-send "Notify me!"
