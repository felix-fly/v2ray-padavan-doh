#!/bin/sh

wget -O v2ray/ad.ips https://raw.githubusercontent.com/felix-fly/v2ray-dnsmasq-dnscrypt/master/ad.ips
wget -O v2ray/ad.hosts https://raw.githubusercontent.com/felix-fly/v2ray-dnsmasq-dnscrypt/master/ad.hosts
wget -O v2ray/ad-ext.hosts https://raw.githubusercontent.com/felix-fly/v2ray-dnsmasq-dnscrypt/master/ad-ext.hosts
wget -O v2ray/gw.ips https://raw.githubusercontent.com/felix-fly/v2ray-dnsmasq-dnscrypt/master/gw.ips
wget -O v2ray/gw.hosts https://raw.githubusercontent.com/felix-fly/v2ray-dnsmasq-dnscrypt/master/gw.hosts

# change for smartdns
sed 's/=/ /g' v2ray/ad.hosts > tmp
sed 's/\/$/\/#/g' tmp > smartdns/ad.hosts
sed 's/=/ /g' v2ray/ad-ext.hosts > tmp
sed 's/\/$/\/#/g' tmp > smartdns/ad-ext.hosts
sed 's/server=/nameserver /g' v2ray/gw.hosts > tmp1
sed 's/127.0.0.1#1053/gw/g' tmp1 > tmp2
sed 's/=/ /g' tmp2 > smartdns/gw.hosts
rm tmp tmp1 tmp2
