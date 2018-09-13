HOST=isucon.akat.info
USER=user
PASS=pass
SCRIPT_DIR=$(cd $(dirname $0);pwd)
TARGET_WEB_FILE=$SCRIPT_DIR/data/web.txt
TARGET_DB_FILE=$SCRIPT_DIR/data/db.txt
TARGET_DIR=/var/www/akat.info/data/

expect -c "
spawn scp ${TARGET_WEB_FILE} ${TARGET_DB_FILE} ${USER}@${HOST}:${TARGET_DIR}
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
