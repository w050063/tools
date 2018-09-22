```
yum install -y java-1.8.0-openjdk
yum install -y maven
maven设置国内源

git clone https://github.com/apereo/cas-overlay-template.git
cd cas-overlay-template/
git branch -a
git checkout 5.2
./build.sh help
./build.sh package

                <dependency>
                    <groupId>org.apereo.cas</groupId>
                    <artifactId>cas-server-support-pm-jdbc</artifactId>
                    <version>${cas.version}</version>
                </dependency>
                <dependency>
                    <groupId>org.apereo.cas</groupId>
                    <artifactId>cas-server-support-pm-ldap</artifactId>
                    <version>${cas.version}</version>
                </dependency>




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



https://apereo.github.io/cas/5.3.x/installation/Password-Management-JDBC.html
