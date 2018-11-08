# 概述
企业级持续交付，快速、安全可重复的部署。

- 官网地址：https://www.spinnaker.io/
- GitHub地址：https://github.com/spinnaker/spinnaker
- 官网文档：https://www.spinnaker.io/guides/
- 概念：https://www.spinnaker.io/concepts/

Spinnaker是Netflix的开源项目，是一个持续交付平台，它定位于将产品快速且持续的部署到多种云平台上。Spinnaker通过将发布和各个云平台解耦，来将部署流程流水线化，从而降低平台迁移或多云品台部署应用的复杂度，它本身内部支持 Google、AWS EC2、Microsoft Azure、Kubernetes和 OpenStack 等云平台，并且它可以无缝集成其他持续集成（CI）流程，如 git、Jenkins、Travis CI、Docker registry、cron 调度器等。简而言之，Spinnaker 是致力于提供在多种平台上实现开箱即用的集群管理和部署功能的平台。

Spinnaker提供两个核心功能：
- 应用管理
- 应用部署

## 应用管理 Application management
- Application 应用
- Cluster 集群
- Server Group 服务组
- Load Balancer 负载均衡
- Firewall

## 应用部署 Application deployment
- Pipeline 管道
- Stage 阶段
- Deployment strategies 部署策略



Cassandra 是非关系型数据库存储
Packer 是开源的支持多平台创建镜像工具
https://www.packer.io/
