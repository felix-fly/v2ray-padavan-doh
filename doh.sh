#!/bin/sh

cd /etc/storage/v2ray

sleep 5

./https_dns_proxy -p 1053 -d -r "https://1.1.1.1/dns-query?" &

