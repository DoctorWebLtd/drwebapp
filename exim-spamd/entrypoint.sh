#!/bin/sh

# We use environment variables with highest priority
# by default we search for "drweb" hostname, which used in docker-compose

DRWEB_BY_HOSTNAME=`getent hosts drweb | cut -d " " -f 1`

if [ "${DRWEB_SPAMD_IP}" ];then
  DRWEB_SPAMD_IP=$DRWEB_SPAMD_IP
elif [ "${DRWEB_BY_HOSTNAME}" ];then
  DRWEB_SPAMD_IP=$DRWEB_BY_HOSTNAME
else
  DRWEB_SPAMD_IP='127.0.0.1'
fi

DRWEB_SPAMD_PORT="${DRWEB_SPAMD_PORT:-783}"

echo "INFO: DRWEB_SPAMD_IP is: ${DRWEB_SPAMD_IP}"
echo "INFO: DRWEB_SPAMD_PORT is: ${DRWEB_SPAMD_PORT}"
sed -i "s/DRWEB_SPAMD_IP/$DRWEB_SPAMD_IP/g" /etc/exim4/exim4.conf
sed -i "s/DRWEB_SPAMD_PORT/$DRWEB_SPAMD_PORT/g" /etc/exim4/exim4.conf

/usr/bin/supervisord -c /etc/supervisord.conf
