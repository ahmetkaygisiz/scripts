#!/bin/bash

_mainProcess=3241

echo "" > result.txt 

ps -e -T | grep $_mainProcess | awk '{print $4,$2}' | sort -nr > tmpFile.txt 
jstack -l $_mainProcess > tmpThreadDump.txt

while IFS=' ' read _TIME _PID;
do
	_SEC=$(echo $_TIME | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
	
	if [[ $_SEC -gt 5 ]]
	then
		#echo $_PID $_SEC
		_searchStr=$(printf '%x\n' $_PID)
		_searchStr="nid=0x$_searchStr"

		cat tmpThreadDump.txt | awk "/$_searchStr/,/^$/"
	fi

done < tmpFile.txt
 
#rm tmpFile.txt

