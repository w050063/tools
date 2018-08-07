# VMware Station使用记录
- 设置网卡
- 制作模板
  - 两块网卡，两块硬盘
  - 服务器基本初始化
- 设置VMware开机自启动并同时启动指定虚拟机


# FQA
- 设置VMware开机启动并同时启动指定虚拟机

右键VMware Workstation快捷方式查看属性，在目标中直接添加【空格】-x【空格】"D:\vmhost\openvpn\openvpn.vmx"

目标中完整内容为:
```
"C:\Program Files (x86)\VMware\VMware Workstation\vmware.exe -x "D:\vmhost\openvpn\openvpn.vmx"
```

最后剪切移动快捷方式到windows开机启动路径: C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup

另外讲下参数含义：
- -x 启动虚拟机
- -X 启动虚拟机并全屏
- -n 开启新窗口
