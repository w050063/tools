#!/bin/env bash

install_newrelic(){
rpm -Uvh http://yum.newrelic.com/pub/newrelic/el5/x86_64/newrelic-repo-5-3.noarch.rpm
yum install -y newrelic-php5
newrelic-install install
license-key="cfc8926965a3111ec0b28e5a69f114d657a40074"
}

main(){
install_newrelic
}

main
