#!/bin/sh

ipset -N gw iphash
iptables -t nat -A PREROUTING -p tcp -m set --match-set gw dst -j REDIRECT --to-port 12345
