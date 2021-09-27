#!/bin/sh

mkdir tmp

wget -O tmp/ad.hosts https://raw.githubusercontent.com/felix-fly/v2ray-dnsmasq-dnscrypt/master/ad.hosts
wget -O tmp/ad-ext.hosts https://raw.githubusercontent.com/felix-fly/v2ray-dnsmasq-dnscrypt/master/ad-ext.hosts
wget -O tmp/gw.hosts https://raw.githubusercontent.com/felix-fly/v2ray-dnsmasq-dnscrypt/master/gw.hosts

# copy for dnsmasq
cp tmp/*.hosts dnsmasq

# change for smartdns
cat tmp/ad.hosts | awk '{print $2}' > tmp/tmp
awk '{print "address /"$0"/#"}' tmp/tmp > smartdns/ad.hosts
cat tmp/ad-ext.hosts | awk '{print $2}' > tmp/tmp
awk '{print "address /"$0"/#"}' tmp/tmp > smartdns/ad-ext.hosts
cat tmp/ad-ext.hosts | awk '{print $2}' > tmp/tmp
awk '{print "address /"$0"/#"}' tmp/tmp > smartdns/ad-ext.hosts
sed 's/server=/nameserver /g' tmp/gw.hosts > tmp/tmp1
sed 's/127.0.0.1#1053/gw/g' tmp/tmp1 > tmp/tmp2
sed 's/=/ /g' tmp/tmp2 > smartdns/gw.hosts
rm -rf tmp
