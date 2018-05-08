# 生产环境考虑要点
## 资源评估
### 服务器硬件配置
- vtgate
- vttablet
- Topology(zookeeper)

### 服务安装部署及配置
- MySQL环境安装，但是不用启动
- env.sh

    - 修改hostname参数为公有云内网IP地址
  
- vtctld-up.sh

    - cell变量，线上环境根据需要进行调整
  
- vttablet-up.sh

    - tablet_hostname 变量修改为公有云内网IP地址
  
    - vtctld_addr变量修改为公有云内网IP地址
  
    > 点击实例的status，进入详情页面显示为内网IP地址，无法正常查看参数需要解决

### 日常管理
- Vitess + RDS
- ~~创建cell~~

    - xxx_develop
    
    - xxx_master
    
    - xxx_publish
    
- 创建vttablet loveworld
- client.sh脚本，通用修改
- vtctld web ui(Dashboard-loveworld-显示1 Not serving如何解决？)

### 故障转移/恢复
### 备份/恢复
### 架构管理/架构交换
### 重新分片/水平重新分片教程
### 升级
### 监控报警
## 参考资料
