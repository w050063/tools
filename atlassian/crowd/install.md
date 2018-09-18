- 初始化机器
- 安装jdk
- 下载包
```
# wget https://www.atlassian.com/software/crowd/downloads/binary/atlassian-crowd-3.1.5.zip
# unzip atlassian-crowd-3.1.5.zip
# cp -rf atlassian-crowd-3.1.5 /opt/atlassian/crowd
# cd /opt/atlassian/crowd
# vim crowd-webapp/WEB-INF/classes/crowd-init.properties
crowd.home=/opt/atlassian/crowd
```
- 安装数据库或者使用云数据库实例
- 创建数据库，设置权限
```
CREATE DATABASE `crowd` DEFAULT CHARACTER SET utf8;
GRANT ALL PRIVILEGES ON crowd.* TO 'crowd'@'%' IDENTIFIED BY PASSWORD '*D6027F9F55352F47C2177DB6408DBA472F781B51' WITH GRANT OPTION;
flush privileges;
```
- 安装程序
```
cp mysql-connector-java-5.1.44-bin.jar /opt/atlassian/crowd/apache-tomcat/lib/

```
- 页面设置
  - 修改显示语言类型
  - 获得插件不选
  - 根据服务器ID利用破解器获得key
  - 我自己的数据库
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
- http://blog.51cto.com/dongld/1321810
