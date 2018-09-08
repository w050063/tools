```
1、ssh互信
ssh-copy-id 192.168.200.100
ssh-copy-id 192.168.200.101
ssh-copy-id 192.168.200.102
2、机器初始化
ansible-playbook host-init-vm.yml -i ../hosts.ambari -l hadoop
3、jdk
ansible-playbook install_jdk.yml -i ../hosts.ambari -l hadoop -e "REPO_IP=xxx"
4、mysql jdbc driver
ansible-playbook install_mysql_jdpc_driver.yml -i ../hosts.ambari -l hadoop -e "REPO_IP=xxx"
5、设置ambari源
所有节点server or agent
wget -O /etc/yum.repos.d/ambari.repo http://qcloud-cdn.xxx.cn/loveworld/ambari.repo
6、安装MySQL
hive组件需要，部署在node01
wget https://raw.githubusercontent.com/mds1455975151/tools/master/mysql/install_mysql.sh
sh install_mysql.sh

7、安装ambari
yum install -y ambari-server
ambari-server setup
ambari-server start
ambari-server status

http://192.168.200.100:8080   admin,admin

页面设置
http://qcloud-cdn.xxx.cn/loveworld/bigdata/hdp/centos7/HDP-3.0.0.0
http://qcloud-cdn.xxx.cn/loveworld/bigdata/hdp/centos7/HDP-3.0.0.0
http://qcloud-cdn.xxx.cn/loveworld/bigdata/hdp/centos7/HDP-UTILS-1.1.0.22

linux-node01.example.com
linux-node02.example.com
linux-node03.example.com

设置密码 8位
ambari-server setup --jdbc-db=mysql --jdbc-driver=/data0/src/mysql-connector-java-8.0.12/mysql-connector-java-8.0.12.jar

dba 192.168.200.100

漫长的等待

很有可能各种服务都无法启动

/hadoop/hdfs/data
/hadoop/hdfs/namenode
/hadoop/hdfs/namesecondary
/hadoop/hdfs/journalnode
/var/log/hadoop

所有组件安装路径
/usr/hdp/

端口列表
8020

```
