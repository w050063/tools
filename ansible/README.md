##

### 简介
编写的一套基于云的持续集成基础架构的脚本(基于CentOS 7.x系统)。

### 准备工作：密钥
- ~/.ssh/keys/hibernate-keys-aws.pem

### Ansible Install
- sh ansible_install.sh

### Ansible Playbook
- ansible-playbook -i hosts site.yml
- ansible-playbook -i hosts site.yml --limit remote
- ansible-playbook -i hosts site.yml --limit remote --list-hosts
- ansible-playbook -i hosts site.yml --limit remote --tags "generate-script"
