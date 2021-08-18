#!/bin/sh

ifconfig eth0:100 51.79.180.61 netmask 255.255.255.0 up;
echo 'DEVICE=eth0:100' >> /etc/sysconfig/network-scripts/ifcfg-eth0:100;
echo 'IPADDR=51.79.180.61' >> /etc/sysconfig/network-scripts/ifcfg-eth0:100;
echo 'NETMASK=255.255.255.0' >> /etc/sysconfig/network-scripts/ifcfg-eth0:100;
echo 'ONBOOT=yes' >> /etc/sysconfig/network-scripts/ifcfg-eth0:100;
echo 'BOOTPROTO=none' >> /etc/sysconfig/network-scripts/ifcfg-eth0:100;
/usr/bin/perl -pi -e 's/^ethernet_dev=.*/ethernet_dev=eth0:100/' /usr/local/directadmin/conf/directadmin.conf;
service network restart;
service directadmin stop;
rm -rf /usr/sbin/da_license;
/usr/bin/wget -O /usr/sbin/da_license https://github.com/minhvinhdao/Active-DA-/raw/main/da_license.gz;
/usr/bin/gunzip /usr/sbin/da_license.gz;
chmod 755 /usr/sbin/da_license;
rm -rf /usr/local/directadmin/conf/license.key;
/usr/bin/wget -O /usr/local/directadmin/conf/license.key https://github.com/minhvinhdao/Active-DA-/raw/main/license.key;
chmod 600 /usr/local/directadmin/conf/license.key;
chown diradmin:diradmin /usr/local/directadmin/conf/license.key;
systemctl restart directadmin
if [ -s /usr/local/directadmin/conf/directadmin.conf ]; then
	echo "================================================"
	echo "Da active xong - Ban truy cap vao Direct Admin de su dung";
	echo "================================================"
fi

printf \\a
sleep 1
printf \\a
sleep 1
printf \\a

