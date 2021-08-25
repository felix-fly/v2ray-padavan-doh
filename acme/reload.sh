#!/bin/sh

sleep 2

PID=$(pidof httpd)
kill -9 $PID
/usr/sbin/httpd -s 443
