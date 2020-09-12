#!/bin/bash
ALP_LOG=/var/log/nginx/access.log.alp
DATE=`date +"%T"`
SCRIPT_DIR=$(cd $(dirname $0);pwd)
OUTPUT=$SCRIPT_DIR/data/web.txt
MARGE_URL="/api/chair/[0-9]+","/api/estate/[0-9]+","/api/chair/buy/[0-9]+","/api/estate/req_doc/[0-9]+","/api/recommended_estate/[0-9]+"

HOSTNAME=`hostname`

echo -e "[ WEB LOG -- $DATE($HOSTNAME) ]\\n" >> $OUTPUT.$DATE

echo -e "[ (1) TOP10 COUNT ]\\n" >> $OUTPUT.$DATE
cat $ALP_LOG | alp ltsv --sort=count --reverse -m $MARGE_URL | head -n 13 >> $OUTPUT.$DATE
echo -e "\\n\\n" >> $OUTPUT.$DATE

echo -e "[ (2) TOP10 SUM ]\\n" >> $OUTPUT.$DATE
cat $ALP_LOG | alp ltsv --sort=sum --reverse -m $MARGE_URL | head -n 13 >> $OUTPUT.$DATE
echo -e "\\n\\n" >> $OUTPUT.$DATE

echo -e "[ (3) TOP10 AVG ]\\n" >> $OUTPUT.$DATE
cat $ALP_LOG | alp ltsv --sort=avg --reverse -m $MARGE_URL | head -n 13 >> $OUTPUT.$DATE
echo -e "\\n\\n" >> $OUTPUT.$DATE

echo -e "[ (4) ALL LOGS ]\\n" >> $OUTPUT.$DATE
cat $ALP_LOG | alp ltsv --sort=count --reverse --query-string >> $OUTPUT.$DATE
echo -e "\\n\\n" >> $OUTPUT.$DATE

cat $OUTPUT.$DATE > $OUTPUT
echo "" > $ALP_LOG

exit 0
