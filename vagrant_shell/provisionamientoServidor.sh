#!/bin/bash

echo "Configurando resolv.conf con cat"
cat <<TEST> /etc/resolv.conf
nameserver 8.8.8.8
TEST

echo "Instalando un servidor vsftpd"
sudo apt-get install vsftpd -y

echo "Modificando vsftpd.conf con sed"
sed -i 's/#write_enable=YES/write_enable=YES/g' /etc/vsftpd.conf

echo "Configurando IP fordwarding con echo"
sudo echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf


