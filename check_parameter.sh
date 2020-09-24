#!/bin/bash

function check_parameter() {
  var=$1

  if [ -z ${var} ]; then
    return 1
  else
    return 0
  fi
}

function scriptStatus(){
 
	if [ $? == 0 ]; then
	    echo "Script OK. "
	else
	    echo "Script failed. "
        fi	
}

check_parameter $1
scriptStatus


