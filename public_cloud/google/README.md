# 概述
官网地址：https://cloud.google.com/

有免费试用12个月政策(12个月时间$300用于消费)
# 服务列表
截止到2018.11.07日目前共有7大类，30+个产品/服务


## 计算
### Compute Engine
- 计算实例没有重装功能
- 重启IP不会变化
- Google Cloud VM的Disk可以在线动态的进行大小的调整(待实践)
- 案例：使用MongoDB构建待办事项应用
https://github.com/GoogleCloudPlatform/todomvc-mongodb.git

### Kubernetes Engine
- 教程案例：使用Redis和PHP创建留言板
https://github.com/kubernetes/examples
1、设置 Redis 主实例
2、设置 Redis 工作器
3、设置留言板网络前端
4、访问留言板网站
5、扩展留言板网络前端

## 存储
## 网络
### Cloud CDN
### Cloud DNS
### Cloud Load Balancing
### Cloud Virtual Network
## 工具
## 大数据
## 人工智能

# to-do-list
- ~~账号注册体验$300美元体验~~
- [ansible and google](ansible.md)
- Google Cloud Platform using Terraform



# FQA
- google Cloud shell使用
```
gcloud compute --project "axiomatic-port-221011" ssh --zone <backend-zone> <backend-name>
所有操作都是sudo执行


google api 管理实例

```
BBR
魔改BBR
