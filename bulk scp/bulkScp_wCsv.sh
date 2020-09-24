#!/bin/bash
_hostFile=hosts.csv
_EXPECT=/data/installations/sourcesCmd/expect/expect5.45.4/expect
	while IFS=';' read _HOST _USER _PASS _FILE _DEST
	do		
		if [[ $_HOST == \#*  ]]
		then
			continue;
		else
		
			$_EXPECT -c "
      		        	set timeout 2
	                	log_file bulkScp_wCsv.log    
       			        spawn scp $_FILE $_USER@$_HOST:$_DEST
	                              	
                		expect {
		                        "*yes*" { send "yes"\r }
                		exit
                		}	
		                expect {
               		        "*pass*" {  send $_PASS\r; exp_continue} 
		                }
			"       
		fi 
       done < $_hostFile
	
