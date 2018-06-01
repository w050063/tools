# Ubuntu概述
- Docker hub地址：https://hub.docker.com/_/ubuntu/

# 仓库配置
## apt-get使用
apt-cache search php
apt-get install php
/etc/apt/sources.list

docker pull ubuntu:14.04


# 常用软件安装
## PHP环境
``` bash
sudo add-apt-repository ppa:ondrej/php 
sudo apt-get update
apt-get install php7.1
a2dismod php5 # 如果之前有其他版本，在这边禁用掉
a2enmod php7.1
apt-get install php7.1-mysql
apt-get install php7.1-curl
apt-get install php7.1-mbstring
apt-get install php7.1-gd
apt-get install php7.1-xml
apt-get install php7.1-soap
apt-get install php7.1-mcrypt
```
# FQA
# 参考资料

