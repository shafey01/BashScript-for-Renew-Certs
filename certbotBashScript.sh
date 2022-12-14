#!/bin/bash


fullPath=/home/shafey/certbot-Bash


sudo certbot certificates | grep 'Certificate Name\|Expiry' > $fullPath/certValid.txt


cat $fullPath/certValid.txt | grep "Certificate Name" | cut -d ':' -f 2 | cut -d ' ' -f 2 > $fullPath/certDomains.txt

cat $fullPath/certValid.txt | grep Expiry | cut -d ':' -f 6 | cut -d ' ' -f 2 > $fullPath/certExpiry.txt

paste $fullPath/certDomains.txt $fullPath/certExpiry.txt | awk '{print $1, $2}' > $fullPath/certFinal.txt \
&& sed -i 's/EXPIRED)/EXPIRED/g' $fullPath/certFinal.txt


awk '{
if ($2 <=5)
system("/home/shafey/certbot-Bash/sendmail.sh "$2$1)
else
print "Done"
}' < $fullPath/certFinal.txt


