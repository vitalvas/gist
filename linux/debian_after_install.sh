#!/bin/bash

apt-get update

# install locale 
apt-get install locales
dpkg-reconfigure locales
locale-gen
export LC_ALL="en_US.UTF-8"
echo 'LC_ALL=en_US.UTF-8' >> /etc/default/locale

# timezone
dpkg-reconfigure tzdata

curl https://raw.github.com/vitalvas/linux-work/master/custom/.bashrc >> ~/.bashrc
if [ -f /home/vitalvas/.bashrc ];
then
  curl https://raw.github.com/vitalvas/linux-work/master/custom/.bashrc >> /home/vitalvas/.bashrc
fi

