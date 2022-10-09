#!/bin/bash

fullpath=/home/shafey/certbot-Bash

grep -Ev "^#|^$" $fullpath/domains.txt | while read  domain; do


####################################
## Days Equation ##################

now=$( date +%s )

cert_date=$( echo | openssl s_client -connect "$domain":443 -servername "$domain" 2>/dev/null | openssl x509 -text | grep 'Not After' |awk '{print $4,$5,$7}' )

expiry_for_cert=$( date -d "$cert_date" +%s )

days="$(( ($expiry_for_cert - $now) / (3600 * 24) ))"


############################################

if [[ $days -le 7 ]]
then

#echo "$days for $x"

curl -X POST -H 'Content-type: application/json' --data '{"blocks":[{"type":"header","text":{"type":"plain_text","text":"Renew '$domain'","emoji":true}},{"type":"section","fields":[{"type":"mrkdwn","text":"*Days:*\n'$days'"},{"type":"mrkdwn","text":"*Domain:*\n '$domain'"}]}]}' webhook_url

fi

done
