> 官网文档地址：https://www.packer.io/docs/index.html

# Installing Packer
# Terminology 术语
- artifacts
  单个构建的结果，通常是一组ID或文件来表示机器images。每个构建器都会生成一个工件。例如，对于Amazon EC2构建器，工件时一组AMI ID。对于VMware构建器，工件时包含已创建虚拟机的文件目录

- builds
  是一项单一任务，最终为单个平台生成images。多个构建并行运行。句子中的用法示例：packer构建生成了一个AMI来运行我们的web应用程序。或者packer现在正在为VMware，AWS或VirtualBox运行构建。

- builders
  是Packer组件，能够为单个平台创建机器images。构建器读取一些配置并使用它来运行和生成机器images。构建器作为构建的一部分被调用，以便创建实际的结果images。示例构建器包括VMware，AWS或VirtualBox。可以以插件的形式创建构建器并将其添加到Packer。

- Commands
  是Packer执行某项工作的程序的子命令。示例命令是build，它被调用为packer build。packer附带一组开箱即用的命令，以便定义其命令行界面。

- post-Processors
    Packer的组件，它获取构建器或其他后处理器的结果，并处理该组件以创建新工件。后处理器的示例是压缩以压缩工件，上传到上载工件等。

- Provisioners
  Packer的组件是在该机器被转换为静态映像之前在正在运行的机器中安装和配置软件的组件。他们执行使图像包含有用软件的主要工作。示例配置文件包括shell脚本，Chef，Puppet等。

- Templates
  是JSON文件，它通过配置Packer的各种组件来定义一个或多个构建。Packer能够读取模板并使用该信息并行创建多个机器映像。
# Commands (CLI)
```
# /usr/local/terraform/bin/packer -h                 
Usage: packer [--version] [--help] <command> [<args>]

Available commands are:
    build       build image(s) from template
    fix         fixes templates from old versions of packer
    inspect     see components of a template
    validate    check that a template is valid
    version     Prints the Packer version
```
# Templates 模板
模板是JSON文件，用于配置Packer的各种组件以创建一个或多个机器映像。模板是可移植的，静态的，并且可由人和计算机读写。这样做的另一个好处是，不仅可以手动创建和修改模板，还可以编写脚本来动态创建或修改模板。

模板被赋予命令，例如packer build，它将获取模板并实际运行其中的构建，从而生成任何结果的机器图像。

## 模板结构
- builders
- description
- min_packer_version
- post-processors
- provisioners
- variables
# Builders
- Alicloud ECS
- Amazon EC2
- Azure
- Docker
- File
- Google Cloud
....
-
# Provisioners
- Ansible Local
- Ansible Remote
- Chef Client
- Chef Solo
- Converge
- File
- PowerShell
- Puppet Masterless
- Puppet Server
- Salt Masterless
- Shell
- Shell (Local)
- Windows Shell
- Windows Restart
- Custom

# Post-Processors
- Alicloud Import
- Amazon Import
- Artifice
- Compress
- Checksum
- Docker Import
- Docker Push
- Docker Save
- Docker Tag
- Google Compute Export
- Google Compute Import
- Manifest
- Shell (Local)
- Vagrant
- Vagrant Cloud
- vSphere
- vSphere Template

# Extending Packer 扩展
## Plugins
## Custom Builders
## Custom Post-Processors
## Custom Provisioners

# Environment Variables

# Core Configuration
# Debugging
