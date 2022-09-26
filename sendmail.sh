#!/bin/bash

arg=$1

days="${arg:0:1}"

domain="${arg:1}"

servername=stage-1



curl -X POST -H 'Content-type: application/json' --data '{"blocks":[{"type":"header","text":{"type":"plain_text","text":"Renew '$domain'","emoji":true}},{"type":"section","fields":[{"type":"mrkdwn","text":"*Days:*\n'$days'"},{"type":"mrkdwn","text":"*Domain:*\n '$domain'"}]},{"type":"section","fields":[{"type":"mrkdwn","text":"*Server:*\n '$servername'"}]}]}' webhook_url 





#curl -X POST -H 'Content-type: application/json' --data '{"text":"You have '$days' days for renew '$domain' Domain in server '$servername' !", "color":"#f44336"}' 
#echo "You have $days days for renew $domain Domain" | mail -s "Experimental No Action Needed, NOTICE: $days Days to renew" example@gmail.com
