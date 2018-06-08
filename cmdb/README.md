# CMDB
- 数据库存储-MySQL
- API接口-Go
- 远程管理-Ansible
- 其他Redis、Python

# 公有云管理平台
- CDN管理
- 域名管理
- 云服务器管理
- 费用管理
- 权限管理系统
- 人员系统
## 一期规划
- 1、技术选型后端：go+mysql 前端：bootstrap
- 2、设计表结构、存储数据、go实现API供用户使用

- 命令行库：github.com/spf13/cobra
``` bash
go get -v github.com/spf13/cobra/cobra
cobra.exe init demo 基于$GOPATH路径下开始
```
- 读取各类配置文件：github.com/spf13/viper
- 依赖管理：github.com/kardianos/govendor
``` bash
go get github.com/kardianos/govendor
cd $GOPATH/src/github.com/mds1455975151/cmdb
govendor init
govendor list
govendor.exe fetch github.com/sirupsen/logrus  
```
- 记录log：https://github.com/sirupsen/logrus
``` bash
go get -u github.com/sirupsen/logrus
import github.com/sirupsen/logrus
logo='我是要被记录的log信息'
logrue.Info(logo)
```
# 参考资料
- https://github.com/evcloud/evcloud_server
- https://github.com/linqian123/wisdom-mattress
