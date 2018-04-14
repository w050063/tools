yum -y install openldap-servers openldap-clients migrationtools openldap 
cp /usr/share/openldap-servers/DB_CONFIG.example /var/lib/ldap/DB_CONFIG 
chown ldap:ldap /var/lib/ldap/DB_CONFIG
systemctl start slapd && systemctl enable slapd 

sed -i 's/my-domain/worldoflove/g' /etc/openldap/slapd.d/cn\=config/olcDatabase\=\{2\}hdb.ldif
sed -i 's/com/cn/g' /etc/openldap/slapd.d/cn\=config/olcDatabase\=\{2\}hdb.ldif  
sed -i '/olcRootDN/aolcRootPW: 123456' /etc/openldap/slapd.d/cn\=config/olcDatabase\=\{2\}hdb.ldif

sed -i 's/my-domain/worldoflove/g' /etc/openldap/slapd.d/cn\=config/olcDatabase\=\{1\}monitor.ldif               
sed -i 's/com/cn/g' /etc/openldap/slapd.d/cn\=config/olcDatabase\=\{1\}monitor.ldif               

slaptest -u
systemctl restart slapd

netstat -lt | grep ldap

cd /etc/openldap/schema/
ldapadd -Y EXTERNAL -H ldapi:/// -D "cn=config" -f cosine.ldif
ldapadd -Y EXTERNAL -H ldapi:/// -D "cn=config" -f nis.ldif
ldapadd -Y EXTERNAL -H ldapi:/// -D "cn=config" -f collective.ldif
ldapadd -Y EXTERNAL -H ldapi:/// -D "cn=config" -f corba.ldif
ldapadd -Y EXTERNAL -H ldapi:/// -D "cn=config" -f core.ldif
ldapadd -Y EXTERNAL -H ldapi:/// -D "cn=config" -f duaconf.ldif
ldapadd -Y EXTERNAL -H ldapi:/// -D "cn=config" -f dyngroup.ldif
ldapadd -Y EXTERNAL -H ldapi:/// -D "cn=config" -f inetorgperson.ldif
ldapadd -Y EXTERNAL -H ldapi:/// -D "cn=config" -f java.ldif
ldapadd -Y EXTERNAL -H ldapi:/// -D "cn=config" -f misc.ldif
ldapadd -Y EXTERNAL -H ldapi:/// -D "cn=config" -f openldap.ldif
ldapadd -Y EXTERNAL -H ldapi:/// -D "cn=config" -f pmi.ldif
ldapadd -Y EXTERNAL -H ldapi:/// -D "cn=config" -f ppolicy.ldif

cd /usr/share/migrationtools/
sed -i 's/Group/Groups/g' migrate_common.ph 
sed -i 's/$DEFAULT_MAIL_DOMAIN = "padl.com";/$DEFAULT_MAIL_DOMAIN = "worldoflove.cn";/g' migrate_common.ph 
sed -i 's/$DEFAULT_BASE = "dc=padl,dc=com";/$DEFAULT_BASE = "dc=worldoflove,dc=cn";/g' migrate_common.ph 

/usr/share/migrationtools/migrate_base.pl > /root/base.ldif
 
ldapadd -x -W -D "cn=Manager,dc=worldoflove,dc=cn" -f /root/base.ldif
 
useradd madongsheng
useradd kongxiangyi
echo '123456' | passwd --stdin madongsheng
echo '123456' | passwd --stdin kongxiangyi
 
getent passwd | tail -n 2 > /root/users
getent shadow | tail -n 2 > /root/shadow
getent group | tail -n 2 > /root/groups 

sed -i.bak 's#/etc/shadow#/root/shadow#g' migrate_passwd.pl
/usr/share/migrationtools/migrate_passwd.pl /root/users > /root/users.ldif
/usr/share/migrationtools/migrate_group.pl /root/groups > /root/groups.ldif

ldapadd -x -W -D "cn=Manager,dc=worldoflove,dc=cn" -f /root/users.ldif
ldapadd -x -W -D "cn=Manager,dc=worldoflove,dc=cn" -f /root/groups.ldif

ldapsearch -x -b "cn=Manager,dc=worldoflove,dc=cn" -H ldap://127.0.0.1
systemctl stop firewalld
setenforce 0

# 查看用户信息
ldapsearch -LLL -W -x -H ldap://127.0.0.1 -D "cn=Manager,dc=worldoflove,dc=cn" -b "dc=worldoflove,dc=cn" "(uid=*)"

# 查看组信息
ldapsearch -LLL -W -x -H ldap://127.0.0.1 -D "cn=Manager,dc=worldoflove,dc=cn" -b "dc=worldoflove,dc=cn" "(cn=madongsheng)"

#查看指定用户信息
ldapsearch -LLL -W -x -H ldap://127.0.0.1 -D "cn=Manager,dc=worldoflove,dc=cn" -b "dc=worldoflove,dc=cn" "(uid=madongsheng)"

cat >>/etc/openldap/ldap.conf<<EOF
BASE    dc=worldoflove,dc=cn
URI     ldap://127.0.0.1
EOF
systemctl restart slapd

## phpldapadmin
291 $servers->setValue('server','name','ldap.worldoflove.cn');
298 $servers->setValue('server','host','127.0.0.1');
301 $servers->setValue('server','port',389);
305 $servers->setValue('server','base',array('dc=worldoflove,dc=cn'));
323 $servers->setValue('login','auth_type','session');
332 $servers->setValue('login','bind_id','cn=Manager,dc=worldoflove,dc=cn');
337 $servers->setValue('login','bind_pass','123456');
340 $servers->setValue('server','tls',false);
397 $servers->setValue('login','attr','dn');
398 //$servers->setValue('login','attr','uid');  

397\398行可能会引起报错Failed to Authenticate to server
