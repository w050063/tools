# semaphore概述
- GitHub地址：https://github.com/ansible-semaphore/semaphore

# semaphore部署
# semaphore规范
- ansible部署
- semaphore部署
  - 数据库部署
- 创建ssh-keys
  - ansible-playbook仓库keys
  - 管理其他主机的服务器keys
- 创建inventory并编辑完善内容
- 创建playbook repositories
- 创建task templates

# 配置模板
```
# vim config.json
{
        "mysql": {
                "host": "10.1.16.151:3306",
                "user": "xxx",
                "pass": "xxx",
                "name": "semaphore"
        },
        "port": "",
        "tmp_path": "/tmp/semaphore",
        "cookie_hash": "NU7yB7zHfw12Xgn2gSfdQYFxTGEyDJspKDTRdZNBaB8=",
        "cookie_encryption": "Vq+1F/gUjDMQlFEimZDCBqh7XenrJlqaBCAj2qyjdfo=",
        "email_sender": "",
        "email_host": "",
        "email_port": "",
        "web_host": "http://10.1.16.153:8010/",
        "ldap_binddn": "cn=Manager,dc=xxx,dc=cn",
        "ldap_bindpassword": "xxx",
        "ldap_server": "ldap.dev.xxx.cn:389",
        "ldap_searchdn": "ou=People,dc=xxx,dc=cn",
        "ldap_searchfilter": "(uid=%s)",
        "ldap_mappings": {
                "dn": "dn",
                "mail": "mail",
                "uid": "uid",
                "cn": "cn"
        },
        "telegram_chat": "",
        "telegram_token": "",
        "concurrency_mode": "",
        "max_parallel_tasks": 0,
        "email_alert": false,
        "telegram_alert": false,
        "ldap_enable": true,
        "ldap_needtls": false
 }
```
# FQA
# 参考资料
- https://github.com/morbidick/ansible-role-semaphore
- https://github.com/dsmorse/semaphore-docker
- https://telegram.org/
