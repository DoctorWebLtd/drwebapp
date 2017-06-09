#!/bin/sh

# We use environment variables with highest priority
# by default we search for "drweb" hostname, which used in docker-compose

DRWEB_BY_HOSTNAME=`getent hosts drweb | cut -d " " -f 1`

if [ "${DRWEB_RSPAMD_IP}" ];then
  DRWEB_RSPAMD_IP=$DRWEB_RSPAMD_IP
elif [ "${DRWEB_BY_HOSTNAME}" ];then
  DRWEB_RSPAMD_IP=$DRWEB_BY_HOSTNAME
else
  DRWEB_RSPAMD_IP='127.0.0.1'
fi

DRWEB_RSPAMD_PORT="${DRWEB_RSPAMD_PORT:-11333}"

echo "INFO: DRWEB_RSPAMD_IP is: ${DRWEB_RSPAMD_IP}"
echo "INFO: DRWEB_RSPAMD_PORT is: ${DRWEB_RSPAMD_PORT}"
sed -i "s/DRWEB_RSPAMD_IP/$DRWEB_RSPAMD_IP/g" /etc/exim4/exim4.conf
sed -i "s/DRWEB_RSPAMD_PORT/$DRWEB_RSPAMD_PORT/g" /etc/exim4/exim4.conf

/usr/bin/supervisord -c /etc/supervisord.conf
