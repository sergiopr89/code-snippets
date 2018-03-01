#!/bin/bash

# authors: Sergio Perez, Antonio Vega
# created_at: 20160627

if [ "$#" -lt 2 ] ; then
  echo "Usage: $0 LOCKFILE CMD [CMD PARAMETERS]" >&2
  exit 2
fi

LOCK_FILE=$1
shift

flock -n -x $LOCK_FILE $@
lock_status=$?

if [[ $lock_status -eq 1 ]]
then
    echo 'Script already running, aborted.'
    echo "CMD[$@]"
    echo "PID [`pidof $@`]"
    exit 1
fi
