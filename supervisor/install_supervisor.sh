#!/bin/env bash

yum install -y python-pip
pip install supervisor
mkdir -p /etc/supervisor/conf.d/
echo_supervisord_conf >/etc/supervisor/supervisord.conf
sed -i 's#;[include]#[include]#g' /etc/supervisor/supervisord.conf
sed -i 's#;files = relative/directory/*.ini#files = /etc/supervisor/conf.d/*.ini#g' /etc/supervisor/supervisord.conf
supervisord -c /etc/supervisor/supervisord.conf
