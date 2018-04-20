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
