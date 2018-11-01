# 什么是资源
基础设施和服务统称为资源，如私有网络、子网、物理机、虚拟机、镜像、专线、NAT网关等等都可以称之为资源。

Terraform把资源大致分为两类：
- resource
```
resource "资源类名" "映射到本地的唯一资源名" {
  参数 = 值
  ...
}
```
这类资源一般是抽象的真正的云服务资源，支持增删改，如私有网络、NAT网关、虚拟机实例

- data source
```
data "资源类名" "映射到本地的唯一资源名" {
  参数 = 值
  ...
}
```
这类资源一般是固定的一些可读资源，如可用区列表、镜像列表。大部分情况下，resource资源也会封装一个data source方法，用于资源查询


```

mkdir gcloud      # 创建项目目录
terraform init    # 安装依赖各个公有云sdk等
terraform plan    # 预览计划
terraform graph   # 生成执行计划图
terraform apply   # 真正执行编排
terraform show    # 展示现在状态
terraform destroy # 销毁云服务，将tf中的云服务清理干净
terraform graph | dot -Tsvg > graph.svg     # graph命令结合graphviz工具生成资源执行计划图

# Input Variables
定义变量
variable "access_key" {}
variable "secret_key" {}
variable "region" {
  default = "us-east-1"
}

变量引用
provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

变量传递赋值
命令行传递
$ terraform apply \
  -var 'access_key=foo' \
  -var 'secret_key=bar'

读取文件内容传递
$ cat terraform.tfvars
access_key = "foo"
secret_key = "bar"
$ terraform apply \
  -var-file="secret.tfvars" \
  -var-file="production.tfvars"

数据结构
list
maps

# Output Variables

# modules

# 工作目录中文件命名
provider.tf                 -- provider 配置
terraform.tfvars            -- 配置 provider 要用到的变量
varable.tf                  -- 通用变量
resource.tf                 -- 资源定义
data.tf                     -- 包文件定义
output.tf                   -- 输出
```
# to-do-list
- terraform-inventory
