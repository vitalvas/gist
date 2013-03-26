#!/bin/sh

echo 'ntpdate_enable="YES"' >> /etc/rc.conf
echo 'ntpdate_hosts="pool.ntp.org"' >> /etc/rc.conf
echo 'fsck_y_enable="YES"' >> /etc/rc.conf
echo 'background_fsck="NO"' >> /etc/rc.conf
echo 'autoboot_delay="2"' >> /boot/loader.conf

echo 'WITHOUT_X11=yes' >> /etc/make.conf
echo 'WITHOUT_GUI=yes' >> /etc/make.conf
echo 'WITHOUT_IPV6=yes' >> /etc/make.conf
echo 'WITHOUT_BLUETOOTH=TRUE' >> /etc/make.conf
echo 'WITHOUT_GAMES=TRUE' >> /etc/make.conf
echo 'WITHOUT_IPX=TRUE' >> /etc/make.conf
echo 'WITHOUT_NIS=TRUE' >> /etc/make.conf
echo 'NO_PROFILE=true' >> /etc/make.conf
echo 'CFLAGS= -O -pipe' >> /etc/make.conf

echo 'nameserver 8.8.8.8' >> /etc/resolv.conf
echo 'nameserver 8.8.4.4' >> /etc/resolv.conf

echo '30 */6 * * * /usr/sbin/ntpdate pool.ntp.org > /dev/null 2>&1' >> /etc/crontab

echo 'security.bsd.see_other_uids=0' >> /etc/sysctl.conf
echo 'security.bsd.see_other_gids=0' >> /etc/sysctl.conf
echo 'net.inet.tcp.blackhole=2' >> /etc/sysctl.conf
echo 'net.inet.udp.blackhole=1' >> /etc/sysctl.conf
echo 'net.inet.icmp.drop_redirect=1' >> /etc/sysctl.conf
echo 'net.inet.tcp.drop_synfin=1' >> /etc/sysctl.conf
echo 'net.inet.tcp.syncookies=1' >> /etc/sysctl.conf

