#!/bin/bash

#echo "Done $1 , $2"

days=`echo "$1" | cut -d '*' -f 1`
domain=`echo "$1" | cut -d '*' -f 2`


echo "You have $days days for renew $domain Domain" | mail -s "Experimental No Action Needed, NOTICE: $days Days to renew" example@gmail.com
