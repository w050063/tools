## 功能：测试某个用户是否为某个组的成员
## 参考资料
- http://www.adimian.com/blog/2014/10/how-to-enable-memberof-using-openldap/
- https://blog.csdn.net/tongdao/article/details/52538365

## 测试过程
### memberof_config.ldif
``` bash
# cat memberof_config.ldif
dn: cn=module,cn=config
cn: module
objectClass: olcModuleList
olcModulePath: /usr/lib64/openldap
olcModuleLoad: memberof.la

dn: olcOverlay={0}memberof,olcDatabase={1}hdb,cn=config
objectClass: olcConfig
objectClass: olcMemberOf
objectClass: olcOverlayConfig
objectClass: top
olcOverlay: memberof
olcMemberOfDangling: ignore
olcMemberOfRefInt: TRUE
olcMemberOfGroupOC: groupOfNames
olcMemberOfMemberAD: member
olcMemberOfMemberOfAD: memberOf
```
### refint1.ldif 
``` bash
# cat refint1.ldif 
dn: cn=module,cn=config
cn: module
objectclass: olcModuleList
objectclass: top
olcModuleLoad: refint.la
olcModulePath: /usr/lib64/openldap
```
### refint2.ldif 
``` bash
# cat refint2.ldif 
dn: olcOverlay={1}refint,olcDatabase={1}hdb,cn=config
objectClass: olcConfig
objectClass: olcOverlayConfig
objectClass: olcRefintConfig
objectClass: top
olcOverlay: {1}refint
olcRefintAttribute: memberof member manager owner
```
### add memberof_config.ldif\refint1.ldif\refint2.ldif
``` bash
ldapadd -Y EXTERNAL -H ldapi:/// -f memberof_config.ldif
ldapadd -Y EXTERNAL -H ldapi:/// -f refint1.ldif 
ldapadd -Y EXTERNAL -H ldapi:/// -f refint2.ldif 
```
### Adding a user
``` bash
# slappasswd -h {SHA} -s 123456
{SHA}fEqNCco3Yq9h5ZUglD3CZJT4lBs=
# cat add_user.ldif 
dn: uid=john,ou=People,dc=worldoflove,dc=cn
cn: John Doe
givenName: John
sn: Doe
uid: john
uidNumber: 5000
gidNumber: 10000
homeDirectory: /home/john
mail: john.doe@example.com
objectClass: top
objectClass: posixAccount
objectClass: shadowAccount
objectClass: inetOrgPerson
objectClass: organizationalPerson
objectClass: person
loginShell: /bin/bash
userPassword: {SHA}fEqNCco3Yq9h5ZUglD3CZJT4lBs=
# ldapadd -x -D "cn=Manager,dc=worldoflove,dc=cn" -W -f add_user.ldif
nter LDAP Password: 
adding new entry "uid=john,ou=People,dc=worldoflove,dc=cn"
```
### Adding a group
``` bash
# cat add_group.ldif 
dn: cn=mygroup,ou=Groups,dc=worldoflove,dc=cn
objectClass: groupofnames
cn: mygroup
description: All users
member: uid=john,ou=People,dc=worldoflove,dc=cn
# ldapadd -x -D "cn=Manager,dc=worldoflove,dc=cn" -W -f add_group.ldif
Enter LDAP Password: 
adding new entry "cn=mygroup,ou=Groups,dc=worldoflove,dc=cn"
```
### Taking it for a test-run
``` bash
# ldapsearch -x -LLL -H ldap:/// -b uid=john,ou=people,dc=worldoflove,dc=cn dn memberof
dn: uid=john,ou=People,dc=worldoflove,dc=cn
```
And it should yield this result
``` bash
dn: uid=john,ou=People,dc=worldoflove,dc=cn
memberOf: cn=mygroup,ou=groups,dc=worldoflove,dc=cn
```
