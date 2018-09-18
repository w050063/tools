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

# FQA
- 后面页面有乱码情况出现

# 参考资料
- http://blog.51cto.com/dongld/1321810
