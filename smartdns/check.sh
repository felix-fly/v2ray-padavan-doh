#!/bin/sh

sleep 5

while true; do
    server=`ps | grep -e "smartdns[[:space:]]\|smartdns$" | grep -v grep`
    if [ ! "$server" ]; then
        /usr/bin/smartdns -c /etc/storage/smartdns/my.conf
    fi
    sleep 60
done
