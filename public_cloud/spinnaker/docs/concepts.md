# concepts 概念
## Overview 概述
  Spinnaker是一个开源的多云持续交付平台，可以帮助您以高速度和自信度发布软件更新。

Spinnaker提供两组核心功能：
- application management 应用管理
- application deployment 应用部署

### 应用管理
可以使用Spinnaker的应用程序管理功能来查看和管理您的云资源。

应用程序，集群和服务器组是Spinnaker用于描述服务的关键概念。负载均衡和防火墙描述了您的服务如何向用户开放。
- 应用
- 集群
- 服务器组
- 负载均衡器
- 防火墙

### 应用部署
可以使用Spinnaker的应用程序部署功能来构建和管理持续交付工作流程。
- 管道
- 阶段
- 部署策略
  - 蓝绿部署
  - 滚动部署
  - 摘樱桃部署
## Clusters 集群
Spinnaker可以作为单一管理窗口，管理跨多个云的全局部署。在这里，会显示云运行环境的运行状况和状态相关的信息，以及有关部署和单个实例的元数据。

还可以对看到的资源执行临时操作，例如调整大小、克隆、禁用和回滚。


## Pipelines 管道
管道是以一致、可重复和安全的方式管理部署的方式。管道是Spinnaker提供的一系列阶段，包括操作基础架构(部署、调整大小、禁用)的功能以及实现程序脚手架功能(手动判断、等待、运行jenkins jobs),它们共同精确定义管理部署的Runbook。


## Providers 供应商
在Spinnaker中，供应商是Spinnaker可控制的一组虚拟资源的接口。通常，这是一个IaaS提供商，如AWS或GCP，但它也可以是Pass，如App Engine，或容器协调器，如Kubernetes。

### Accounts
各云厂商提供的API管理凭证

### Supported providers
- App Engine
- Amazon Web Services
- Azure
- DC/OS
- Docker v2 Registry (Note: This only acts as a source of images, and does not include support for deploying Docker images)
- Google Compute Engine
- Kubernetes
- Openstack
- Oracle
