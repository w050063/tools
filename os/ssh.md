# SSH相关
## SSH密钥
```
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/loveserver-deploy
```
## SSH密钥生成
## SSH密钥分发
## 其他常用技能
- ~/.ssh/config管理
  
  - [onfig管理工具manssh](https://github.com/xwjdsh/manssh)
  
  - [~/.ssh/config.d/*方式](https://superuser.com/questions/247564/is-there-a-way-for-one-ssh-config-file-to-include-another-one?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa)
  - 通过ssh反向隧道及nginx反向代理实现外网控制内网
    - https://blog.csdn.net/fg607/article/details/52123833
    - https://www.cnblogs.com/makefile/p/5410722.html
    - 案例：ssh -fN -R 1.1.1.1:50000:2.2.2.2:80 root@1.1.1.1 -p 22  （1.1.1.1公网IP，2.2.2.2内外IP） 
    
## 安卓手机连接服务器
- juicessh
## 测试ssh连接质量
- https://github.com/spook/sshping
## 参考资料
- https://github.com/StreisandEffect/streisand
