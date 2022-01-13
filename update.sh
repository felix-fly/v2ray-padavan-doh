#!/bin/sh

mkdir tmp

wget -O tmp/ad.hosts https://raw.githubusercontent.com/felix-fly/v2ray-dnsmasq-dnscrypt/master/ad.hosts
wget -O tmp/gw.hosts https://raw.githubusercontent.com/felix-fly/v2ray-dnsmasq-dnscrypt/master/gw.hosts

# copy for dnsmasq
cp tmp/*.hosts dnsmasq

# convert to ad.list
sed 's/^address=\//0.0.0.0 /g' tmp/ad.hosts > tmp/tmp
sed 's/\///g' tmp/tmp > dnsmasq/ad.list

# convert to gw.list
sed '/^ipset.*/d' tmp/gw.hosts > tmp/tmp1
sed 's/^server=\//./g' tmp/tmp1 > tmp/tmp2
sed 's/\/127.0.0.1#1053//g' tmp/tmp2 > dnsmasq/gw.list

# change for smartdns
sed 's/=/ /g' tmp/ad.hosts > tmp/tmp
sed 's/\/$/\/#/g' tmp/tmp > smartdns/ad.hosts
sed 's/server=/nameserver /g' tmp/gw.hosts > tmp/tmp1
sed 's/127.0.0.1#1053/gw/g' tmp/tmp1 > tmp/tmp2
sed 's/=/ /g' tmp/tmp2 > smartdns/gw.hosts
rm -rf tmp
