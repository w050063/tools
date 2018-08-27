# CDH (Cloudera's Distribution, including Apache Hadoop)
# CDH概述
Cloudera CDH是为了简化Hadoop的安装，也对Hadoop做了一些封装。

收费情况：
- Cloudera Express版本是免费的
- Cloudera Enterprise是需要购买注册码的

相关站点：
- 官网地址：https://www.cloudera.com/
- 官网项目地址：https://www.cloudera.com/products/open-source/apache-hadoop/key-cdh-components.html
- 下载地址：https://www.cloudera.com/downloads.html
- 官网文档: https://www.cloudera.com/documentation/enterprise/latest.html

Cloudrea Manager下载
- http://archive.cloudera.com/cm5/cm/5/cloudera-manager-centos7-cm5.15.1_x86_64.tar.gz

CDH下载
- http://archive.cloudera.com/cdh5/parcels/latest/CDH-5.15.1-1.cdh5.15.1.p0.4-el7.parcel
- http://archive.cloudera.com/cdh5/parcels/latest/CDH-5.15.1-1.cdh5.15.1.p0.4-el7.parcel.sha1
- http://archive.cloudera.com/cdh5/parcels/latest/manifest.json
- http://archive.cloudera.com/cdh5/repo-as-tarball/5.15.1/cdh5.15.1-centos7.tar.gz.md5
- http://archive.cloudera.com/cdh5/repo-as-tarball/5.15.1/cdh5.15.1-centos7.tar.gz.sha1
- http://archive.cloudera.com/cdh5/repo-as-tarball/5.15.1/cdh5.15.1-centos7.tar.gz


CM(Cloudera Manager)有三种安装方式：
- 使用cloudera-manager-installer.bin安装
- 使用rpm、yum、apt-get方式在线安装
- 使用是Tarballs的方式

CDH安装方式：
- Yum/Apt包、RPM包
- Tar包
- CM安装

本地安装源

# agent

# CM部署
- 注册账号
- 下载并安装(国内离线安装方式最佳)

- 关闭iptables、selinux
- 时间同步
- 免密钥登录
- hosts解析
- swap设置

- jdk
- MySQL
```
git clone https://github.com/mds1455975151/tools.git
sh ansible_install.sh

ssh-copy-id 192.168.200.100
ssh-copy-id 192.168.200.101

ansible-playbook host-init-vm.yml -i ../hosts.cdh5 -l node01,node02

ansible-playbook install_ntp.yml -i ../hosts.cdh5 -l node01 -e "ntp_type=server"
ansible-playbook install_ntp.yml -i ../hosts.cdh5 -l node02

wget https://raw.githubusercontent.com/mds1455975151/tools/master/mysql/install_mysql.sh
sh install_mysql.sh
systemctl stop mysqld
\cp tools/ansible/playbook/files/cloudera/my.cnf /etc/my.cnf
systemctl start mysqld

ansible-playbook install_cloudera_manager.yml -i ../hosts.cdh5 -l node01

ansible-playbook install_cloudera.yml -i ../hosts.cdh5 -l node01,node02

```
http://192.168.200.100:7180
账号密码默认admin

# 参考资料
https://www.cnblogs.com/jasondan/p/4011153.html
https://blog.csdn.net/u014034049/article/details/78439578
https://www.jianshu.com/p/57179e03795f

http://www.aboutyun.com/thread-18107-1-1.html

# FQA
- 安装完成后各文件目录结构情况
http://www.aboutyun.com/thread-9189-1-1.html
- 问题集锦
http://www.aboutyun.com/thread-12431-1-1.html
- 解析问题
```
正在检测 Cloudera Manager Server...
CentOS Linux release 7.4.1708 (Core)
BEGIN host -t PTR 192.168.200.100
100.200.168.192.in-addr.arpa domain name pointer bogon.
END (0)
using bogon as scm server hostname
BEGIN which python
/usr/bin/python
END (0)
BEGIN python -c 'import socket; import sys; s = socket.socket(socket.AF_INET); s.settimeout(5.0); s.connect((sys.argv[1], int(sys.argv[2]))); s.close();' bogon 7182
Traceback (most recent call last):
File "<string>", line 1, in <module>
File "/usr/lib64/python2.7/socket.py", line 224, in meth
return getattr(self._sock,name)(*args)
socket.gaierror: [Errno -2] Name or service not known
END (1)
could not contact scm server at bogon:7182, giving up
waiting for rollback request
```
解决版本：
```
sudo mv /usr/bin/host /usr/bin/host.bak
```
- 安装失败。 无法接收 Agent 发出的检测信号。
  - 检查提示信息中的问题
  - ntp时间问题
  -
```
python -c 'import socket; print socket.getfqdn(), socket.gethostbyname(socket.getfqdn())'
```
# to-do-list
