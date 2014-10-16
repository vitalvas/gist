#!/bin/bash -x

/usr/bin/env useradd -m -G sudo vitalvas
/usr/bin/env mkdir /home/vitalvas/.ssh
/usr/bin/env wget --no-check-certificate -q https://github.com/vitalvas.keys -O /home/vitalvas/.ssh/authorized_keys
/usr/bin/env chown -R vitalvas:vitalvas /home/vitalvas/.ssh
