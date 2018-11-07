> https://www.terraform.io/docs/state/index.html

Terraform必须存储有关基础架构和配置的状态。Terraform使用此状态将现实世界资源映射到您的配置，跟踪元数据并提高大型基础架构的性能。

默认情况下，此状态存储在名为terraform.tfstate的本地文件中，但也可以远程存储，这在团队环境中更有效。

Terraform使用此本地状态来创建计划并对您的基础架构进行更改。在任何操作之前，Terraform会刷新使用真实基础架构更新状态。

**检查和修改**
状态文件格式是json，但不鼓励对状态进行直接文件编辑。

# Purpose 目的

# Import Existing Resources 导入现有的资源
# Locking 锁定
# Workspaces 工作区
每个Terraform配置都有一个关联的后端，用于定义操作的执行方式以及存储Terraform状态文件的持久性数据的位置。

以下是后端目前支持的工作区：
- AzureRM
- Consul
- GCS
- Local
- Manta
- S3
# Remote State
# Sensitive Data
