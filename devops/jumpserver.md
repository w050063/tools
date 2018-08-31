- 官网地址：http://www.jumpserver.org/
- 官网文档：http://docs.jumpserver.org/zh/docs/index.html
- GitHub地址：https://github.com/jumpserver/jumpserver

# FQA
- 普通用户资产信息详细程度不足
- 与其他系统资产同步(aws\aliyun\腾讯云等)
- 监控联动open-falcon
- 使用手册推动研发人员使用
- 更精细的权限管理

# to-do-list
- ~~部署安装(一体化部署文档)~~
  - ~~Django debug模式关闭~~
  - ~~nginx设置~~
  - ~~日常管理(启动、重启、停止等等操作)~~
  - 高可用方案
  - wiki功能
  - 导航功能

- 系统设置
  - 基本设置
  - 邮件设置(配置完成后需要手动重启)
  - ldap设置(配置完成后需要手动重启)
  - 终端设置(暂时未设置)
  - 安全设置(密码校验规则修改)

- 资产管理
  - 管理用户
  > 管理用户是资产（被控服务器）上的root，或拥有 NOPASSWD: ALL sudo权限的用户，Jumpserver使用该用户来 `推送系统用户`、`获取资产硬件信息`等。 Windows或其它硬件可以随意设置一个

  - 系统用户
  > 系统用户是 Jumpserver跳转登录资产时使用的用户，可以理解为登录资产用户，如 web, sa, dba(`ssh web@some-host`), 而不是使用某个用户的用户名跳转登录服务器(`ssh xiaoming@some-host`); 简单来说是 用户使用自己的用户名登录Jumpserver, Jumpserver使用系统用户登录资产。 系统用户创建时，如果选择了自动推送 Jumpserver会使用ansible自动推送系统用户到资产中，如果资产(交换机、windows)不支持ansible, 请手动填写账号密码。 目前还不支持Windows的自动推送

  - 资产列表
    资产必填项 主机名 IP 协议 端口 系统平台 公网IP 网域省略

- 会话管理
  - 终端管理(接受默认的主动注册请求)
- 权限管理

- API文档
  - http://{ip}/docs/
- 其他
  - 默认数据库 账号：jumpserver 密码：somepassword
  - 资产表assets_asset

# API
``` json
$ curl -X POST -H 'Content-Type: application/json' -d '{"username": "admin", "password": "admin"}' http://localhost/api/users/v1/token/  # 获取token
{"Token":"937b38011acf499eb474e2fecb424ab3","KeyWord":"Bearer"}%  # 获取到的token

$ curl -H 'Authorization: Bearer 937b38011acf499eb474e2fecb424ab3' -H "Content-Type:application/json" http://localhost/api/users/v1/users/
# 使用token访问，token有效期 1小时

curl -X POST -H 'Content-Type: application/json' -d '{"username": "admin", "password": "admin"}' http://localhost/api/users/v1/token/
curl -H 'Authorization: Bearer 35d862791cf44af18d14dc39bc76c337' -H "Content-Type:application/json" http://localhost/api/users/v1/users/

curl -H 'Authorization: Bearer 35d862791cf44af18d14dc39bc76c337' -H "Content-Type:application/json" -d '{"ip": "1.1.1.1", "hostname": "test01", "port": "22","admin_user_id":"f9ff44fc03c6489f8fabe0c816f2b579"}' http://localhost/api/assets/v1/assets/
```

# 参考资料
- https://github.com/getway/diting
- https://github.com/xskh2007/zjump
- https://github.com/XWJR-Ops/Jumpserver-VerificationCode
- https://github.com/zhuguojun6/ansible_jumpserver
- https://github.com/ladeyi/jumpserver
- https://github.com/wstart/jumpserver_script
- https://github.com/choldrim/jumpserver-ext
