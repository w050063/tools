#!/bin/env bash

if [ ! $# -eq 1 ]
then
    echo -e "Usages: $0 ldap_username"
    exit 1
fi

ldap_username=$1

grep -q $ldap_username /etc/passwd
if [ ! $? -eq 0 ]
then
    useradd $ldap_username
    echo "$ldap_username" | passwd --stdin $ldap_username
else
    echo "$ldap_username is exist!!!"   
    exit 1
fi

getent passwd |grep $ldap_username >users_$ldap_username
getent shadow |grep $ldap_username >/root/shadow
sed -i.bak 's#/etc/shadow#/root/shadow#g' /usr/share/migrationtools/migrate_passwd.pl
/usr/share/migrationtools/migrate_passwd.pl users_$ldap_username > users_${ldap_username}.ldif
userdel -r $ldap_username

ldapadd -x -W -D "cn=Manager,dc=worldoflove,dc=cn" -f users_${ldap_username}.ldif
