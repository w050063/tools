# 概述
Packer是Hashicorp的命令行工具，用于为多个平台和环境快速创建相同的机器映像。 使用Packer，您可以使用称为模板的配置文件创建包含预配置操作系统和软件的计算机映像。 然后，您可以使用此映像创建新计算机。 您甚至可以使用单个模板来编排您的生产，暂存和开发环境的同时创建。

- Packer官网：https://www.packer.io/
- 官网文档地址：https://www.packer.io/intro/index.html
- https://www.packer.io/docs/builders/index.html

## 案例
### file模块
```
# cat 1.json
{
"builders": [
  {
    "type": "file",
    "content": "ubuntu",
    "target": "dummy_artifact"
  }
]
}

# ./packer build 1.json  
file output will be in this color.

Build 'file' finished.

==> Builds finished. The artifacts of successful builds are:
--> file: Stored file: dummy_artifact
```
### google模块
```
# cat google.json
{
  "builders": [
    {
      "type": "googlecompute",
      "account_file": "account.json",
      "project_id": "xxx",
      "source_image": "debian-7-wheezy-v20150127",
      "ssh_username": "packer",
      "zone": "us-central1-a"
    }
  ]
}

# ./packer build google.json
googlecompute output will be in this color.

==> googlecompute: Checking image does not exist...
==> googlecompute: Creating temporary SSH key for instance...
==> googlecompute: Using image: debian-7-wheezy-v20150127
==> googlecompute: Creating instance...
    googlecompute: Loading zone: us-central1-a
    googlecompute: Loading machine type: n1-standard-1
    googlecompute: Requesting instance creation...
    googlecompute: Waiting for creation operation to complete...
    googlecompute: Instance has been created!
==> googlecompute: Waiting for the instance to become running...
    googlecompute: IP: 35.202.237.72
==> googlecompute: Using ssh communicator to connect: 35.202.237.72
==> googlecompute: Waiting for SSH to become available...
==> googlecompute: Connected to SSH!
==> googlecompute: Deleting instance...


    googlecompute: Instance has been deleted!
==> googlecompute: Creating image...
==> googlecompute: Deleting disk...
    googlecompute: Disk has been deleted!
Build 'googlecompute' finished.

==> Builds finished. The artifacts of successful builds are:
--> googlecompute: A disk image was created: packer-1541417917
You have new mail.
```
#  cat dummy_artifact
ubuntu#
# to-do-list

# 参考资料
- [巧用Terraform和Packer开源工具完成云上自动运维](https://yq.aliyun.com/articles/74435)
- [玩转云镜像制作之packer篇](https://yq.aliyun.com/articles/72724)
- [Packer创建阿里云本地镜像](https://yq.aliyun.com/articles/72218)
- [实战Packer创建chef server镜像](https://yq.aliyun.com/articles/72043)
- https://github.com/alibaba/packer-provider/tree/master/examples/alicloud
