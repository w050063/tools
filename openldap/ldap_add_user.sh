#!/bin/env bash

if [ ! $# -eq 3 ]
then
    echo -e "Usages: $0 ldap_username ldap_uid ldap_gid"
    echo -e """
manager        1002
planner        1003
programmer     1004
qa             1005
art            1006
operator       1007
marketer       1008
financial      1009
administration 1010
"""
    exit 1
fi

ldap_username=$1
ldap_uid=$2
ldap_gid=$3

groupadd -g 1002 -f manager
groupadd -g 1003 -f planner
groupadd -g 1004 -f programmer
groupadd -g 1005 -f qa
groupadd -g 1006 -f art
groupadd -g 1007 -f operator
groupadd -g 1008 -f marketer
groupadd -g 1009 -f financial
groupadd -g 1010 -f administration 

grep -q $ldap_username /etc/passwd
if [ ! $? -eq 0 ]
then
    useradd -u ${ldap_uid} -g ${ldap_gid} $ldap_username
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
