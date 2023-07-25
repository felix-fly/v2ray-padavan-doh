#!/bin/sh

# sync for dnsmasq
wget -O dnsmasq/ad.hosts https://raw.githubusercontent.com/felix-fly/v2ray-dnsmasq-dnscrypt/master/ad.hosts
wget -O dnsmasq/gw.hosts https://raw.githubusercontent.com/felix-fly/v2ray-dnsmasq-dnscrypt/master/gw.hosts

# sync for smartdns
wget -O smartdns/ad.hosts https://raw.githubusercontent.com/felix-fly/v2ray-dnsmasq-dnscrypt/master/smartdns/ad.hosts
wget -O smartdns/gw.hosts https://raw.githubusercontent.com/felix-fly/v2ray-dnsmasq-dnscrypt/master/smartdns/gw.hosts
