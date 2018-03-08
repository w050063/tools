#!/bin/env bash
packages_install(){
    yum install -y gcc gcc-c++ autoconf automake python-devel python-pip git tree nmap telnet bash-completion
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

main(){
packages_install
pip_setup
}

main
