# 常用命令列表
``` text
<H3C>                           # 默认进入用户视图
sysname device_names            # 为设备命名为device_names
display current-configuration   # 显示当前配置
system-view                     # 进入系统视图模式(配置视图)
undo shutdown                   # 启用以太网端口
shutdown                        # 关闭以太网端口
quit                            # 退出当前视图模式
display ip routing-table        # 显示当前路由表
reset saved-configuration       # 恢复出厂配置，并重启
reboot                          # 重启
save                            # 保存当前配置
display this                    # 查看接口配置
display interface Virtual-PPP 0 # 查看端口状态

sys
dis ip routing-table 114.114.114.114
dis cur | incl route
undo ip route-static 0.0.0.0 0 GigabitEthernet0/2 192.168.28.254
dis cur | incl route
dis cur | incl dns
dis int brie
dis cur int g 0/0
dis cur int g 0/1
int g 0/1
dis this
undo bandwidth
dis this
ping 10.1.15.1
dis ip routing-table 8.8.8.8

dis arp
tracert -a 10.1.16.1 114.114.114.114
dis int brie
interface GigabitEthernet0/2
dis this
undo bandwidth
dns server 10.0.84.54

acl ad 3000
dis this
rule 100 permit ip source 10.1.16.0 0.0.0.255
dis this
int g 0/2
dis this
nat outbound 3000
dis this

sys
dis cpu-usage
dis memory
sys
sysname nmcrouter-new
dis this
dis int brie
dis cur int g 0/3
acl ad 3001
dis this
rule 100 permit ip source 10.1.16.201 0
dis this
policy-based-route 1 node 10
if-match acl 3001
dis this
dis cur | incl 219.141.227.1
apply next-hop 111.207.242.97
dis this
quit

dis int brie
int g 0/0
dis this
ip policy-based-route 1
dis this
quit
save
system-view
acl advanced 3001
display this
rule 121 permit ip source 10.1.16.206 0
rule 120 permit ip source 10.1.16.9 0
display this
save


排错问题大招
通过命令查看一下l2tpvpn的建立过程，并将整个回话过程记录一下,看下建立过程,和整个认证过程.然后把这些信息收集一下提交给产品线分析一下.
<h3c>T m
<h3c>T d
<h3c>debugging l2tp all
<h3c>debugging ppp all
```
# FQA
- 客户端MSR3620-DP-Winet服务器端群晖L2TP服务
PC-NAS L2TP
741认证方式 NAS指定使用PAP认证 只能使用MS-CHAP-V2

window 10主机一般都支持三种 (网卡--属性--安全--允许协议-选择未加密的密码PAP方式)
- PAP 未加密的密码(一般默认不选择，需要选择)
- CHAP 质询握手身份验证协议
- MS-CHAP V2 Microsoft CHAP版本2

691用户密码错误    
群晖相关配置
```
/usr/syno/etc/packages/VPNCenter/
/var/packages/VPNCenter/target/sbin/vpnauthd -t
/usr/sbin/xl2tpd -c /usr/syno/etc/packages/VPNCenter/l2tp/xl2tpd.conf -p /var/run/xl2tpd.pid
cat /usr/syno/etc/packages/VPNCenter/l2tp/options.xl2tpd

https://forum.huawei.com/enterprise/en/thread-411139-1-1.html
display interface Virtual-PPP 0

require-mschap-v2
refuse-mschap
refuse-chap
refuse-pap
```
# 配置内容
## VLAN
## SNMP
监控相关
## 端口
- 聚合
- 限速
- 启动\停止
# 参考资料
- 轻轻松松配置产品案例链接：
- 轻轻松松配交换：https://zhiliao.h3c.com/topic/huati/1246
- 轻轻松松配上网（路由）：https://zhiliao.h3c.com/topic/huati/1247
- 轻轻松松配安全：https://zhiliao.h3c.com/topic/huati/1248
- 轻轻松松配无线：https://zhiliao.h3c.com/topic/huati/1249
