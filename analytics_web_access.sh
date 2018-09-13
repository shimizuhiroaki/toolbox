#!/bin/bash
ALP_LOG=/var/log/nginx/access.log.alp
DATE=`date +"%T"`
OUTPUT=/var/log/web.txt


echo -e "[ WEB LOG -- $DATE ]\\n" >> $OUTPUT.$DATE

echo -e "[ TOP10 SUM ]\\n" >> $OUTPUT.$DATE
alp -f $ALP_LOG --sum -r | head -n 13 >> $OUTPUT.$DATE
echo -e "\\n\\n" >> $OUTPUT.$DATE

echo -e "[ TOP10 AVG ]\\n" >> $OUTPUT.$DATE
alp -f $ALP_LOG --avg -r | head -n 13 >> $OUTPUT.$DATE
echo -e "\\n\\n" >> $OUTPUT.$DATE

echo -e "[ ALL LOG ]\\n" >> $OUTPUT.$DATE
alp -f $ALP_LOG --cnt -r  >> $OUTPUT.$DATE
echo -e "\\n\\n" >> $OUTPUT.$DATE

cat $OUTPUT.$DATE > $OUTPUT
echo "" > $ALP_LOG
