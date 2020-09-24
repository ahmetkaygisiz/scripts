#!/bin/bash

# Send Mail Function #

function sendMail {
        echo "Do you want to send email (Y/N) "

        while :
        do
                read input
                case $input in
                        Y | y)
                                echo  "Pls write an email address"
                                read mailAddress
                                sudo mail $mailAddress < $resultTxt -s "Search Results"

                                break
                                ;;
                        N | n)
                                cat $resultTxt
                                break
                                ;;

                        *)
                                echo "Pls Try Again"
                                ;;
                esac
        done
}

# End of Mail Func.#


# Search Function #

function search
{
        find /$path  -name "$pattern*" > $resultTxt
        grep -rn /$path -e "$pattern" --exclude=".*" >> $resultTxt
}

# End of Search Func.


#script starting point

pattern=$1
path=$2
resultTxt="result_$pattern.txt"

search
echo "Result txt $resultTxt "
sendMail
                  