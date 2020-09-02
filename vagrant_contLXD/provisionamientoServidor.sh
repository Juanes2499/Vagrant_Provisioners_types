#!/bin/bash

echo "Inicio de aprovisionamiento*************************************************************"

echo "instalar net-tools"
sudo apt install net-tools -y

echo "configurando el resolv.conf con cat"
cat <<TEST> /etc/resolv.conf
nameserver 8.8.8.8
TEST

echo "Instalando el paquete LXD"
#sudo apt-get install lxd -y

echo "Logeando en un nuevo grupo de LXD"
#sudo newgrp lxd

echo "Iniciando LXD"
#sudo lxd init --auto

echo "Instalando y desplegando un contenedor Ubuntu 18.04 llamado Server"
#sudo lxc launch ubuntu:18.04 Server

echo "Instalando un apache2 en el contenedor Server"
sudo lxc exec Server -- apt-get install apache2 -y

echo "Ramplazando el archivo index.html del contenedor Server por un archivo index.html presonalizado"
sudo lxc file push /vagrant/index.html Server/var/www/html/index.html

echo "Reiniciando el servicio de apache2 en el contenedor Server"
sudo lxc exec Server -- systemctl restart apache2

echo "Renvio de puerto del contenedor a la máquina virtual"
sudo lxc config device add Server apacheport80server proxy listen=tcp:192.168.111.2:5080 connect=tcp:127.0.0.1:80

echo "Fin de aprovisionamiento*************************************************************"
