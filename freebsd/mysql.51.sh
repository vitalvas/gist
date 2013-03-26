#!/bin/sh

mkdir /var/db/ports/mysql

echo "# Added by automake script" > /var/db/ports/mysql/options
echo "_OPTIONS_READ=mysql-server-`cat /usr/ports/databases/mysql51-server/Makefile | grep PORTVERSION | awk '{print $2}'`" >> /var/db/ports/mysql/options
echo "WIDTH_OPENSSL=true" >> /var/db/ports/mysql/options
echo "WIDTHOUT_FASTMTX=true" >> /var/db/ports/mysql/options

mkdir /var/db/ports/mysql51-client

echo "# Added by automake script" > /var/db/ports/mysql51-client/options
echo "_OPTIONS_READ=mysql-client-`cat /usr/ports/databases/mysql51-server/Makefile | grep PORTVERSION | awk '{print $2}'`" >> /var/db/ports/mysql51-client/options
echo "WIDTH_OPENSSL=true" >> /var/db/ports/mysql51-client/options
echo "WIDTHOUT_FASTMTX=true" >> /var/db/ports/mysql51-client/options

echo "DEFAULT_MYSQL_VER=51" >> /etc/make.conf

cd /usr/ports/databases/mysql51-server/
make BUILD_OPTIMIZED=yes WITH_OPENSSL=yes WITH_CHARSET=utf8
make install clean

/usr/local/bin/mysql_install_db

chown -Rv mysql:mysql /var/db/mysql/

cat /usr/local/share/mysql/my-huge.cnf | sed 's/log-bin=mysql-bin/#log-bin=mysql-bin/' | sed 's/##/#/' | sed 's/#skip-networking/skip-networking/' > /usr/local/etc/my.cnf
ln -s /usr/local/etc/my.cnf /var/db/mysql/my.cnf

echo 'mysql_enable="YES"' >> /etc/rc.conf

passwd=`cat /dev/urandom | tr -dc a-zA-Z0123456789 | head -c 12`

/usr/local/etc/rc.d/mysql-server start
/usr/local/bin/mysqladmin -u root password "$passwd"
/usr/local/etc/rc.d/mysql-server restart

echo "root:$passwd" > /root/mysql.pwd
echo "[client]" > ~/.my.cnf
echo "password = $passwd" >> ~/.my.cnf

rehash
