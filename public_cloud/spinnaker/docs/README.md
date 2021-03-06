# Tutorials
## Videos
## Codelabs
# User How-Tos
# Developer How-Tos
# Operator How-Tos
# Runbooks
# Spin CLI

![](images/01.png)
- Deck：面向用户 UI 界面组件，提供直观简介的操作界面，可视化操作发布部署流程。
- API： 面向调用 API 组件，我们可以不使用提供的 UI，直接调用 API 操作，由它后台帮我们执行发布等任务。
- Gate：是 API 的网关组件，可以理解为代理，所有请求由其代理转发。
- Rosco：是构建 beta 镜像的组件，需要配置 Packer 组件使用。
- Orca：是核心流程引擎组件，用来管理流程。
- Igor：是用来集成其他 CI 系统组件，如 Jenkins 等一个组件。
- Echo：是通知系统组件，发送邮件等信息。
- Front50：是存储管理组件，需要配置 Redis、Cassandra 等组件使用。
- Cloud driver 是它用来适配不同的云平台的组件，比如 Kubernetes，Google、AWS EC2、Microsoft Azure 等。
- Fiat 是鉴权的组件，配置权限管理，支持 OAuth、SAML、LDAP、GitHub teams、Azure groups、 Google Groups 等。
