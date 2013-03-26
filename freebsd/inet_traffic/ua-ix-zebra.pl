#!/usr/bin/perl -w

#################################################
#                                               #
#           Zebra config generator              #
#         standart, with UA-IX nets             #
#                                               #
#    Powered by Muff: admin@muff.kiev.ua        #
#              viersion 1.1                     #
#################################################

$zebracf="zebra.conf";                                  # zebra config file
$zebrapath="/usr/local/etc/quagga/";                    # Path to zebra
$uaixlisturl="http://noc.ix.net.ua/ua-list.txt";        # UA-IX list url
$fname="ua-list.txt";
$ip="89.209.7.1";                                       # IP to Route networks


# Start Basic zebtra config
$temp_zebra="!
!
!          Don't  FORGET  !!!!!
!
!  This config was automatically created
!  Modify FIRST /usr/local/etc/quagga/ua-ix-zebra.pl
!  
!
! Zebra configuration saved from vty
!   2009/09/24 15:48:12
!
hostname zebra-sdlan.kiev.ua
password 8 bJ7qj7mo8C0WM
enable password 8 4DdaPSepeKP5w
log file /var/log/quagga/zebra.log
log stdout
service password-encryption
!
interface em0
!
interface lo0
!
interface nfe0
!
interface pflog0
!
interface pfsync0
!
interface plip0
!
interface rl0
!
interface tun0
!
ip route 0.0.0.0/0 195.3.156.73
!
ip forwarding
ipv6 forwarding
!
!
line vty
 exec-timeout 5 0
 !
";
############

#### Don't modify!
unless (-e $zebrapath.$fname)
{
        print "File not found. Download.\n";
        `fetch -o $zebrapath$fname  $uaixlisturl`;
}

open(F,"< $zebrapath$fname") or die "Couldn't open $zebrapath$fname for reading: $!\n";
while(<F>)
{
        chomp;
        push(@a,"ip route $1/24 $ip\n") if /^((([0-9]+)\.)+[0-9]+)$/ ;
        push(@a,"ip route $_ $ip\n") if /^(([0-9]+)\.)+([0-9]+)(\/[0-9]+)$/ ;
}
push(@a,"ip route 91.196.139.20/32 $ip\n") if /^((([0-9]+)\.)+[0-9]+)$/ ;
close(F);

open(OUT, "> $zebrapath$zebracf") or die "can't open $zebrapath$zebracf: $!";
print OUT $temp_zebra;
foreach (@a)
{
        print OUT;
}
close(OUT);

`/usr/local/etc/rc.d/quagga restart`
