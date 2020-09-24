#!/bin/bash

lsof -P -i tcp | grep java | awk '{print $2,$4}' | sort -u >> tmpFile.txt

while IFS=' ' read _PID _FD
do
	 _FD=$(echo $_FD | tr -d  'u')

	 stat /proc/$_PID/fd/$_FD

done < tmpFile.txt
rm tmpFile.txt
