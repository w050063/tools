# snmpwalk命令
```
yum -y install net-snmp-utils
```
# 查找OID
下载查阅OID的第三方软件（Getif）

命令
```
snmpwalk -v 2c -c public 10.1.16.2 1.3.6.1.2.1.2.2.1.3
```
