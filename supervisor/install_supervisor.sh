#!/bin/env bash

pip_install(){
yum install -y python-pip
pip install supervisor
mkdir -p /etc/supervisord.d
echo_supervisord_conf >/etc/supervisord.conf
sed -i 's#;[include]#[include]#g' /etc/supervisord.conf
sed -i 's#;files = relative/directory/*.ini#files = /etc/supervisord.d/*.ini#g' /etc/supervisord.conf
supervisord -c /etc/supervisord.conf
}

yum_install(){
yum install -y supervisor
systemctl start supervisord.service 
systemctl enable supervisord.service
}

main(){
# pip_install
yum_install
}

main
