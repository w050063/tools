# SaltStack
## SaltStack概述
- 官网地址: https://saltstack.com/
- 官网文档: https://docs.saltstack.com/en/latest/

## SaltStack部署实践
- master
``` bash
ansible-playbook install_saltstack_server.yml -i ../hosts.salt -l salt-master
```

- minion
``` bash
ansible-playbook install_saltstack_server.yml -i ../hosts.salt -l salt-minion
```

# FQA
# 参考资料
