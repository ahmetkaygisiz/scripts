#!/bin/bash

_hostFile=$1

while IFS=';' read _HOSTNAME _IP _APP _USERNAME
do	
	#Test
	#echo $_HOSTNAME $_IP $_APP $_USERNAME

	#Create SUBFOLDER
	mkdir $_APP
	
	#XShell fileName
	_XFILE=$_APP/$_HOSTNAME-$_IP.xsh
	#echo $_XFILE

	#Copy
	cp template.txt $_XFILE
	
	#Override
	sed -i "s/Host=/Host=$_IP/" $_XFILE
	sed -i "s/UserName=/UserName=$_USERNAME/" $_XFILE
	sed -i "s/Description=/Description=$_APP/" $_XFILE
done < $_hostFile
