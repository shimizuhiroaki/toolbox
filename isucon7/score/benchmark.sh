#!/bin/bash

FILENAME=`date '+%Y-%m-%d-%H%M%S'`.json
OUTPUT_FILENAME=/home/isucon/score/result/${FILENAME}

/home/isucon/isubata/bench/bin/bench -data=/home/isucon/isubata/bench/data -remotes=localhost,133.130.112.102 -output=${OUTPUT_FILENAME}

SCORE=`cat ${OUTPUT_FILENAME} | jq . | grep "score"`

echo -e "\e[31m $SCORE \e[m"

exit 0
