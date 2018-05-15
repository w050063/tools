# MySQL知识点
## MySQL概述
## MySQL安装部署
## MySQL备份还原
## MySQL监控及故障处理
## MySQL批量管理
## FQA
- mysql -P 指定端口不起作用
``` text
mysql -P 指定端口不起作用，我的MySQL端口实际在3306上，但指定32442端口也能连接上：
[root@centos7 ~] #15> mysql -uroot -hlocalhost -P32442 -p
Enter password: 
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 13
Server version: 10.1.30-MariaDB MariaDB Server

Copyright (c) 2000, 2017, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]> 
默认尝试3306端口进行连接，连接上才不去尝试-P指定的端口号了，即：如果使用的是3306端口，则-P参数无效，此处指定的32442没有生效。
```
### SQL
### 分库分表
## 参考资料
