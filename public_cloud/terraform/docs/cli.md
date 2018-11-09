# 概述
命令行功能讲解
```
/usr/local/terraform/bin/terraform -h   
Usage: terraform [-version] [-help] <command> [args]

The available commands for execution are listed below.
The most common, useful commands are shown first, followed by
less common or more advanced commands. If you're just getting
started with Terraform, stick with the common commands. For the
other commands, please read the help and docs before usage.

Common commands:
   apply              Builds or changes infrastructure
   console            Interactive console for Terraform interpolations
   destroy            Destroy Terraform-managed infrastructure
   env                Workspace management
   fmt                Rewrites config files to canonical format
   get                Download and install modules for the configuration
   graph              Create a visual graph of Terraform resources
   import             Import existing infrastructure into Terraform
   init               Initialize a Terraform working directory
   output             Read an output from a state file
   plan               Generate and show an execution plan
   providers          Prints a tree of the providers used in the configuration
   push               Upload this Terraform module to Atlas to run
   refresh            Update local state file against real resources
   show               Inspect Terraform state or plan
   taint              Manually mark a resource for recreation
   untaint            Manually unmark a resource as tainted
   validate           Validates the Terraform files
   version            Prints the Terraform version
   workspace          Workspace management

All other commands:
   debug              Debug output management (experimental)
   force-unlock       Manually unlock the terraform state
   state              Advanced state management
```
设置命令行补全
```
# cat ~/.bashrc
terraform -install-autocomplete
```
# 常用命令总结
```
mkdir gcloud              # 创建项目目录
terraform init            # 安装依赖各个公有云sdk等
terraform plan            # 预览计划
terraform graph           # 生成执行计划图
terraform apply           # 真正执行编排
terraform show            # 展示现在状态
terraform destroy         # 销毁云服务，将tf中的云服务清理干净
terraform graph | dot -Tsvg > graph.svg     # graph命令结合graphviz工具生成资源执行计划图
terraform apply -var "machine_type=n1-standard-1" -var "image=centos-7"   # 指定变量值
terraform apply -var "machine_type=n1-standard-1" -var "image=ubuntu1604-lts"   # 指定变量值

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
$ terraform apply -var 'access_key=foo' -var 'secret_key=bar'

读取文件内容传递
$ cat terraform.tfvars
access_key = "foo"
secret_key = "bar"
$ terraform apply -var-file="secret.tfvars" -var-file="production.tfvars"

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
