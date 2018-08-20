# 操作系统安装及初始化规范
> v1.0

## 操作系统安装流程

1. 服务器采购
2. 服务器验收并设置raid
3. 服务商提供验收单，运维验收负责人签字
4. 服务器上架
5. 资产录入
6. 开始自动化安装:
				
        1. 将新服务器划入vlan
		2. 根据资产清单上的mac地址，自定义安装
			1. 机房
			2. 机房区域
			3. 机柜
			4. 服务器位置
			5. 服务器网线接入端口
			6. 该端口mac地址
			7. profile、操作系统、分区、与分配ip地址、主机名、子网、dns、角色
		3. 自动化装机平台安装
			ip：10.0.0.9
			主机名：linux-node3
			掩码：255.255.255.0
			网关：10.0.0.2
			dns：10.0.0.2

	<pre>
    cobbler system add --name=linux-node3 --mac=00:50:56:2C:52:D3 --profile=CentOS-7-X86_64 \
    --ip-address=10.0.0.9 --subnet=255.255.255.0 --gateway=10.0.0.2 --interface=eth0 \
    --static=1 --hostname=linux-node3 --name-servers="10.0.0.2" \
    --kickstart=/var/lib/cobbler/kickstarts/CentOS-7-x86_64.cfg 
    </pre>
		
## 操作系统安装规范
 
1. 当前我公司使用操作系统为CentOS7和CentOS6，均使用x86_64位系统，需要使用cobbler进行自动化安装，禁止自定义设置。
2. 版本选择，数据库统一使用Cobbler上CentOS-7-DB这个专用的profile，其他web应用统一使用Cobbler上CentOS-7-web。 


## 系统初始化规范



### 初始化操作

* 设置DNS 10.0.0.2 10.0.0.9
* 安装Zabbix Agent:  Zabbix server:10.0.0.7
* 安装Saltstack Minion: Saltstack Master: 10.0.0.7
* history记录时间

     <pre>
  export HISTTIMEFORMAT="%F %T `whoami`:"
     </pre>
* 日志记录操作
    <pre>
   export PROMPT_COMMAND='{ msg=$(history 1 | { read x y; echo $y; });logger "[euid=$(whoami)]":$(who am i):[`pwd`]"$msg"; }'
   </pre> 

* 内核参数优化
* yum仓库
* 主机名解析
### 目录规范

* 脚本放置目录：/opt/shell
* 脚本日志目录：/opt/shell/log
* 脚本锁文件目录：/opt/shell/lock

### 服务安装规范

1. 源码安装路径/usr/local/appname.version
2. 创建软连接ln -s /usr/local/appname.version /usr/local/appname

### 主机名命名规范

**机房名称-项目-角色-集群-节点-.域名**

例子：

	idc01-xxshop-api-nginx-bj-node1.shop.com

### 服务启动用户规范

所有服务，统一使用www,uid为666，除负载均衡需要监听80端口使用root启动外，所有服务必须使用www用户启动，使用大于1024的端口。


