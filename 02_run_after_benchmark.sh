#!/bin/bash
SCRIPT_TMP_DIR=$(cd $(dirname $0);pwd)/tmp
TARGET_WEB_FILE=$SCRIPT_TMP_DIR/web.txt
TARGET_DB_FILE=$SCRIPT_TMP_DIR/db.txt
TARGET_DIR=/var/www/akat.info/isucon/htdocs/
DATE=`date +"%T"`
HOSTNAME=`hostname`

### Change according to your Environment ###
HOST=isucon.akat.info
USER=isucon
PASS=kiw0a-sal!lsq-QIKS!
WEB_ALP_LOG=/var/log/nginx/access.log.alp
DB_SLOW_LOG=/var/log/mysql/slow.log
# Isucon 10
MARGE_URL="-m /api/chair/[0-9]+","/api/estate/[0-9]+","/api/chair/buy/[0-9]+","/api/estate/req_doc/[0-9]+","/api/recommended_estate/[0-9]+"
############################################

function delete_data() {
        rm ${TARGET_WEB_FILE} \ echo "" > $WEB_ALP_LOG
        rm ${TARGET_DB_FILE}  \ echo "" > $DB_SLOW_LOG
}

function analytics_web_access() {
	echo -e "[ WEB LOG -- $DATE($HOSTNAME) ]\\n" >> $TARGET_WEB_FILE.$DATE

	echo -e "[ (1) TOP10 COUNT ]\\n" >> $TARGET_WEB_FILE.$DATE
	cat $WEB_ALB_LOG | alp ltsv --sort=count --reverse $MARGE_URL | head -n 13 >> $TARGET_WEB_FILE.$DATE
	echo -e "\\n\\n" >> $TARGET_WEB_FILE.$DATE

	echo -e "[ (2) TOP10 SUM ]\\n" >> $TARGET_WEB_FILE.$DATE
	cat $WEB_ALB_LOG | alp ltsv --sort=sum --reverse $MARGE_URL | head -n 13 >> $TARGET_WEB_FILE.$DATE
	echo -e "\\n\\n" >> $TARGET_WEB_FILE.$DATE

	echo -e "[ (3) TOP10 AVG ]\\n" >> $TARGET_WEB_FILE.$DATE
	cat $WEB_ALB_LOG | alp ltsv --sort=avg --reverse $MARGE_URL | head -n 13 >> $TARGET_WEB_FILE.$DATE
	echo -e "\\n\\n" >> $TARGET_WEB_FILE.$DATE

	echo -e "[ (4) ALL LOGS ]\\n" >> $TARGET_WEB_FILE.$DATE
	cat $WEB_ALB_LOG | alp ltsv --sort=count --reverse --query-string >> $TARGET_WEB_FILE.$DATE
	echo -e "\\n\\n" >> $TARGET_WEB_FILE.$DATE

	cat $TARGET_WEB_FILE.$DATE > $TARGET_WEB_FILE
}

function analytics_db_access() {
	echo -e "[ DB LOG -- $DATE($HOSTNAME) ]\\n" >> $TARGET_DB_FILE.$DATE

	echo -e "[(1) Top 5 Query Time ]\\n" >> $TARGET_DB_FILE.$DATE
	/usr/bin/mysqldumpslow -s t $DB_SLOW_LOG | head -n 15 >> $TARGET_DB_FILE.$DATE

	echo -e "[(2) TOP 5 Query AVG ]\\n" >> $TARGET_DB_FILE.$DATE
	/usr/bin/mysqldumpslow -s at $DB_SLOW_LOG | head -n 15 >> $TARGET_DB_FILE.$DATE
	echo -e "\\n\\n" >> $TARGET_DB_FILE.$DATE

	echo -e "[(3) TOP 5 Query Count ]\\n" >> $TARGET_DB_FILE.$DATE
	/usr/bin/mysqldumpslow -s c $DB_SLOW_LOG | head -n 15 >> $TARGET_DB_FILE.$DATE
	echo -e "\\n\\n" >> $TARGET_DB_FILE.$DATE

	cat $TARGET_DB_FILE.$DATE > $TARGET_DB_FILE
}

function send_data(){
expect -c "
#spawn scp ${TARGET_WEB_FILE} ${TARGET_DB_FILE} ${USER}@${HOST}:${TARGET_DIR}
spawn scp ${TARGET_WEB_FILE} ${USER}@${HOST}:${TARGET_DIR}
expect {
\"Are you sure you want to continue connecting (yes/no)? \" {
send \"yes\r\"
expect \"password:\"
send \"${PASS}\r\"
} \"password:\" {
send \"${PASS}\r\"
}
}
interact
"
}

############################################

if [ "$1" = "del" ]; then
	delete_data
	exit 0
fi

if [ ! -e $SCRIPT_TMP_DIR ]; then
        mkdir $SCRIPT_TMP_DIR
fi

analytics_web_access
analytics_db_access 
send_data

delete_data

exit 0
