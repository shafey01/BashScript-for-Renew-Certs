#!/bin/bash

fullpath=/home/shafey/cert_checker
grep -Ev "^#|^$" $fullpath/domains.txt | while read  x; do

servername=stage_1

####################################
## Days Equation ##################

now=$( date +%s )

cert_date=$(sudo openssl x509 -enddate -noout -in /etc/letsencrypt/live/$x/cert.pem | cut -d '=' -f 2 )



expiry_for_cert=$( date -d "$cert_date" +%s )

days="$(( ($expiry_for_cert - $now) / (3600 * 24) ))"

############################################

if [[ $days -le 74 ]]
then

echo "$days for $x"

#curl -X POST -H 'Content-type: application/json' --data '{"blocks":[{"type":"header","text":{"type":"plain_text","text":"Renew '$domain'","emoji":true}},{"type":"section","fields":[{"type":"mrkdwn","text":"*Days:*\n'$days'"},{"type":"mrkdwn","text":"*Domain:*\n '$domain'"}]},{"type":"section","fields":[{"type":"mrkdwn","text":"*Server:*\n '$servername'"}]}]}' webhook_url

fi

done

