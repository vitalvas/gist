#!/bin/sh

if [ -f ch_qos.sh ]
then
    rm ch_qos.sh
fi

ipfw='/sbin/ipfw -q'

echo "$ipfw table 10 flush" > ch_qos.sh

# grp=2 where 2 - vip
mysql -sse "select ip from users where grp=2" -uroot bill | while read ip
do
    echo "$ipfw table 10 add $ip" >> ch_qos.sh
done

scp ch_qos.sh 172.31.13.1:/root/

ssh 172.31.13.1 "chmod +x ch_qos.sh && ./ch_qos.sh"

rm ch_qos.sh

