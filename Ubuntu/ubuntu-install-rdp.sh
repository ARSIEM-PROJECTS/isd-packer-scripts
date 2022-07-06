#Use this file to automate:
#   1. Installation of xrdp and freerdp
#   2. Installation of xfce desktop environment
apt-get update
apt-get upgrade -y
apt-get -y install xfce4
apt-get -y install xrdp
systemctl enable xrdp
apt install freerdp2-dev -y
echo xfce4-session >~/.xsession
service xrdp restart