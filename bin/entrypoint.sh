#!/bin/bash

[ ! -d /var/log/samba ] && mkdir -p /var/log/samba
LOGFILE="/var/log/samba/log.all"
if [ ! -f $LOGFILE ]; then
	touch $LOGFILE
	chmod 666 $LOGFILE
fi

exec tail -f $LOGFILE &
exec "$@"
