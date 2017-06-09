#!/bin/sh

# We use environment variables with highest priority
# by default we search for "drweb" hostname, which used in docker-compose

DRWEB_BY_HOSTNAME=`getent hosts drweb | cut -d " " -f 1`

if [ "${DRWEB_MILTER_IP}" ];then
  DRWEB_MILTER_IP=$DRWEB_MILTER_IP
elif [ "${DRWEB_BY_HOSTNAME}" ];then
  DRWEB_MILTER_IP=$DRWEB_BY_HOSTNAME
else
  DRWEB_MILTER_IP='127.0.0.1'
fi

DRWEB_MILTER_PORT="${DRWEB_MILTER_PORT:-2259}"

echo "INFO: DRWEB_MILTER_IP is: ${DRWEB_MILTER_IP}"
echo "INFO: DRWEB_MILTER_PORT is: ${DRWEB_MILTER_PORT}"
sed -i "s/DRWEB_MILTER_IP/$DRWEB_MILTER_IP/g" /etc/postfix/main.cf
sed -i "s/DRWEB_MILTER_PORT/$DRWEB_MILTER_PORT/g" /etc/postfix/main.cf

/usr/bin/supervisord -c /etc/supervisord.conf
