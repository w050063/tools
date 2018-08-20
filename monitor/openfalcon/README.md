### to-do-list
- 监控规模评估，选择部署模式（单机\集群）
- ~~服务器申请，服务规划~~
- ~~plugins功能~~
- 服务部署(异常关机服务启动 open-falcon\MySQL\Redis\)
- 各类监控模板编写：
  - 服务器基础监控
  - 服务监控（MySQL\Nginx）
- ~~endpoint规范~~
- URL
- 自监控tycs-anteye
- task模块
- Nodata配置用于监控agent alive检查，如果无汇报数据自动补其他数据，用于监控报警
- 应用健康
  - Redis
  - [MySQL](https://github.com/open-falcon/mymon)
- screen
  xxx公司监控
  xxx业务名称
  xxx子业务名称
  xxx主机
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
