# etcd总结
## etcd概述
- 官网地址：https://coreos.com/etcd/
- GitHub地址：https://github.com/coreos/etcd/
- 最新官网文档：https://coreos.com/etcd/docs/latest/v2/README.html

## etcd安装部署
### 单机YUM安装
``` bash
wget https://raw.githubusercontent.com/mds1455975151/tools/master/etcd/install_etcd.sh
sh install_etcd.sh
```
### 多机器集群YUM部署安装
- 安装
  ``` bash
  git clone https://github.com/mds1455975151/tools.git
  vim tools/ansible/hosts.etcd  # 修改集群配置信息
  cd tools/ansible/playbook
  ansible-playbook -i ../hosts.etcd install_etcd.yml -l etcd
  ```
- 卸载
  ``` bash
  cd tools/ansible/playbook
  ansible-playbook -i ../hosts.etcd uninstall_etcd.yml -l etcd
  ```

### 单机集群YUM安装
略

## 日常管理
## 参考资料
