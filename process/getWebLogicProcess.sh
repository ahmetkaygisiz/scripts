#!/bin/bash

function getChildProcessList(pid) {
	cpList=pstree -p $pid | grep "\n" " " | sed "s/[^0-9]/ /g" | sed "s/\s\s*/ /g"

	return $cpList
}

####
##	==> Main
####




