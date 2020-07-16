#!/bin/sh

sleep 5

while true; do
    server=`ps | grep -e "v2ray[[:space:]]\|v2ray$" | grep -v grep`
    if [ ! "$server" ]; then
        ulimit -v 65536
        /usr/bin/v2ray -config=/etc/storage/v2ray/config.json &
    fi
    sleep 60
done
