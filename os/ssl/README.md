# 免费SSL证书
https://certbot.eff.org

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
for i in `ls`;do cat $i/*.pem>$i.txt;done
```
