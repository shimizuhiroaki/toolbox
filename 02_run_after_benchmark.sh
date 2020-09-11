HOST=isucon.akat.info
USER=isucon
PASS=
SCRIPT_DIR=$(cd $(dirname $0);pwd)
TARGET_WEB_FILE=$SCRIPT_DIR/program/data/web.txt
TARGET_DB_FILE=$SCRIPT_DIR/program/data/db.txt
TARGET_DIR=/var/www/akat.info/isucon/

function delete_data() {
        rm ${TARGET_WEB_FILE}
        rm ${TARGET_DB_FILE}
}

if [ "$1" = "del" ]; then
	delete_data
	exit 0
fi

./program/analytics_web_access.sh
./program/analytics_db_access.sh

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
