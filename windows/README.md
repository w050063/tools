# windows相关技能
## bat
- 利用bat增删改查注册表信息
  ``` bat
  # cat nas.reg         # 修改指定注册表键值信息
  Windows Registry Editor Version 5.00

  [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters]
  "EnablePlainTextPassword"=dword:00000001
  ```
- 获取系统MAC地址做mac地址绑定或者限速等等
``` bat 
# cat getinfo.bat
ipconfig /all  >> getinfo.txt

# cat getinfo.sh  # macos or linux
ifconfig >> getinfo.txt
```
## powershell
## windows下常用工具
## 参考资料
