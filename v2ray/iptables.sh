#!/bin/sh

ipset -R < /etc/storage/v2ray/ad.ips
ipset -R < /etc/storage/v2ray/gw.ips
iptables -t filter -A INPUT -m set --match-set ad dst -j REJECT
iptables -t nat -A PREROUTING -p tcp -m set --match-set gw dst -j REDIRECT --to-port 12345
