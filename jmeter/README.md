# jmeter知识总结
## jmeter概述
- 官网：https://jmeter.apache.org/index.html
- GitHub地址：https://github.com/apache/jmeter

## jmeter部署安装
``` bash
// Windows环境(依赖 Requires Java 8 or 9)
>java -version
java version "1.8.0_144"
Java(TM) SE Runtime Environment (build 1.8.0_144-b01)
Java HotSpot(TM) Client VM (build 25.144-b01, mixed mode, sharing)
>wget http://ftp.cuhk.edu.hk/pub/packages/apache.org//jmeter/binaries/apache-jmeter-4.0.tgz
// 解压到某个目录就可以使用
> 双击D:\apache-jmeter-4.0\bin\jmeter.bat

Linux下启动jmeter-server
jmeter -n -t baidu.jmx -r -l baidu.jtl

1、将写好的jmx文件放到/root/workspace/jmeter/路径下
2、配置jtest别名
3、启动任务，例如：jtest baidu
4、执行完成会生成jtl文件，并放置到/var/www/html/目录下，可以是其他web服务器的站点路径下
5、通过web页面查看并分析结果

别名设置方法
alias jtestbg='function _jtest(){ nohup jmeter -r -n -t '/root/workspace/jmeter/'$1.jmx -l '/var/www/html/'$1-$(date '+%Y-%m-%d-%H:%M:%S').jtl -e -o '/var/www/html/'$1-$(date '+%Y-%m-%d--%H:%M:%S') & };_jtest'
alias jtest='function _jtest(){ jmeter -r -n -t '/root/workspace/jmeter/'$1.jmx -l '/var/www/html/'$1-$(date '+%Y-%m-%d-%H:%M:%S').jtl -e -o '/var/www/html/'$1-$(date '+%Y-%m-%d--%H:%M:%S') };_jtest'

任务启动方法
# jtest baidu
Creating summariser <summary>
Created the tree successfully using /root/workspace/jmeter/baidu.jmx
Configuring remote engine: 10.0.0.3:3099
Configuring remote engine: 10.0.0.13:3099
Configuring remote engine: 10.0.0.16:3099
Configuring remote engine: 10.0.0.6:3099
Configuring remote engine: 10.0.0.14:3099
Configuring remote engine: 10.0.0.17:3099
Starting remote engines
Starting the test @ Mon May 14 14:15:56 CST 2018 (1526278556872)
Remote engines have been started
Waiting for possible Shutdown/StopTestNow/Heapdump message on port 4445
summary +      7 in 00:00:06 =    1.1/s Avg:    31 Min:    23 Max:    66 Err:     0 (0.00%) Active: 5 Started: 57 Finished: 55
summary +    593 in 00:00:00 = 4297.1/s Avg:    11 Min:     0 Max:    30 Err:   300 (50.59%) Active: 0 Started: 57 Finished: 60
summary =    600 in 00:00:06 =   95.6/s Avg:    12 Min:     0 Max:    66 Err:   300 (50.00%)
Tidying up remote @ Mon May 14 14:16:04 CST 2018 (1526278564163)
... end of run
```
### jmeter_slave启动要点
``` bash
server_port=1099
server.rmi.localport=4000
server.rmi.ssl.disable=true
```
## FQA
- [利用badboy进行脚本录制]()
- jmeter部署架构

  - manager端->slave端(若干)

## 应用思路
- 开发jar包工具
- 定义变量
- json转自用项目协议
- 根据项目需要编写.jmx配置

## 参考资料
- http://www.cnblogs.com/imyalost/category/846346.html
