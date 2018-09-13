- 下载包
- 初始化机器
- 安装jdk
- 安装数据库或者使用云数据库实例
- 创建数据库，设置权限
```
CREATE DATABASE `jira` DEFAULT CHARACTER SET utf8;
GRANT ALL PRIVILEGES ON jira.* TO 'jira'@'%' IDENTIFIED BY PASSWORD '*D6027F9F55352F47C2177DB6408DBA472F781B51' WITH GRANT OPTION;
flush privileges;
```
- 安装程序
```
chmod +x atlassian-jira-software-7.8.1-x64.bin
./atlassian-jira-software-7.8.1-x64.bin
```

- 修改内存大小，优化性能
```
# vim /opt/atlassian/jira/bin/setenv.sh
JVM_MINIMUM_MEMORY="1024m"
JVM_MAXIMUM_MEMORY="2018m"
```

- 部署好其他设置
  - 确认版本和许可证(保证破解成功，使用人数无限制)
    应用程序--版本和许可证
  - 集成设置
    应用程序--集成--DVCS accounts 代码集成
  - 设置通知方案
    问题--通知方案--设置SMTP
  - 设置权限方案
    问题--权限方案
  - 设置ldap
    用户管理--用户目录--添加目录 建议只读模式
  - 设置基础URL
    系统--一般设置
  - 系统
    系统--导入与导出--导入外部系统
    系统--管理员助手--可用于排查用户具有的权限
  - 设置自动备份
    系统--高级--服务
    备份路径:  /var/atlassian/application-data/jira/export/2018091302-backup.zip

- 新建项目
- 设置权限
  - 系统--全局权限(添加管理员权限)
  - 应用程序--应用程序访问权(为新用户设置默认权限，设置ldap用户组权限，不设置这个新用户无法登陆)

# 参考资料
- [Linux环境](https://confluence.atlassian.com/adminjiraserver071/installing-jira-applications-on-linux-802592173.html)
- https://confluence.atlassian.com/adminjiraserver071/installing-jira-applications-802592161.html
