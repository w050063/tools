# GrayLog知识总结
## GrayLog概述
## GrayLog安装部署
- ansible

ansible-galaxy install Graylog2.graylog-ansible-role

``` bash
yum install java-1.8.0-openjdk
cat>/etc/yum.repos.d/mongodb-org-3.6.repo<EOF
[mongodb-org-3.6]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/3.6/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-3.6.asc
EOF
yum install -y mongodb-org
systemctl enable mongod.service
systemctl start mongod.service
rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
cat>/etc/yum.repos.d/elasticsearch.repo<EOF
[elasticsearch-5.x]
name=Elasticsearch repository for 5.x packages
baseurl=https://artifacts.elastic.co/packages/5.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
EOF
yum install elasticsearch
vim /etc/elasticsearch/elasticsearch.yml
cluster.name: graylog
systemctl enable elasticsearch.service
systemctl restart elasticsearch.service

rpm -Uvh https://packages.graylog2.org/repo/packages/graylog-2.4-repository_latest.rpm
yum install graylog-server
yum install -y pwgen
pwgen -N 1 -s 96
echo -n admin | sha256sum
vim /etc/graylog/server/server.conf
password_secret = WPtR8CI1TohZqvV0Co8elMugzkHLUS5fyEBLRTIKJC4kt0IYXGb4cNE1iQLImHXay94StebMesPT7Vd7gxKzg7nuWMvjwJ5r
root_password_sha2 = 5ee0333e2563c2f26787082ff20785bd717e07bb26b78dd3f4839a69e04c3662
root_timezone = Asia/Shanghai

systemctl start graylog-server.service
systemctl enable graylog-server.service

yum install -y nginx
cat>/etc/nginx/conf.d/graylog.conf<EOF
server
{
        listen 80;
        server_name xxxx;

        location /
        {
            proxy_set_header    X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header    Host $http_host;
            proxy_set_header    X-Graylog-Server-URL http://xxx/api;
            proxy_pass          http://127.0.0.1:9000;
        }
}
EOF
nginx -t
systemctl enable nginx
systemctl start nginx

排错：
cd /var/log/graylog-server/
tail -f server.log 
tail -f /var/log/nginx/*
```

## GrayLog日常管理
### [使用agent收集log](http://docs.graylog.org/en/latest/pages/collector_sidecar.html#backends)
[agent下载](https://github.com/Graylog2/collector-sidecar/releases)

``` bash
Beats backend

# wget https://github.com/Graylog2/collector-sidecar/releases/download/0.1.4/collector-sidecar-0.1.4-1.x86_64.rpm
# rpm -ivh collector-sidecar-0.1.4-1.x86_64.rpm
# rpm -ql collector-sidecar-0.1.4-1
/etc/graylog/collector-sidecar/collector_sidecar.yml        # 主配置文件
/etc/graylog/collector-sidecar/generated                    # 子配置文件路径/etc/graylog/collector-sidecar/generated/filebeat.yml
/usr/bin/filebeat                                           # 二进制
/usr/bin/graylog-collector-sidecar                          # 二进制执行文件
/var/log/graylog/collector-sidecar                          # 日志路径
/var/run/graylog/collector-sidecar                          # 空目录
/var/spool/collector-sidecar/nxlog                          # 空目录      
# graylog-collector-sidecar -service install               
# systemctl start collector-sidecar
# systemctl enable collector-sidecar   
# curl -u madongsheng:xxx --head 127.0.0.1:9000/api/system/
HTTP/1.1 200 OK
X-Graylog-Node-ID: c2442555-b465-4c88-95e7-2a0d68a1305c
X-Runtime-Microseconds: 271411
Content-Length: 391
Content-Type: application/json
Date: Wed, 09 May 2018 09:13:11 GMT

# logger -t graylog-ubuntu -n 10.1.16.124 -P 12201 "11111"   # Syslog UDP 测试方式

# Application GELF UDP 测试方式
# echo -n '{ "version": "1.1", "host": "example.org", "short_message": "A short message", "level": 5, "_some_info": "foo" }' | nc -w 5 -u 10.1.16.124 12201
参考资料：http://docs.graylog.org/en/2.4/pages/gelf.html

```
## 目录迁移
```
1、停止服务 
停止graylog 	systemctl stop graylog-server.service
停止ES  		/etc/init.d/elasticsearch stop

2、修改配置 迁移数据
默认路径：/var/lib/elasticsearch/
vim /etc/elasticsearch/elasticsearch.yml

path.data: /data0/elasticsearch/data/
path.logs: /data0/elasticsearch/logs/ 
mkdir -p /data0/elasticsearch/{data,logs}
chown -R elasticsearch.elasticsearch /data0/elasticsearch

mv /var/lib/elasticsearch/nodes /data0/elasticsearch/data/
mv /var/log/elasticsearch/* /data0/elasticsearch/logs/ 
cd /var/lib/ && ln -s /data0/elasticsearch/data  elasticsearch

3、启动服务
/etc/init.d/elasticsearch start
/etc/init.d/elasticsearch status 
systemctl start graylog-server.service
systemctl status graylog-server.service

4、测试
查询30天之前log
```
## 参考资料
