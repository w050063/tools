### to-do-list
- ~~部署及相关文档资料~~
- ~~短信费用监测及续费管理~~
- ~~数据备份及监控~~
- ~~endpoint规范~~
- ~~安装脚本agent启动问题（严重）利用ansible解决~~
    > ansible all -m shell -a 'cd /usr/local/open-falcon && nohup ./open-falcon start agent'

- 新项目监控需求管理
- 日常需求管理（redis\MySQL\新服务器基础监控等等监控需求）
- 出现报警如何快速关闭短信接口或者屏蔽告警服务器，防止短信轰炸
- 各类监控模板编写：
  - 服务器基础监控
  - 服务监控规范
    - httpd
    - nginx
    - php
    - [MySQL](https://github.com/open-falcon/mymon)
    - redis
    - openldap
    - gitlab
    - .....
- ~~自动添加监控Screen(常用监控项简化查看方式)~~
- Open-Falcon自监控 添加各个服务的端口 及falcon-task tycs-anteye
- Open-Falcon邮件报警信息修改
  邮件最后附带报警地址修改/data0/open-falcon/alarm/config-->api-->dashboard地址，然后重启
- ~~ansible-playbook安装openfalcon~~
- 监控规模评估，选择部署模式（单机\集群）
- ~~服务器申请，服务规划~~
- ~~plugins功能~~
- 服务部署(异常关机服务启动 open-falcon\MySQL\Redis\)
- URL
- 自监控tycs-anteye
- task模块
- Nodata配置用于监控agent alive检查，如果无汇报数据自动补其他数据，用于监控报警
- screen
  xxx公司监控-xxx业务名称-xxx子业务名称-xxx主机
- https://github.com/sdvdxl/falcon-logdog
- 编写自定义监控项模板\思路(python\go)
  - [fastdfs](https://github.com/zzlyzq/openfalcon-agent-fastdfs)
  - [rabbitmq](https://github.com/barryz/rabbitmq-monitor)
- [Linux默认监控项](https://github.com/open-falcon/book/blob/master/en_0_2/faq/linux-metrics.md)
- 自定义监控
  - 文件系统只读
  - ~~SSL证书过期时间~~
- API
- ~~集群监控aggregator功能~~
- 点击hostname跳转到http://IP:1998页面
- dashboard如何更新
- ~~利用snmp监控交换机或者路由器~~
```
git clone https://github.com/open-falcon/dashboard.git
cd dashboard
zip -r dashboard.zip rrd screenshots scripts
上传更新到到对应目录下，解压、重启服务
```
- 服务器端组件如何更新？
```
1、配置go环境
2、编译打包最新代码
cd $GOPATH/src/github.com/open-falcon/falcon-plus/
make all             # make all modules
make pack            # pack all modules
3、备份原代码目录
cp -rf open-falcon open-falcon.20180808
cp open-falcon-v0.2.1.tar.gz open-falcon
cd open-falcon
for i in `find . -type f -name cfg.json`;do cp ${i}{,.bak};done
4、更新代码并重启服务
tar -zxf open-falcon-v0.2.1.tar.gz
for i in `find . -type f -name cfg.json`;do \cp ${i}.bak $i;done
sh start.sh stop
sh start.sh start
sh start.sh check
5、研发服务正常与否
```


### 相关资源
- [增强open-falcon提供的alarm模块对邮件模板的支持](https://github.com/mircoteam/mailtemplate)
- [微信企业号发送监控 for OpenFalcon](https://github.com/Yanjunhui/chat)
- [falcon-monit-scripts](https://github.com/iambocai/falcon-monit-scripts)
