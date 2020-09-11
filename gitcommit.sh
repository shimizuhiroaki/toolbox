#!/bin/sh

if [ -z "$1" ];
then
	echo "Error, Input Comment!"
	exit 1
fi

COMMENT=$1

git add *
git commit -m "$COMMENT"
# git remote add origin https://github.com/shimizuhiroaki/toolbox.git
git push -u origin master

exit 0
