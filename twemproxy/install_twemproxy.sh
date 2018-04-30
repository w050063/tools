#!/bin/env bash

yum install -y autoconf automake libtool
git clone https://github.com/twitter/twemproxy.git
cd twemproxy/
git checkout -b v0.4.1
git branch -a
autoreconf -fvi
./configure --enable-debug=full
make
src/nutcracker -h
