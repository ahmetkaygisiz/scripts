#!/bin/bash
_prompt=":|#|\\\$"

_HOST=$1
_USER=$2
_PASS=$3
_SCRIPT=$4

_nohupScript="bash $_SCRIPT > /dev/null 2>&1 &"

expect -c "
	spawn ssh $_USER@$_HOST $_nohupScript
        expect {
		"*asswor*" { 
			send $_PASS\r
			 exp_continue
			interact -o -nobuffer -re $_prompt return
		        send "exit"\r
		        interact
		        exit
		}
	}
"

