#!/bin/sh

for conf in ssh asterisk
do
    if [ -f "/usr/local/etc/bruteblock/$conf.conf" ]
    then
	curl -s https://raw.github.com/vitalvas/freebsd-auto/master/bruteblock/filters/$conf.conf > /usr/local/etc/bruteblock/$conf.conf
    fi
done
