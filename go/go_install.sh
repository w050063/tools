#!/bin/env bash

wget https://dl.google.com/go/go1.10.1.linux-amd64.tar.gz
tar -zxf go1.10.1.linux-amd64.tar.gz -C /usr/local/
grep -q GOPATH /etc/profile
[ ! $? -eq 0 ] && cat>>/etc/profile<<EOF

# setup go path env
export GOROOT=/usr/local/go
export GOPATH="/data0/workspaces/go"
export PATH=\$PATH:\$GOROOT/bin:\$GOPATH/bin
EOF
source /etc/profile
go env
mkdir -p /data0/workspaces/go
