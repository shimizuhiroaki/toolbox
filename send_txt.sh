HOST=isucon.akat.info
USER=
PASS=
SCRIPT_DIR=$(cd $(dirname $0);pwd)
TARGET_WEB_FILE=$SCRIPT_DIR/data/web.txt
TARGET_DB_FILE=$SCRIPT_DIR/data/db.txt
TARGET_PHP_FILE=/home/isucon/torb/webapp/php/php.txt
TARGET_DIR=/var/www/akat.info/data/

function delete_data() {
        rm ${TARGET_WEB_FILE}
        rm ${TARGET_DB_FILE}
        rm ${TARGET_PHP_FILE}
}

if [ "$1" = "del" ]; then
	delete_data
	exit 0
fi

./analytics_web_access.sh
./analytics_db_access.sh

expect -c "
spawn scp ${TARGET_WEB_FILE} ${TARGET_DB_FILE} ${TARGET_PHP_FILE} ${USER}@${HOST}:${TARGET_DIR}
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

delete_data

exit 0
