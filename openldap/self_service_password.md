## 项目需求
让用户可以自助修改OpenLDAP的账号密码
self_service_password项目地址：https://ltb-project.org/start

## 环境说明
``` bash
# cat /etc/redhat-release 
CentOS Linux release 7.4.1708 (Core) 
# uname -r
3.10.0-693.el7.x86_64
# uname -m
x86_64
# rpm -qa|grep ldap
openldap-2.4.44-5.el7.x86_64
```

## OpenLDAP安装配置
[参考地址](https://github.com/mds1455975151/tools/blob/master/openldap/ldap-c7-install.sh)
- 涉及个人用户修改密码的权限设置部分
``` bash 
sed -i '/olcRootPW/aolcAccess: {1}to * by dn.base="cn=Manager,dc=worldoflove,dc=cn" write by self write by * read' /etc/openldap/slapd.d/cn\=config/olcDatabase\=\{2\}hdb.ldif
sed -i '/olcRootPW/aolcAccess: {0}to attrs=userPassword by self write by dn.base="cn=Manager,dc=worldoflove,dc=cn" write by anonymous auth by * none' /etc/openldap/slapd.d/cn\=config/olcDatabase\=\{2\}hdb.ldif
```
## self_service_password安装配置
### 下载RPM包
https://ltb-project.org/documentation/self-service-password/1.2/start
### 安装RPM
```
# rpm -ivh self-service-password-1.2-1.el7.noarch.rpm
# rpm -qc self-service-password 
/etc/httpd/conf.d/self-service-password.conf
/usr/share/self-service-password/conf/config.inc.php
```
### 配置httpd
```
# cat /etc/httpd/conf.d/self-service-password.conf
<VirtualHost *>
        ServerName xxx.xxx.cn

        DocumentRoot /usr/share/self-service-password
        DirectoryIndex index.php

        AddDefaultCharset UTF-8

        <Directory /usr/share/self-service-password>
            AllowOverride None
            <IfVersion >= 2.3>
                Require all granted
            </IfVersion>
            <IfVersion < 2.3>
                Order Deny,Allow
                Allow from all
            </IfVersion>
        </Directory>

        LogLevel warn
        ErrorLog /var/log/httpd/ssp_error_log
        CustomLog /var/log/httpd/ssp_access_log combined
</VirtualHost>
```
### 修改self-service-password配置
``` bash
# grep -vE '^#|^$' /usr/share/self-service-password/conf/config.inc.php
<?php
$debug = false;
$ldap_url = "ldap://127.0.0.1";
$ldap_starttls = false;
$ldap_binddn = "cn=Manager,dc=worldoflove,dc=cn";
$ldap_bindpw = "xxxx";
$ldap_base = "dc=worldoflove,dc=cn";
$ldap_login_attribute = "uid";
$ldap_fullname_attribute = "cn";
$ldap_filter = "(&(objectClass=account)($ldap_login_attribute={login}))";
$keyphrase = "247029c9123274c78ab8160965f4d29f";  //否则有报错提醒
```
### 测试及验证
略
### 参考资料
- https://www.ilanni.com/?p=13822
- https://ltb-project.org
