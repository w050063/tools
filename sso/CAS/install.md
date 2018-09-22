```
基于Powered by Apereo Central Authentication Service 5.2.6 2018-09-22T06:25:50Z
https://apereo.github.io/cas/5.2.x/


yum install -y java-1.8.0-openjdk
yum install -y maven
maven设置国内源

git clone https://github.com/apereo/cas-overlay-template.git
cd cas-overlay-template/
git branch -a
git checkout 5.2
./build.sh help
vim etc/cas/config/cas.properties
cas.server.name: https://sso.dev.xxx.cn:8443/
cas.server.prefix: https://sso.dev.xxx.cn:8443/cas

./build.sh package

                <dependency>
                    <groupId>org.apereo.cas</groupId>
                    <artifactId>cas-server-support-pm-jdbc</artifactId>
                    <version>${cas.version}</version>
                </dependency>





```
http://10.1.16.153:8080/cas  默认账号:casuser  密码:Mellon
![images](01.png)

# to-do-list:
- ~~Non-secure Connection, tomcat设置https访问即可~~
- Static Authentication，接入ldap解决账号问题
- cas-services-management-overlay

```
参考资料：https://apereo.github.io/cas/5.3.x/installation/Password-Management-LDAP.html

cd /data0/src/cas/cas-overlay-template
vim pom.xml
<dependency>
    <groupId>org.apereo.cas</groupId>
    <artifactId>cas-server-support-pm-ldap</artifactId>
    <version>${cas.version}</version>
</dependency>
./build.sh package
scp cdn02:/data0/src/cas/cas-overlay-template/target/cas.war .


```

# CAS与jenkins集成
- https://wiki.jenkins.io/display/JENKINS/CAS+Plugin
# CAS与Confluence集成
- https://blog.csdn.net/yelllowcong/article/details/79651651
# CAS与Jira集成

# 参考资料
- https://www.cnblogs.com/flying607/p/7598248.html
- https://apereo.github.io/2018/02/06/cas52-gettingstarted-overlay/
- https://blog.csdn.net/xiaoxing598/article/details/55518241
- https://blog.csdn.net/fireofjava/article/details/79072187



https://apereo.github.io/cas/5.3.x/installation/Password-Management-JDBC.html
