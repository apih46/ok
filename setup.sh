#!/bin/bash
RED="\e[1;31m"
GREEN="\e[0;32m"
NC="\e[0m"
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=$(date +"%Y-%m-%d" -d "$dateFromServer")
#########################

BURIQ() {
    curl -sS https://raw.githubusercontent.com/apih46/access/main/ip >/root/tmp
    data=($(cat /root/tmp | grep -E "^### " | awk '{print $2}'))
    for user in "${data[@]}"; do
        exp=($(grep -E "^### $user" "/root/tmp" | awk '{print $3}'))
        d1=($(date -d "$exp" +%s))
        d2=($(date -d "$biji" +%s))
        exp2=$(((d1 - d2) / 86400))
        if [[ "$exp2" -le "0" ]]; then
            echo $user >/etc/.$user.ini
        else
            rm -f /etc/.$user.ini >/dev/null 2>&1
        fi
    done
    rm -f /root/tmp
}

MYIP=$(curl -sS ipv4.icanhazip.com)
Name=$(curl -sS https://raw.githubusercontent.com/apih46/access/main/ip | grep $MYIP | awk '{print $2}')
echo $Name >/usr/local/etc/.$Name.ini
CekOne=$(cat /usr/local/etc/.$Name.ini)

Bloman() {
    if [ -f "/etc/.$Name.ini" ]; then
        CekTwo=$(cat /etc/.$Name.ini)
        if [ "$CekOne" = "$CekTwo" ]; then
            res="Expired"
        fi
    else
        res="Permission Accepted..."
    fi
}

PERMISSION() {
    MYIP=$(curl -sS ipv4.icanhazip.com)
    IZIN=$(curl -sS https://raw.githubusercontent.com/apih46/access/main/ip | awk '{print $4}' | grep $MYIP)
    if [ "$MYIP" = "$IZIN" ]; then
        Bloman
    else
        res="Permission Denied!"
    fi
    BURIQ
}
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
PERMISSION
if [ -f /home/needupdate ]; then
    red "Your script need to update first !"
    exit 0
elif [ "$res" = "Permission Accepted..." ]; then
    green "Permission Accepted !"
else
    red "Permission Denied !"
    rm setup.sh >/dev/null 2>&1
    sleep 10
    exit 0
fi
clear
echo -e "${RED}Installing Some Updates On This VPS${NC}"
mkdir -p /etc/samvpn
mkdir -p /etc/samvpn/xray
mkdir -p /etc/samvpn/ntls
mkdir -p /etc/samvpn/tls
mkdir -p /etc/samvpn/config-url
mkdir -p /etc/samvpn/config-user
mkdir -p /etc/samvpn/xray/conf
mkdir -p /etc/samvpn/ntls/conf
mkdir -p /etc/systemd/system/
mkdir -p /var/log/xray/
touch /etc/samvpn/xray/user.txt

apt update -y
apt upgrade -y
apt dist-upgrade -y
apt-get remove --purge ufw firewalld -y
apt-get remove --purge exim4 -y

# install wget and curl
apt -y install wget curl

# Install Requirements Tools
apt install ruby -y
apt install python -y
apt install make -y
apt install cmake -y
apt install coreutils -y
apt install rsyslog -y
apt install net-tools -y
apt install zip -y
apt install unzip -y
apt install nano -y
apt install sed -y
apt install gnupg -y
apt install gnupg1 -y
apt install bc -y
apt install jq -y
apt install apt-transport-https -y
apt install build-essential -y
apt install dirmngr -y
apt install libxml-parser-perl -y
apt install neofetch -y
apt install git -y
apt install lsof -y
apt install libsqlite3-dev -y
apt install libz-dev -y
apt install gcc -y
apt install g++ -y
apt install libreadline-dev -y
apt install zlib1g-dev -y
apt install libssl-dev -y
apt install libssl1.0-dev -y
apt install dos2unix -y
apt-get install netfilter-persistent -y
apt-get install socat -y
apt install figlet -y
apt install git -y
clear
echo "Please Input Your Domain Name"
read -p "Input Your Domain : " host
if [ -z $host ]; then
    echo "No Domain Inserted !"
else
    echo $host >/root/domain
fi
echo -e "${RED}Installing XRAY${NC}"
sleep 2

wget https://raw.githubusercontent.com/apih46/ok/main/ins-xray.sh && chmod +x ins-xray.sh && ./ins-xray.sh
wget https://raw.githubusercontent.com/apih46/ok/main/ssh-vpn.sh && chmod +x ssh-vpn.sh && ./ssh-vpn.sh
cd /usr/bin
wget -O menu "https://raw.githubusercontent.com/apih46/ok/main/xray-menu.sh" && chmod +x menu
wget -O xp "https://raw.githubusercontent.com/apih46/ok/main/xp.sh" && chmod +x xp
wget -O installer "https://raw.githubusercontent.com/apih46/ok/main/BOT_PANEL/installer.sh" && chmod +x installer
wget -O bbt "https://raw.githubusercontent.com/apih46/ok/main/BOT_PANEL/bbt.sh" && chmod +x bbt
wget -q -O /usr/bin/tcp https://raw.githubusercontent.com/apih46/ok/main/tcp.sh && chmod +x /usr/bin/tcp
timedatectl set-timezone Asia/Kuala_Lumpur
echo "0 0 * * * root xp" >>/etc/crontab
echo "1 0 * * * root systemctl restart xray.service" >>/etc/crontab
echo "1 0 * * * root systemctl restart xray@n" >>/etc/crontab
echo "1 0 * * * root systemctl restart xray.service" >>/etc/crontab
echo "0 5 * * * root reboot" >>/etc/crontab
/etc/init.d/cron restart
clear
systemctl restart nginx
cd
echo "menu" >>/root/.profile
echo " "
echo "===================-[ LUKAKU Multiport ]-===================="
echo ""
echo "------------------------------------------------------------"
echo ""
echo "   - OpenVPN                    : TCP 1194, UDP 2200, SSL 442" | tee -a log-install.txt
echo "   - Stunnel4                   : 789, 777" | tee -a log-install.txt
echo "   - Squid Proxy                : 3128, 8080" | tee -a log-install.txt
echo "   - VLess TCP XTLS             : 443" | tee -a log-install.txt
echo "   - XRAY  Trojan TLS           : 443" | tee -a log-install.txt
echo "   - XRAY  Vmess TLS            : 443" | tee -a log-install.txt
echo "   - XRAY  Vmess None TLS       : 80" | tee -a log-install.txt
echo "   - XRAY  Vless TLS            : 443" | tee -a log-install.txt
echo "   - XRAY  Vless None TLS       : 8000" | tee -a log-install.txt
echo ""
echo "------------------------------------------------------------"
echo ""
echo "===================-[ LUKAKU Multiport ]-===================="
echo ""
rm -f /root/ins-xray.sh
rm -f /root/setup.sh
read -n 1 -s -r -p "Press any key to reboot"
reboot
