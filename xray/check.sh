#!/bin/sh

APP=/usr/bin/xray
CONF=/etc/storage/xray/config.json

NUM=`ps | grep -w $APP | grep -v grep | wc -l`
if [ "$NUM" -lt "1" ];then
  export SSL_CERT_FILE=/usr/lib/cacert.pem
  $APP -config=$CONF &
elif [ "$NUM" -gt "1" ];then
  pgrep -f $APP | xargs kill -9
  sleep 1s
  export SSL_CERT_FILE=/usr/lib/cacert.pem
  $APP -config=$CONF &
fi

exit 0
