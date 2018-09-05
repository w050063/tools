##

### 简介
编写的一套基于云的持续集成基础架构的脚本(基于CentOS 7.x系统)。

### 准备工作：密钥
- ~/.ssh/keys/hibernate-keys-aws.pem
> 注意：修改key权限为600
### Ansible Install
- sh ansible_install.sh

### Ansible Playbook
- ansible-playbook -i hosts site.yml --check
- ansible-playbook -i hosts site.yml
- ansible-playbook -i hosts site.yml --limit remote
- ansible-playbook -i hosts site.yml --limit remote --list-hosts
- ansible-playbook -i hosts site.yml --list-tags
- ansible-playbook -i hosts site.yml --limit remote --tags "generate-script"

### ansible-galaxy
- ansible-galaxy install username.rolename
```
# vim /etc/ansible/ansible.cfg
roles_path    = /etc/ansible/roles
```
### 声明
### Ansible CMDB
- [ansible-cmdb](https://github.com/fboender/ansible-cmdb)
### FQA
**环境变量问题**
- ansible这类远程执行的non-login shell 并不会加载/etc/profile和~/.bash_profile下的环境变量，只是加载~/.bashrc和/etc/bashrc
- 如果需要在ansible中执行需要特定环境变量的命令，可以在执行前source一下~/.bash_profile， 或者将环境变量写在~/.bashrc

参考资料：https://blog.csdn.net/u010871982/article/details/78525367

**模块**
- set_fact(oracle_java)
### Ansible管理Mac OS
### Ansible管理Windows
### Ansible管理MySQL
- ~~账号管理~~
```
pip install six --upgrade --ignore-installed six
[Powershell Script Cannot Be Loaded Because Running Scripts Is Disabled On This System](http://heresjaken.com/running-scripts-disabled-system/)

192.168.1.4 | UNREACHABLE! => {
    "changed": false,
    "msg": "ssl: [Errno 1] _ssl.c:492: error:14090086:SSL routines:SSL3_GET_SERVER_CERTIFICATE:certificate verify failed",
    "unreachable": true
}
ansible_winrm_server_cert_validation=ignore

```

### ansible-pull

### 参考
- https://github.com/manala/ansible-roles
- https://github.com/kuailemy123/Ansible-roles
- https://github.com/arbabnazar/ansible-roles
- https://github.com/contiv/ansible
- https://github.com/adithyakhamithkar/ansible-playbooks
- https://github.com/sfromm/ansible-playbooks
- https://github.com/ansible/ansible-examples
- https://github.com/kbrebanov
- [基于Ansible的自动化代码发布工具](https://github.com/geekwolf/flamingo)
- [Ansible官网文档中文本地化](https://github.com/stanleylst/ansible-tran)
