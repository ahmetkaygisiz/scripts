#!/bin/bash

_serverlist_file=$1
_wlstPath=/data/Oracle/Middleware/fmw12212/oracle_common/common/bin/wlst.sh

function restartServer() {
    local adminServer=$1
    local server=$2
    $_wlstPath manageServers.py "weblogic" "welcome1" $adminServer $server "restart"
}

function extract_servers() {
    cat $_serverlist_file | awk '!/#/'
}

while IFS=',' read line 
do
		declare -a mServers=(`echo $(echo $line | tr ',' ' ')`)		
		{
			for(( i=1 ; i < ${#mServers[@]} ; i++))
			do
				while [[  $(free | sed -n '2p' | awk '{print $2/$3}') < 1.9 ]]; do
					sleep 10
				done
				
				restartServer ${mServers[0]} ${mServers[$i]} 
			done
		}&

done < <(extract_servers)





