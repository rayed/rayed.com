#!/bin/sh


git diff-index --quiet HEAD --

if [ "$?" -eq "0" ]
then
		ssh rayed.com ./bin/rayed_com_deploy.sh
else
		echo "Couldn't deploy; some changes not commited"
fi
