# Ansible 重点常用内容总结
## Ansible Playbook
### 错误处理
- 忽略错误继续执行
``` yml
- name: this will not be counted as a failure
  command: /bin/false
  ignore_errors: yes
```


# 自定义模块
```
# ansible aliyun-test -M /root -m os_info.py              
120.79.190.110 | SUCCESS => {
    "BackupIp": "grep: /etc/keepalived/*: No such file or directory",
    "Disk_Total": {
        "Disk_Usage": "6%",
        "Inode_Usage": "2%",
        "Swap_Free": "awk: cmd. line:1: (FILENAME=- FNR=1) fatal: division by zero attempted"
    },
    "HostClass": "",
    "HostName": "test-01",
    "In_Ipaddress": "192.168.1.133",
    "Name": "2018-10-29 16:20:09",
    "Out_Ipaddress": "163.177.76.147",
    "Program_Data": [],
    "Route": "192.168.1.253",
    "Rsync_State": "Source",
    "Runing_Online_Num": "0",
    "Sys_Id": "168",
    "changed": false
}

-M: 指定模块存储目录
-m: 指定模块名称
```
