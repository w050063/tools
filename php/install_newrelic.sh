#!/bin/env bash

license-key="cfc8926965a3111ec0b28e5a69f114d657a40074"
newrelic.appname=`echo `date +%Y%m%d%H%M%S`|md5sum|awk '{print $1}'`

install_newrelic(){
rpm -Uvh http://yum.newrelic.com/pub/newrelic/el5/x86_64/newrelic-repo-5-3.noarch.rpm
yum install -y newrelic-php5
newrelic-install install

cp /etc/php.d/newrelic.ini{,.`date +%Y%m%d`}
cat >/etc/php.d/newrelic.ini<<EOF
extension = "newrelic.so"
[newrelic]
newrelic.license = "${license-key}"
newrelic.logfile = "/var/log/newrelic/php_agent.log"
newrelic.appname = "${newrelic.appname}"
newrelic.daemon.logfile = "/var/log/newrelic/newrelic-daemon.log"
newrelic.daemon.port = "@newrelic-daemon"
newrelic.transaction_tracer.threshold = "10ms"
EOF
}

main(){
install_newrelic
}

main
