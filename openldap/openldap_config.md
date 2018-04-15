## LDAP + jenkins
Server-----------------ldap://192.168.200.101:389
root DN----------------dc=worldoflove,dc=cn
User search filter-----uid={0}
Manager DN-------------cn=Manager,dc=worldoflove,dc=cn
Manager Password-------123456
最后测试LDAP测试，使用madongsheng:123456即可

## LDAP + gitlab
https://docs.gitlab.com/ee/administration/auth/ldap.html
``` bash
# cat /etc/gitlab/gitlab.rb | grep -A 24 ldap_servers
###! **Be careful not to break the indentation in the ldap_servers block. It is
###!   in yaml format and the spaces must be retained. Using tabs will not work.**

gitlab_rails['ldap_enabled'] = true 

###! **remember to close this block with 'EOS' below**
gitlab_rails['ldap_servers'] = YAML.load <<-'EOS'
  main: # 'main' is the GitLab 'provider ID' of this LDAP server
    label: 'LDAP'
    host: '192.168.200.101'
    port: 389
    uid: 'uid'
    bind_dn: 'cn=Manager,dc=worldoflove,dc=cn'
    password: '123456'
    encryption: 'plain' # "start_tls" or "simple_tls" or "plain"
    verify_certificates: true
    active_directory: true
    allow_username_or_email_login: false
    lowercase_usernames: false
    block_auto_created_users: false
    base: 'dc=worldoflove,dc=cn'
    user_filter: ''
    ## EE only
    group_base: ''
    admin_group: ''
    sync_ssh_keys: false
EOS
```

## LDAP + open-falcon
https://www.jianshu.com/p/8e9d9978f596

/home/work/open-falcon/dashboard/rrd/config.py
# ldap config
LDAP_ENABLED = os.environ.get("LDAP_ENABLED",True)
LDAP_SERVER = os.environ.get("LDAP_SERVER","192.168.200.101:389")
LDAP_BASE_DN = os.environ.get("LDAP_BASE_DN","dc=worldoflove,dc=cn")
LDAP_BINDDN_FMT = os.environ.get("LDAP_BINDDN_FMT","uid=%s,dc=worldoflove,dc=cn")
LDAP_SEARCH_FMT = os.environ.get("LDAP_SEARCH_FMT","uid=%s")
LDAP_ATTRS = ["cn","mail","telephoneNumber"]
LDAP_TLS_START_TLS = False
LDAP_TLS_CACERTDIR = ""
LDAP_TLS_CACERTFILE = "/etc/openldap/certs/ca.crt"
LDAP_TLS_CERTFILE = ""
LDAP_TLS_KEYFILE = ""
LDAP_TLS_REQUIRE_CERT = True
LDAP_TLS_CIPHER_SUITE = ""

## LDAP + Zabbix
