#! /bin/bash
#Use this file to automate:
#   1. Installation of Guacamole
#   2. ip capture of all VM's within resource group, storing them to guac's user-mapping.xml
#Note - this machine does not need to be RDP'd into. Older versions have been commented out
apt-get update
apt-get upgrade -y
apt-get install gcc-6 g++-6 libossp-uuid-dev libavcodec-dev libpango1.0-dev libssh2-1-dev libcairo2-dev libjpeg-turbo8-dev libpng-dev libavutil-dev libswscale-dev libfreerdp-dev libvncserver-dev libssl-dev libvorbis-dev libwebp-dev -y
apt-get install libguac-client-rdp0 -y
apt install freerdp2-dev -y
apt-get install tomcat8 tomcat8-admin tomcat8-common tomcat8-user -y
wget https://dlcdn.apache.org/guacamole/1.3.0/source/guacamole-server-1.3.0.tar.gz 
tar -xvzf guacamole-server-1.3.0.tar.gz  #tar -xvzf guacamole-server-1.1.0.tar.gz 
#git clone git://github.com/glyptodon/guacamole-server.git
cd guacamole-server-1.3.0
#autoreconf -fi
./configure --with-init-dir=/etc/init.d
make
make install
ldconfig
#sudo update-rc.d guacd defaults
systemctl enable guacd
systemctl start guacd
wget https://mirrors.estointernet.in/apache/guacamole/1.3.0/binary/guacamole-1.3.0.war #May have to update the .war version in the future...
mkdir /etc/guacamole
mv guacamole-1.3.0.war /etc/guacamole/guacamole.war
ln -s /etc/guacamole/guacamole.war /var/lib/tomcat8/webapps/
systemctl restart tomcat8
systemctl restart guacd
cd ..
git clone https://github.com/sean-custer/Arsiem-Guac-files.git
mv Arsiem-Guac-files/guacamole.properties /etc/guacamole/
mkdir /etc/guacamole/{extensions,lib}
echo "GUACAMOLE_HOME=/etc/guacamole" >> /etc/default/tomcat8
apt-get install python-pip -y
pip install lxml 
pip install requests
apt install jq -y