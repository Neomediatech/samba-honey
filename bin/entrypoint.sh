#!/bin/bash

[ ! -d /var/log/samba ] && mkdir -p /var/log/samba
LOGFILE="/var/log/samba/log.all"
if [ ! -f $LOGFILE ]; then
	touch $LOGFILE
	chmod 666 $LOGFILE
fi

mkdir -p /shares/marketing /shares/admin

exec tail -f $LOGFILE &
exec "$@"
