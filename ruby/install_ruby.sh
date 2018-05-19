#!/bin/env bash

install_ruby(){
ruby --version
wget https://cache.ruby-lang.org/pub/ruby/2.5/ruby-2.5.1.tar.gz
tar -zxf ruby-2.5.1.tar.gz
cd ruby-2.5.1
./configure
make && make install

ruby -v
yum install -y gem
gem sources --add http://gems.ruby-china.org/ --remove https://rubygems.org/ #(http)
#gem sources --add https://gems.ruby-china.org/ --remove https://rubygems.org/(https)
}

main(){
install_ruby
}

main
