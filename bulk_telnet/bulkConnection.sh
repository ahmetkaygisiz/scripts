#!/bin/bash

function readFiles()
{ 	
	_fileName=$i
	
	echo "#### $_fileName ####" >> connected_$_hostName.txt
	echo "#### $_fileName ####" >> failed_$_hostName.txt

	while IFS= read -r line; do

		_host=$(echo $line | tr ':' ' ' | awk '{print $1}')
		_port=$(echo $line | tr ':' ' ' | awk '{print $2}')

		_str=`echo exit | timeout 2s telnet $_host $_port`
		
		if [[ $_str == *Connected* ]] ; then
			echo $line >> connected_$_hostName.txt
	        else
			echo $line >> failed_$_hostName.txt
   		fi	

	done < $_fileName

	echo " " >> connected_$_hostName.txt
	echo " " >> failed_$_hostName.txt	
}

_hostName=$(hostname)
_fileList=${*}
touch connected_$_hostName.txt failed_$_hostName.txt

for i in $_fileList
do
  readFiles $i
done