#!/bin/bash
##
## Start up script for httpd on CentOS docker container
##

## Initialise any variables being called:
# Set the correct timezone
TZ=${TZ:-UTC}
CONF_DIR=${CONF_DIR:/config/confs/}
setup=/config/.setup

if [ ! -f "${setup}" ]; then
  rm -f /etc/localtime
  cp /usr/share/zoneinfo/$TZ /etc/localtime
  echo "IncludeOptional $CONF_DIR/*.conf" >> /etc/httpd/conf/httpd.conf
  touch $setup
fi

## Start up httpd daemon via supervisord
/usr/bin/supervisord -n -c /etc/supervisord.conf
