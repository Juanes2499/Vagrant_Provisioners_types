#!/bin/bash

echo "Instalando un servidor vsftpd"
sudo apt-get install vsftpd -y

echo "Desplegando servicio de vsftpd"
sudo systemctl start vsftpd

echo "Revisando estado del servicio vsftpd"
sudo systemctl status vsftpd

echo "Creando usuario local userftp"
sudo adduser userftp --gecos "First Last,RoomNumber,WorkPhone,HomePhone,Other" --disabled-password
echo "userftp:1234" | sudo chpasswd

echo "Agregando a lista vsftpd.userlist"
echo "userftp"  | sudo tee -a /etc/vsftpd.userlist

echo "Reiniciando el servicio vsftpd"
sudo systemctl restart vsftpd

echo "Cambiando el banner de bienvenida"
sed -i 's/#ftpd_banner=Welcome to blah FTP service/ftpd_banner=Bienvenidos al servidor FTP/g' /etc/vsftpd.conf

echo "Restrigiendo acceso a usuarios anonimos"
sed -i 's/#anonymus_enable=YES/anonymus_enable=NO/g' /etc/vsftpd.conf

echo "Configurando IP fordwarding con echo"
sudo echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf


