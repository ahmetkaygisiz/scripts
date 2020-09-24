#!/bin/bash

#_URL=$1
#_CLASS=$2
#_IDENTIFIER=$3

VALUE=`curl -X GET "https://www.hepsiburada.com/hp-1kf75aa-omen-by-hp-600-12-000-dpi-oyuncu-mouse-p-HBV000008HST3" | grep "class=\"extra-discount-price\"" | cut -d'>' -f3 | cut -d ',' -f1`
echo "CALISIYO BURASI" >> /data/scripts/crontab_price/tmp.txt

notify-send "It works!"

if [ $VALUE -lt 200 ]
then
	notify-send "OLdu" "olamadi hala"
	eval "export $(egrep -z DBUS_SESSION_BUS_ADDRESS /proc/$(pgrep -u $LOGNAME xfce4-session)/environ)"; notify-send  "hello world" 
	echo "CALISIYO BURASI da" >> /data/scripts/crontab_price/tmp.txt
fi

echo "CIKTIM" >> /data/scripts/crontab_price/tmp.txt

eval "export $(egrep -z DBUS_SESSION_BUS_ADDRESS /proc/$(pgrep -u $LOGNAME gnome-session)/environ)";
# the actual notification
DISPLAY=:0 notify-send "Notify me!"