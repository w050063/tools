#!/bin/env bash 

yum install -y make automake libtool python-devel python-virtualenv MySQL-python openssl-devel gcc-c++ git pkg-config bison curl unzip
yum install -y java-1.7.0-openjdk
useradd vitess
