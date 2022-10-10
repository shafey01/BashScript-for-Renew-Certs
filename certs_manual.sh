#!/bin/bash


## Full path of your Directory that you put the script in it.
fullpath=/home/shafey/certbot-Bash

## The while loop to scan the Domains files line by line and 'grep' & Regex for ignore comments and blank lines.
grep -Ev "^#|^$" $fullpath/domains.txt | while read  domain; do


## Days Equation ##################

now=$( date +%s )

## Gathering the date from openssl command and convert in to seconds.
cert_date=$( echo | openssl s_client -connect "$domain":443 -servername "$domain" 2>/dev/null | openssl x509 -text | grep 'Not After' |awk '{print $4,$5,$7}' )

expiry_for_cert=$( date -d "$cert_date" +%s )

days="$(( ($expiry_for_cert - $now) / (3600 * 24) ))"

############################################

## If the days less than or equal 7 days send slack message by your webhook URL.
if [[ $days -le 7 ]]
then

## Send message to slack channel.
curl -X POST -H 'Content-type: application/json' --data '{"blocks":[{"type":"header","text":{"type":"plain_text","text":"Renew '$domain'","emoji":true}},{"type":"section","fields":[{"type":"mrkdwn","text":"*Days:*\n'$days'"},{"type":"mrkdwn","text":"*Domain:*\n '$domain'"}]}]}' webhook_url

fi

done
