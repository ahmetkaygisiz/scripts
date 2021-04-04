#!/bin/bash

xshell() {
	#Create SUBFOLDER : -p params for already exists folders
	mkdir -p sessions/$_APP
	
	#XShell fileName
	_XFILE=sessions/$_APP/$_HOSTNAME-$_IP.xsh
	
	#Copy
	cp xshell_template.txt $_XFILE
	
	#Override
	sed -i "s/Host=/Host=$_IP/;s/UserName=/UserName=$_USERNAME/;s/Description=/Description=$_APP/" $_XFILE
}

securecrt() {

	#Create SUBFOLDER : -p params for already exists folders
	mkdir -p sessions/$_APP
	
	#XShell fileName
	_XFILE=sessions/$_APP/$_HOSTNAME-$_IP.ini

	#Copy
	cp secure_template.ini $_XFILE
	
	#Override 
	sed -i 's/S:"Hostname"=/S:"Hostname"='$_IP'/' $_XFILE
}

mobaterm() {
        _MOBA_CRD="My_CRD"
        _XFILE="can_be_dynamic_but_not_on_my_roof.mxtsessions"

        cp moba_template.mxtsessions $_XFILE
        _counter=1

        while IFS=';' read _HOSTNAME _IP _APP
        do
		if [ ! -z $_APP ];then
			printf "[Bookmarks_$_counter]\nSubRep="$_APP"\nImgNum=10\n" >> $_XFILE
 			_counter=$(( $_counter + 1 ))
             	fi

                echo "$_HOSTNAME ($_USERNAME)=#109#0%$_HOSTNAME%22%[:$_MOBA_CRD]%%-1%-1%%%%%0%0%0%%%-1%0%0%0%%1080%%0%0%1#MobaFont%10%0%0%-1%15%236,236,236%30,30,30%180,180,192%0%-1%0%%xterm%-1%-1%_Std_Colors_0_%80%24%0%1%-1%<none>%%0%0%-1#0# #-1" >> $_XFILE
        done < $_hostFile
}

##########
## MAIN ## 
##########

_hostFile=$1

# ugly mugly. it works! :')
mkdir sessions

while true; do

	printf  "Make your choice\n\t1)Xshell\n\t2)SecureCRT\n\t3)MobaXTerm\n0)Exit\n\n" 
    read -p "Choice : " ch
    
    case $ch in
        1 | 2) 
		func=xshell
	
		if [ $ch -eq 2 ];then
			func=securecrt
		fi

		while IFS=";" read _HOSTNAME _IP _APP _USERNAME
		do
		     $func $_HOSTNAME $_IP $_APP $_USERNAME		     
		done < $_hostFile
	
		# housekeeping
		tar -cvf sessions.zip sessions
		rm -rf sessions

		break;;

	3 )
		read -p "Username : " _USERNAME

		# call the bad boy (Moba Free Edi. permits only 14 sessions to save) 
	       	mobaterm $_hostFile $_USERNAME

		break;;
	0 ) 
		exit;;
        * )
	       	echo "Do you believe in dejavu?";;
    esac
done
