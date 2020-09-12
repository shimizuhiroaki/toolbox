#!/bin/bash
MYSQL_SLOW_LOG=/var/log/mysql/slow.log
DATE=`date +"%T"`
SCRIPT_DIR=$(cd $(dirname $0);pwd)
OUTPUT=$SCRIPT_DIR/data/db.txt

HOSTNAME=`hostname`

echo -e "[ DB LOG -- $DATE($HOSTNAME) ]\\n" >> $OUTPUT.$DATE

echo -e "[(1) Top 5 Query Time ]\\n" >> $OUTPUT.$DATE
/usr/bin/mysqldumpslow -s t $MYSQL_SLOW_LOG | head -n 15 >> $OUTPUT.$DATE

echo -e "[(2) TOP 5 Query AVG ]\\n" >> $OUTPUT.$DATE
/usr/bin/mysqldumpslow -s at $MYSQL_SLOW_LOG | head -n 15 >> $OUTPUT.$DATE
echo -e "\\n\\n" >> $OUTPUT.$DATE

echo -e "[(3) TOP 5 Query Count ]\\n" >> $OUTPUT.$DATE
/usr/bin/mysqldumpslow -s c $MYSQL_SLOW_LOG | head -n 15 >> $OUTPUT.$DATE
echo -e "\\n\\n" >> $OUTPUT.$DATE

cat $OUTPUT.$DATE > $OUTPUT
echo "" > $MYSQL_SLOW_LOG

exit 0
