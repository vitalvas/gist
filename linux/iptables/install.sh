echo '#!/bin/bash' > /etc/network/if-up.d/iptables
echo '/sbin/iptables-restore < /etc/iptables' >> /etc/network/if-up.d/iptables
chmod +x /etc/network/if-up.d/iptables
