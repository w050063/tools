#!/bin/env bash

time_flag=`date +%Y%m%d%H%M%S`
license_key="cfc8926965a3111ec0b28e5a69f114d657a40074"
newrelic_appname=`echo ${time_flag}|md5sum|awk '{print $1}'`

install_newrelic(){
rpm -Uvh http://yum.newrelic.com/pub/newrelic/el5/x86_64/newrelic-repo-5-3.noarch.rpm
yum install -y newrelic-php5
echo ${license_key}|newrelic-install install

cp /etc/php.d/newrelic.ini{,.`date +%Y%m%d`}
cat >/etc/php.d/newrelic.ini<<EOF
extension = "newrelic.so"
[newrelic]
newrelic.license = "${license_key}"
newrelic.logfile = "/var/log/newrelic/php_agent.log"
newrelic.appname = "${newrelic_appname}"
newrelic.daemon.logfile = "/var/log/newrelic/newrelic-daemon.log"
newrelic.daemon.port = "@newrelic-daemon"
newrelic.transaction_tracer.threshold = "10ms"
EOF
\cp /etc/newrelic/newrelic.cfg.template /etc/newrelic/newrelic.cfg

}

main(){
install_newrelic
}

main
