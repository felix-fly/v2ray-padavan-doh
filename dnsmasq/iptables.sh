#!/bin/sh
ipset create ad hash:net
ipset create gw hash:net
iptables -t filter -A INPUT -m set --match-set ad dst -j REJECT

ip rule add fwmark 1 table 100
ip route add local 0.0.0.0/0 dev lo table 100
iptables -t mangle -A PREROUTING -p tcp -m set --match-set gw dst -j TPROXY --on-port 12345 --tproxy-mark 1
iptables -t mangle -A PREROUTING -p udp -m set --match-set gw dst -j TPROXY --on-port 12345 --tproxy-mark 1
iptables -t mangle -A OUTPUT -j RETURN -m mark --mark 255
iptables -t mangle -A OUTPUT -p tcp -m set --match-set gw dst -j MARK --set-mark 1
iptables -t mangle -A OUTPUT -p udp -m set --match-set gw dst -j MARK --set-mark 1
