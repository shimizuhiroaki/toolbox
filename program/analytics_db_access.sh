#!/bin/bash
MYSQL_SLOW_LOG=/var/log/mariadb/slow.log
DATE=`date +"%T"`
SCRIPT_DIR=$(cd $(dirname $0);pwd)
OUTPUT=$SCRIPT_DIR/data/db.txt


echo -e "[ DB LOG -- $DATE ]\\n" >> $OUTPUT.$DATE

echo -e "[ Query Time ]\\n" >> $OUTPUT.$DATE
/usr/bin/mysqldumpslow -s t $MYSQL_SLOW_LOG >> $OUTPUT.$DATE

echo -e "[ TOP Query Count ]\\n" >> $OUTPUT.$DATE
/usr/bin/mysqldumpslow -s c $MYSQL_SLOW_LOG | head -n 20 >> $OUTPUT.$DATE
echo -e "\\n\\n" >> $OUTPUT.$DATE

echo -e "[ TOP Query AVG ]\\n" >> $OUTPUT.$DATE
/usr/bin/mysqldumpslow -s at $MYSQL_SLOW_LOG | head -n 20 >> $OUTPUT.$DATE
echo -e "\\n\\n" >> $OUTPUT.$DATE

cat $OUTPUT.$DATE > $OUTPUT
echo "" > $MYSQL_SLOW_LOG

exit 0
