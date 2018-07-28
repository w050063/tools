# GrayLog知识总结
## GrayLog概述
## Graylog性能压测
- jmeter

## GrayLog安装部署
- ansible
```
cd /etc/ansible/playbook/
ansible-playbook host-init-test.yml -l 10.1.16.154
ansible-playbook install_graylog_cluster.yml -l 10.1.16.152

添加es+graylog节点
ansible-playbook install_graylog_add_node.yml -l 10.1.16.153
检查关键配置
is_master = false
mongodb_uri = mongodb://10.1.16.152/graylog
elasticsearch_hosts = http://10.1.16.152:9200,http://10.1.16.153:9200

自动化部署及管理技巧
curl -XGET http://admin:admin@10.1.16.155/system/inputs --silent   判断节点是否启动
创建inputs
# create syslog tcp input on port 10514
curl -XPOST http://admin:admin@10.1.16.155/system/inputs -d @/tmp/create_input.json --header "Content-Type: application/json"

```
部署参考资料：
- [官网推荐ansible-galaxy install Graylog2.graylog-ansible-role](#)
- [https://github.com/m-kraus/graylog-cluster](https://github.com/m-kraus/graylog-cluster)

## Graylog集群管理
- MongoDB副本集
- Elasticsearch集群
- graylog多节点
  - [验证过程](https://github.com/mds1455975151/tools/blob/master/log/graylog/docs/add_new_node_to_graylog_cluster.md)
- redis logstash缓存层
- 各服务监控
  - elasticsearch http://www.elastichq.org/

## 配置流程
system/inputs-选择类型GELF UDP|Syslog UDP|Beats|其他-->launch new input新建补充信息
分别新建三个inputs
- Application GELF UDP(GELF UDP) 收集游戏客户端汇报日志  12201
- System Log(Syslog UDP) 系统级别log  2514
- beats-input(Beats) agent收集input 5044

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

## FQA
### tools
```
wget https://raw.githubusercontent.com/mds1455975151/tools/master/log/graylog/graylog_tools.sh
```
## 导出导入配置system\Content packs配置
在配置中添加默认加载
http://docs.graylog.org/en/2.4/pages/configuration/server.conf.html?highlight=Content%20packs
别人共享的配置信息
http://docs.graylog.org/en/2.4/pages/marketplace.html?highlight=Content%20packs
说明
http://docs.graylog.org/en/2.4/pages/sending_data.html?highlight=Content%20packs

### graylog 蓝绿部署思路
-  ~~两个负载均衡，用于指向后端两个graylog集群~~
- ~~配置两个graylog集群的安全组，开放对应日志收集端口(注意区分：TCP,UDP)~~
- ~~自定义插件/usr/share/graylog-server/plugin/graylog-plugin-splunk-0.6.3.jar，集成到部署脚本，保证部署环境一致性~~
- 自定义配置(system\Content packs)

	- ~~input配置(要点：输出日志时使用域名地址，保证切换域名解析即可指向不同的graylog集群)~~
		- Application GELF HTTP
		- Application GELF UDP
		- System Log  /etc/rsyslog.d/90-graylog.conf
		- beats-input /etc/graylog/collector-sidecar/collector_sidecar.yml
	- stream配置
		- All messages
		- Love BI 
		- System Log
		- TLog
	- outputs配置
	- Dashboards配置
- ldap用户配置(存储在MongoDB中,研究如何快速导出导入配置)
- 索引配置(存储在MongoDB中,研究如何快速导出导入配置)
- web界面其他自定义配置(存储在MongoDB中,研究如何快速导出导入配置)

### 常见错误
```
- Uncommited messages deleted from journal (triggered 15 days ago)
Some messages were deleted from the Graylog journal before they could be written to Elasticsearch. Please verify that your Elasticsearch cluster is healthy and fast enough. You may also want to review your Graylog journal settings and set a higher limit. (Node: c2442555-b465-4c88-95e7-2a0d68a1305c)
- Journal utilization is too high (triggered 15 days ago)
Journal utilization is too high and may go over the limit soon. Please verify that your Elasticsearch cluster is healthy and fast enough. You may also want to review your Graylog journal settings and set a higher limit. (Node: c2442555-b465-4c88-95e7-2a0d68a1305c)
```

#message_journal_max_age = 12h
#message_journal_max_size = 5gb

## 参考资料
BeanShell （JAVA源码解释器）

## FQA
- ~~快速部署上线~~
- 服务及性能监控
- 数据备份还原
- 报警
