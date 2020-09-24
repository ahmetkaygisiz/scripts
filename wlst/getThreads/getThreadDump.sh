#!/bin/bash

_arr=$(echo $* | tr -d "[]")
_tmpArr=$(echo $_arr | tr "," "\n")

jstack -l 2969 > threadDumpTmp.txt

while IFS=' ' read line
do
	_searchStr=$(echo $line | awk  '{print $2 " " $3}')
	
	cat threadDumpTmp.txt | tr -d "'" | awk "/\<$_searchStr\>/,/^$/" >> result.txt

done <<< "$_tmpArr"

#rm threadDumpTmp.txt

