# jmeter知识总结
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
```
### jmeter_slave启动要点
``` bash
server_port=1099
server.rmi.localport=4000
server.rmi.ssl.disable=true
```
## FQA
- [利用badboy进行脚本录制]()
## 应用思路
- 开发jar包工具
- 定义变量
- json转自用项目协议
- 根据项目需要编写.jmx配置

## 参考资料
- http://www.cnblogs.com/imyalost/category/846346.html
