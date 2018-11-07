## Load Order and Semantics 加载顺序和语义
.tf或.tf.json后缀结尾，按照字母顺序加载指定目录中的所有配置文件
## Configuration Syntax 配置语法
HCL语法格式
- # : 单行注释
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
## Outputs
## Local Values
## Modules
## Terraform
## Terraform Push (deprecated)
## Environment Variables
