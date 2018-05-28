# KVM总结
# KVM概述
- 官网：http://www.linux-kvm.org/page/Main_Page
- 官网文档：http://www.linux-kvm.org/page/Documents

# KVM部署
- [CentOS 7.x](http://linux.dell.com/files/whitepapers/KVM_Virtualization_in_RHEL_7_Made_Easy.pdf)
## Windows 10 安装
``` bash
qemu-img create -f raw /data0/kvm/win10-kvm.raw 50G
qemu-img info /data0/kvm/win10-kvm.raw
virt-install --name window10 --ram 8192 --cdrom=/data0/cn_windows_10_business_editions_version_1803_updated_march_2018_x64_dvd_12063730.iso --boot cdrom --cpu core2duo --network bridge=br0,model='e1000' --graphics vnc,listen=0.0.0.0 --disk path=/data0/kvm/win10-kvm.raw,bus='ide' --noautoconsole --os-type=windows
```
报错1：ERROR    Host does not support domain type kvm for virtualization type 'hvm' arch 'x86_64'
> 去掉--virt-type kvm 参数

报错2：WARNING  KVM acceleration not available, using 'qemu'
> 检查系统BIOS设置，开启CPU虚拟化设置

## CentOS 7.x 安装
# FQA
# 参考资料
