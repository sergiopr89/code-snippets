#!/bin/bash

if [[ $# -ge 2 ]]
then
	LOCKS_PATH="/tmp"
	LOCK_FILE=$LOCKS_PATH"/"`basename $1`".lock"
	TIMEOUT="60"

	shift

	flock -w $TIMEOUT -x $LOCK_FILE $@
	lock_status=$?

	if [[ $lock_status -eq 1 ]]
	then
	    echo 'Script already running, aborted.'
	    exit 1
	fi
else
	echo "Usage: $0 <lock_file_name> <execution1> [... <executionN>]"
fi
