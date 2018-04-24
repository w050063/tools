# SVN 知识总结
- https://www.cnblogs.com/eastson/p/6051269.html
- https://blog.csdn.net/wanglei_storage/article/details/52663328

# svn + httpd + openldap
``` bash
#!/bin/env bash
yum install -y httpd svn mod_dav_svn mod_ldap
cp /etc/httpd/conf.modules.d/10-subversion.conf /etc/httpd/conf.d/subversion.conf
cat>>/etc/httpd/conf.d/subversion.conf<<EOF
<Location /opt/svn>
    DAV svn
    SVNParentPath /opt/svn
    SVNListParentPath On
    AuthzSVNAccessFile /opt/svn/authz

    AuthBasicProvider ldap
    AuthType Basic
    AuthName "Subversion repository"
    AuthLDAPURL "ldap://192.168.1.200:389/dc=hongxue,dc=com?uid?sub?(objectClass=*)"
    AuthLDAPBindDN "cn=root,dc=hongxue,dc=com"
    AuthLDAPBindPassword "123456"
    Require valid-user
</Location>
EOF
systemctl start httpd.service
systemctl enable httpd.service
cd /opt/ && svnadmin create svn
svnserve -d -r /opt/svn/
chown apache.apache -R /opt/svn
```

# svn + httpd
``` bash

```
