# Try it out 试试看
演示/评估安装
## Amazon Web Services
## Google Cloud Launcher
## Microsoft Azure
## Kubernetes Helm Chart
# Set up Spinnaker 设置Spinnaker
Overview 概述
- 一台安装Halyard的机器
  本地计算机或VM(Ubuntu 14.04/16.04，Debian或macOS)，也可以是Docker容器
- 一个Kubernetes机器，可以在其上安装Spinnaker

## 1. Install Halyard
通过两种方式安装Halyard:
- 本地在Debian/Ubuntu或macOS上
- 在Docker

```
# terraform apply -var "machine_type=n1-standard-1" -var "image=ubuntu-minimal-1604-lts"


# curl -O https://raw.githubusercontent.com/spinnaker/halyard/master/install/debian/InstallHalyard.sh
# sudo bash InstallHalyard.sh
# hal -v
1.12.0-20181024113436
# . ~/.bashrc
# sudo update-halyard  # 更新Halyard

卸载
# hal deploy clean               # 清理部署Spinnaker
# sudo ~/.hal/uninstall.sh       # 安全卸载Halyard
```
## 2. Choose Cloud Providers 选择供应商
以Google Compute Engine为例
- 获取GCP服务account
- 安装gcloud，如果使用google vm，默认就已经安装完毕

```
# gcloud info
# hal config provider google enable
# hal config provider google account add xxx --project xxx --json-path xxx.json
```
## 3. Choose an Environment
告诉Halyard安装Spinnaker的环境类型

```
hal config deploy edit --type localdebian
```
## 4. Choose a Storage Service
以Google Cloud Storage为例
```
hal config storage gcs edit --project xxx --bucket-location asia --json-path xxx.json
hal config storage edit --type gcs
```
## 5. Deploy and Connect 部署Spinnaker并连接到UI
```
hal version list
hal config version edit --version 1.10.2
sudo hal deploy apply
sudo hal deploy connect

修改监听IP地址，默认都是监听127.0.0.1
$ vim ~/.hal/default/service-settings/deck.yml
port: 9000
address: 0.0.0.0
host: 0.0.0.0
baseUrl: http://35.220.204.146:9000
# sudo hal deploy apply
# sudo systemctl daemon-reload
# sudo systemctl restart spinnaker.service

测试：
http://35.220.204.146:9000
默认没有web界面没有认证，需要做安全策略
```
## 6. Back Up Your Config
```
hal backup create
```
Spinnaker Config FAQ
# Configure Everything Else 配置其他所需内容
Overview
Configure Artifact Support
Configure the Image Bakery
Secure Spinnaker
Set up Triggers
Add Your CI system
Enable Monitoring
Set up canary support
Additional Features
Productionize Spinnaker
# Productionize Spinnaker Spinnaker生产
