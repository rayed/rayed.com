#!/bin/sh


# Check for uncommited changes
git diff-index --quiet HEAD --
if [ "$?" -ne "0" ]
then
		echo "Couldn't deploy; some changes not commited"
        exit 1
fi

# Check if changes pushed
git status | grep "Your branch is ahead" > /dev/null
if [ "$?" -eq "0" ]
then
		echo "Couldn't deploy; commits not pushed to server"
        exit 1
fi

ssh rayed.com ./bin/rayed_com_deploy.sh
