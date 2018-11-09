## Load Order and Semantics 加载顺序和语义
.tf或.tf.json后缀结尾，按照字母顺序加载指定目录中的所有配置文件
## Configuration Syntax 配置语法
HCL语法格式
- \# : 单行注释
- /* 注释内容 * / 多行注释

## Interpolation Syntax 插值语法
- string
- map
- list
- own resource
- 表达式
- 内置功能
  - 读取文件  ${file("path.txt")}
- templates
- math计算

## Overrides 覆盖
有效覆盖文件的例子是override.tf， override.tf.json，temp_override.tf。
## Resources 资源

## Data Sources
## Providers
## Variables
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


## Outputs
## Local Values
## Modules
## Terraform
## Terraform Push (deprecated)
## Environment Variables
