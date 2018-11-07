# Terraform概述

Terraform是IT 基础架构自动化编排工具，它的口号是 "Write,Plan, and create Infrastructure as Code", 基础架构即代码。

怎么理解这句话，我们先假设在没有Terraform的年代我们是怎么操作云服务。

方式一：直接登入到云平台的管控页面，人工点击按钮、键盘敲入输入参数的方式来操作，这种方式对于单个或几个云服务器还可以维护的过来，但是当云服务规模达到几十几百甚至上千以后，明显这种方式对于人力来说变得不再现实，而且容易误操作。

方式二：云平台提供了各种SDK，将对云服务的操作拆解成一个个的API供使用厂商通过代码来调用。这种方式明显好于方式一，使大批量操作变得可能，而且代码测试通过后可以避免人为误操作。但是随之带来的问题是厂商们需要专业的开发人员（Java、Python、Php、Ruby等），而且对复杂云平台的操作需要写大量的代码。

方式三：云平台提供了命令行操作云服务的工具，例如AWS CLI，这样租户厂商不再需要软件开发人员就可以实现对平台的命令操作。命令就像Sql一样，使用增删改查等操作元素来管理云。

方式四：Terraform主角登场，如果说方式三中CLI是命令式操作，需要明确的告知云服务本次操作是查询、新增、修改、还是删除，那么Terraform就是目的式操作，在本地维护了一份云服务状态的模板，模板编排成什么样子的，云服务就是什么样子的。对比方式三的优势是我们只需要专注于编排结果即可，不需要关心用什么命令去操作。

Terraform的意义在于，通过同一套规则和命令来操作不同的云平台（包括私有云）。

官网地址：https://www.terraform.io/
模块仓库地址：https://registry.terraform.io/
# Terraform知识准备

核心文件有2个，一个是编排文件，一个是状态文件

main.tf文件：是业务编排的主文件，定制了一系列的编排规则，后面会有详细介绍。

terraform.tfstate：本地状态文件，相当于本地的云服务状态的备份，会影响terraform的执行计划。

如果本地状态与云服务状态不一样时会怎样？

这个大家不需要担心，前面介绍过Terraform是目的式的编排，会按照预设结果完成编排并最终同步更新本地文件。

Provider：Terraform定制的一套接口，跟OpenStack里Dirver、Java里Interface的概念是一样的，阿里云、AWS、私有云等如果想接入进来被Terraform编排和管理就要实现一套Provider，而这些实现对于Terraform的顶层使用者来说是无感知的。

# 应用场景
- 创建基础设施
  可以对基础设施进行编码，利用代码来进行资源的增删查改
- 扩容和部署

# Terraform安装
官方安装指南：https://www.terraform.io/intro/getting-started/install.html
官网文档：https://www.terraform.io/docs/index.html
```
git clone http://github.com/mds1455975151/tools.git
cd tools/ansible/playbook
ansible-playbook install_terraform.yml -l localhost
```
# 参考资料
- https://github.com/ramitsurana/terraform-ansible-setup
- https://ramitsurana.github.io/terraform-ansible-setup/
- [google cloud](https://www.terraform.io/docs/providers/google/index.html)
- [tencentcloud](https://www.terraform.io/docs/providers/tencentcloud/index.html)
- alicloud
  - https://www.terraform.io/docs/providers/alicloud/index.html
  - https://github.com/alibaba/terraform-provider/tree/master/examples
  - https://github.com/alibaba/packer-provider
- [Terraform/Ansible on Cloud--基础设施和应用管理实践](https://yq.aliyun.com/articles/118719)
- https://github.com/shuaibiyy/awesome-terraform
- https://github.com/wardviaene/terraform-course
- https://www.cnblogs.com/hackcrack/tag/terraform/
