https://github.com/mds1455975151/tools/blob/master/php/install_newrelic.sh

``` bash 
sudo rpm -Uvh http://yum.newrelic.com/pub/newrelic/el5/x86_64/newrelic-repo-5-3.noarch.rpm
sudo yum install newrelic-php5
sudo newrelic-install install

newrelic.appname = "xxx develop"
systemctl restart php-fpm
```
