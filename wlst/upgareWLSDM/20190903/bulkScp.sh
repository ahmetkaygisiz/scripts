#!/bin/bash
_hostFile=$1

function extract_hosts() {
    cat $_hostFile | awk -F ',' '(NF && !/^($|#)/) {print $1, $6, $7, $8, $9}'
}

	while IFS=' ' read _HOST _USER _PASS _FILE _DEST
	do		
		expect -c "
			set timeout 2
			log_file bulkScp.log    
       		        spawn scp $_FILE $_USER@$_HOST:$_DEST
	                              	
               		expect {
				"*yes*" { send "yes"\r }
              			exit
               		}	
	                expect {
				"*pass*" {  send $_PASS\r; exp_continue} 
	                }
		"
	done < <(extract_hosts)
	
