#!/bin/sh

_csvFile=/data/scripts/opc/hostPass.csv
_restartScript=/data/scripts/opc/restartServer.py
_wlstPath=/data/Oracle/Middleware/fmw12212/oracle_common/common/bin/wlst.sh

_protocol=t3

_tmpJson=$(cat $(echo $1 | sed 's/\"//g'))
_domainAddress=$(echo "$_tmpJson" | jq ".FULL_DOMAIN_NAME" | cut -d@ -f2 | tr -d '"')

_host=$(echo $_domainAddress | cut -d: -f1)
_port=$(echo $_domainAddress | cut -d: -f2)

_wlUrl=$_protocol'://'$_host:$_port

_username=$(cat $_csvFile | grep $_host | cut -d, -f2)
_pass=$(cat $_csvFile | grep $_host | cut -d, -f3)

_serverBodies=$(echo "$_tmpJson" | jq -c '.BODY_ROW[] | select(.HEALTH_NAME=="SHUTDOWN")')

for _server in $_serverBodies
do	
	_serverName=$(echo "$_server"| jq '.SERVER_NAME' | tr -d '"')
        _host=$(echo $_domainAddress | cut -d: -f1)
        _port=$(echo $_domainAddress | cut -d: -f2)
		
        $_wlstPath $_restartScript $_username $_pass $_wlUrl $_serverName &
	wait &!
done


