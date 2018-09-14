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
# chmod +x atlassian-confluence-6.7.1-x64.bin
# ./atlassian-confluence-6.7.1-x64.bin
Unpacking JRE ...
Starting Installer ...

This will install Confluence 6.7.1 on your computer.
OK [o, Enter], Cancel [c]

Choose the appropriate installation or upgrade option.
Please choose one of the following:
Express Install (uses default settings) [1],
Custom Install (recommended for advanced users) [2, Enter],
Upgrade an existing Confluence installation [3]
2

Where should Confluence 6.7.1 be installed?
[/opt/atlassian/confluence]

Default location for Confluence data
[/var/atlassian/application-data/confluence]

Configure which ports Confluence will use.
Confluence requires two TCP ports that are not being used by any other
applications on this machine. The HTTP port is where you will access
Confluence through your browser. The Control port is used to Startup and
Shutdown Confluence.
Use default ports (HTTP: 8090, Control: 8000) - Recommended [1, Enter], Set custom value for HTTP and Control ports [2]

Confluence can be run in the background.
You may choose to run Confluence as a service, which means it will start
automatically whenever the computer restarts.
Install Confluence as Service?
Yes [y, Enter], No [n]


Extracting files ...


Please wait a few moments while we configure Confluence.
Installation of Confluence 6.7.1 is complete
Start Confluence now?
Yes [y, Enter], No [n]
n
Installation of Confluence 6.7.1 is complete
Finishing installation ...
```
- 页面设置
  - 修改显示语言类型
  - 获得插件不选
  - 根据服务器ID利用破解器获得key
  ```
  name: sdfsfsdfsdf
  key: AAABNg0ODAoPeJxtkMtuwjAQRff+CktdGyWEFopkqSZxpZQ8UBOqlp0Jk2LJmMiPqP37BlI2VTcjj
  e6dO2fmrj56XEGHwwiH8+VsvgxmOK5qPA3CBUrANkZ2Tp41jc+6VR50A6jwpz2Yst1aMJaSEMUGx
  MWUCAf0MkmCRxJGaJhxonGFOAG1h9a2l3JoUTNkTQZB9kCd8XAz8lxIRaXupZV7BU+2AQ0TrRDvh
  fLXFbQVysKYkMlBt1B/d3BdEZd5zl/jlGVoCNIOtBhw+VcnzfeIFkVzEk7J9H4MuB0SK28dmOJ8A
  EsDVPGCfpRbnLM1xznHDFcswRtWJGyCSvMptLQjjCzeZCVXGcc1ZzmqwPRg0oSunt8ZWayzmOx2V
  UrSh+gF/dIOapYmt+5/uI03zVFY+PPPH0NKi1wwLQIVAIMKZ6uJ5TS6v7IKcxTo4gntCwvmAhQ+g
  yh8DbZznnJBDRv1wzPm8kYawQ==X02fj
  ```
  - 我自己的数据库
  - 设置您的数据库(设置隔离级别)
  ```
  CREATE DATABASE `confluence` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
  GRANT ALL PRIVILEGES ON confluence.* TO 'confluence'@'%' IDENTIFIED BY PASSWORD '*D6027F9F55352F47C2177DB6408DBA472F781B51' WITH GRANT OPTION;
  flush privileges;
  ```
  -
- 修改内存大小，优化性能
```
# vim /opt/atlassian/confluence/bin/setenv.sh
CATALINA_OPTS="-Xms1024m -Xmx1024m -XX:+UseG1GC ${CATALINA_OPTS}"
```

- 部署好其他设置
  - 一般设置(设置服务器主机URL)
    站点管理--配置--一般配置--站点配置
  - 设置自动备份
    - 站点管理--配置--每日备份管理
    - 备份路径:  /var/atlassian/application-data/confluence/backups/2018091302-backup.zip
  - 语言设置
    站点管理--配置--语言--设置中文(中国)
  - 设置权限
    站点管理--用户&安全--全局权限(为新用户设置默认权限，设置ldap用户组权限，不设置这个新用户无法登陆)
  - 设置ldap
    站点管理--用户&安全--用户目录--添加目录 建议只读模式
  - 确认版本和许可证(保证破解成功，使用人数无限制)
    站点管理--授权细节

- 新建项目

# FQA
- 后面页面有乱码情况出现

# 参考资料
- [安装指导](https://confluence.atlassian.com/doc/confluence-installation-and-upgrade-guide-214864161.html)
- [linux环境](https://confluence.atlassian.com/doc/installing-confluence-on-linux-143556824.html)
- 6.7.1 https://www.cnblogs.com/Javame/p/8779772.html 有破解包下载
- 6.3.1 https://www.cnblogs.com/kevingrace/p/7607442.html 有破解包
