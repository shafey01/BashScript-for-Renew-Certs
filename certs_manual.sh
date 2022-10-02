#!/bin/bash

fullpath=/home/shafey/cert

grep -Ev "^#|^$" $fullpath/domains.txt | while read  x; do

domain=`echo "$x" | cut -d ' ' -f 1`
domain_date=`echo "$x" | cut -d ' ' -f 2`
servername=stage_1

####################################
## Days Equation ##################

untile=`date -d $domain_date "+%s"`
now=`date "+%s"`
diff=$(($untile-$now))
days=$(($diff/(60*60*24)))


############################################

if [[ $days -le 6 ]]
then

curl -X POST -H 'Content-type: application/json' --data '{"blocks":[{"type":"header","text":{"type":"plain_text","text":"Renew '$domain'","emoji":true}},{"type":"section","fields":[{"type":"mrkdwn","text":"*Days:*\n'$days'"},{"type":"mrkdwn","text":"*Domain:*\n '$domain'"}]},{"type":"section","fields":[{"type":"mrkdwn","text":"*Server:*\n '$servername'"}]}]}' webhook_url

fi

done
