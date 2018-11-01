#!/bin/env bash

sed -i '/terraform bin PATH setup/d' /etc/profile
sed -i '/\/usr\/local\/terraform\//d' /etc/profile

cat>>/etc/profile<<EOF

# terraform bin PATH setup
export PATH=\$PATH:/usr/local/terraform/bin/
EOF
source /etc/profile

