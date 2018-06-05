# MySQL知识点
## MySQL概述
## MySQL安装部署
``` bash
wget https://raw.githubusercontent.com/mds1455975151/tools/master/mysql/install_mysql.sh
sh install_mysql.sh
```
## MySQL备份还原
## MySQL监控及故障处理
## MySQL批量管理
- 如何高效的插入数据库100w条数据(大概300~400M数据)
  - 脚本循环+insert
  ``` bash
  #!/bin/env bash

  text=",重复的sql内容"
  sql="INSERT INTO xxx.xxx(xx, xx, xx, xx, xx, xx, xx, xx, xx, xx) VALUES 重复的sql内容"
  end=";"
  sum=$sql
  for i in `seq 1`
  do
      for j in `seq 99`
      do
          sum=$sum$text
      done
      mysql -u xxx -h xxx -p'xxx' -e "$sum$end"
  done
  注意：修改第一个循环调整插入多少次，修改第二个循环调整每次sql拼接内容条数，看情况调整sql进行插入
  ```
  - 存储过程
  - 造数据+load data
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
- ERROR 1067 (42000) at line 621: Invalid default value for 'closeTime'							
``` bash 
show variables like 'sql_mode';
SET sql_mode = '';
SET GLOBAL sql_mode = 'ALLOW_INVALID_DATES,NO_ENGINE_SUBSTITUTION';
SET GLOBAL sql_mode = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';

NO_ZERO_IN_DATE,NO_ZERO_DATE


A timestamp. The range is '1970-01-01 00:00:01' UTC to '2038-01-19 03:14:07' UTC.
https://dev.mysql.com/doc/refman/5.7/en/date-and-time-type-overview.html
```
- mysql_errno: 1044, mysql_error: Access denied for user 'root'@'%' to databas
https://blog.csdn.net/aosica321/article/details/53433837
### SQL
### 分库分表
## 参考资料
