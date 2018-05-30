# PHP
## PHP概述
- https://webtatic.com/packages/php71/

## 常用架构
- LNMP(推荐)
- LAMP
## 常用模块
- opcache

## 性能分析
## FQA
- 有可能影响PHP读写MySQL库
  ``` bash
  # php -i | grep Client
  Client API library version => 5.5.50-MariaDB
  Client API header version => 5.5.56-MariaDB
  Client API version => 5.5.50-MariaDB
  
  yum remove -y php-mysql
  yum install -y php-mysqlnd
  ```
## 参考资料
