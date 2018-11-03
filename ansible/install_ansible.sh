#!/bin/env bash

get_dist_name(){
if grep -Eqii "CentOS" /etc/issue || grep -Eq "CentOS" /etc/*-release; then
    distro='CentOS'
elif grep -Eqi "Red Hat Enterprise Linux Server" /etc/issue || grep -Eq "Red Hat Enterprise Linux Server" /etc/*-release; then
    distro='RHEL'
elif grep -Eqi "Aliyun" /etc/issue || grep -Eq "Aliyun" /etc/*-release; then
    distro='Aliyun'
elif grep -Eqi "Fedora" /etc/issue || grep -Eq "Fedora" /etc/*-release; then
    distro='Fedora'
elif grep -Eqi "Debian" /etc/issue || grep -Eq "Debian" /etc/*-release; then
    distro='Debian'
elif grep -Eqi "Kali"   /etc/issue || grep -Eq "Kali"   /etc/*-release; then
    distro='Debian'
elif grep -Eqi "Ubuntu" /etc/issue || grep -Eq "Ubuntu" /etc/*-release; then
    distro='Ubuntu'
elif grep -Eqi "Raspbian" /etc/issue || grep -Eq "Raspbian" /etc/*-release; then
    distro='Raspbian'
else
    distro='unknow'
fi
echo $distro
}

get_dist_name=`get_dist_name`
[ "$get_dist_name" = "CentOS" ] && yum install -y python-pip
[ "$get_dist_name" = "Debian" ] && apt-get install -y python-pip
[ "$get_dist_name" = "Kali"   ] && apt-get install -y python-pip
mkdir -p  ~/.pip
cat <<EOF > ~/.pip/pip.conf
[global]
index-url = http://mirrors.aliyun.com/pypi/simple/
[install]
trusted-host=mirrors.aliyun.com
EOF
pip install pip --upgrade
pip install ansible

mkdir -p ~/.ssh/keys/
ssh-keygen -q -N "" -t rsa -b 2048 -f /root/.ssh/id_rsa
\cp -r ../ansible /etc/
