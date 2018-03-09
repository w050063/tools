#!/bin/env bash
# host init scripts

packages_install(){
yum install -y gcc gcc-c++ autoconf automake python-devel python-pip git tree nmap telnet bash-completion net-tools bind-utils tcpdump lsof
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

main(){
packages_install
pip_setup
}

main
