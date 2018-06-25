# 免费SSL证书
https://certbot.eff.org

# 免费SSL证书优缺点
- 优点
  - 免费

- 缺点
  - 大规模使用复杂 过期管理


```
yum -y install yum-utils
yum-config-manager --enable rhui-REGION-rhel-server-extras rhui-REGION-rhel-server-optional
yum install python2-certbot-nginx
certbot --nginx

certbot --nginx certonly

cos-cdn.xxx.cn

certbot -d nas.dev.xx.cn --manual --preferred-challenges dns certonly -m xxx@gmail.com
根据提示添加域名text记录

cd /etc/letsencrypt/live/
for i in `ls|grep -v txt`;do cat $i/*.pem>$i.txt;done

添加定时更新证书
0 0,12 * * * python -c 'import random; import time; time.sleep(random.random() * 3600)' && certbot renew
```
# 工具
- https://github.com/Neilpang/acme.sh
- https://github.com/geerlingguy/ansible-role-certbot
