#!/bin/env bash
# host init scripts

yum_setup(){
yum install -y wget
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo
}

packages_install(){
yum install -y gcc gcc-c++ autoconf automake python-devel python-pip git tree nmap telnet bash-completion net-tools bind-utils tcpdump lsof vim wget
}

pip_setup(){
mkdir -p  ~/.pip
cat <<EOF > ~/.pip/pip.conf
[global]
index-url = http://mirrors.aliyun.com/pypi/simple/
[install]
trusted-host=mirrors.aliyun.com
EOF
pip install pip --upgrade
}

sublist3r_install(){
mkdir -p /data0/src
cd /data0/src
git clone https://github.com/aboul3la/Sublist3r.git
cd Sublist3r/
pip install -r requirements.txt
}

service_setup(){
systemctl stop NetworkManager
systemctl disable NetworkManager
}

git_setup(){
git config --global user.name "mds1455975151"
git config --global user.email 1455975151@qq.com
}

main(){
yum_setup
packages_install
pip_setup
service_setup
git_setup
}

main
