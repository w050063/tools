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


- 获取所有主机 /api/v1/hosts            GET
- 新增一个主机 /api/v1/hosts/id         POST
- 删除一个主机 /api/v1/hosts/id         DELETE
- 修改一个主机 /api/v1/hosts/id         PUT
- 获取一个主机 /api/v1/hosts/id         GET
- 条件过来主机 /api/v1/hosts?a1=1&a2=2  GET

- 1、返回资产信息
- 2、返回所有IP列表 安全扫描，漏洞检测
