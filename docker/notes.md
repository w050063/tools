# 利用docker快速部署测试环境
## 监控报警
- Nagios
```
docker run -e NAGIOSADMIN_USER=nagiosadmin -e NAGIOSADMIN_PASS=nagios -p 80:30000 cpuguy83/nagios
访问宿主机 http://{IP}:8080  账号：nagiosadmin 密码：nagios
```

- Ganglia
```
docker run -p 0.0.0.0:80:80 wookietreiber/ganglia
访问：http://192.168.200.105/ganglia/
```

- scope(docker容器监控)
```
https://github.com/weaveworks/scope
sudo curl -L git.io/scope -o /usr/local/bin/scope
sudo chmod a+x /usr/local/bin/scope
scope launch
http://192.168.200.115:4040/
```

- cadvisor(docker容器监控)
  - 官网:https://hub.docker.com/r/google/cadvisor/
  - github:https://github.com/google/cadvisor
```
docker run \
  --volume=/:/rootfs:ro \
  --volume=/var/run:/var/run:rw \
  --volume=/sys:/sys:ro \
  --volume=/var/lib/docker/:/var/lib/docker:ro \
  --publish=8080:8080 \
  --detach=true \
  --name=cadvisor \
  google/cadvisor:latest
```
- prometheus
  - github:https://github.com/prometheus/prometheus
```
docker run --name prometheus -d -p 9090:9090 quay.io/prometheus/prometheus
```

## Web类
- Nginx
```
docker run -d -p 9090:80 nginx:1.12.1 --name nginx-01
```

## OS系统
```
docker run -d -it -p 20022:22 centos6.9 /bin/bash --name os-01
docker run -d -it -p 20021:22 --name os-01 centos:7.2.1511 /bin/bash
```

## 源码管理
- GitLab
  - 官网文档：https://docs.gitlab.com/omnibus/docker/
```
docker run --detach \
    --hostname linux-node5.example.com \
	--env GITLAB_OMNIBUS_CONFIG="external_url 'http://192.168.200.115/'; gitlab_rails['gitlab_shell_ssh_port'] = 2289;" \
    --publish 443:443 --publish 80:80 --publish 2289:2289 \
    --name gitlab \
    --restart always \
    --volume /srv/gitlab/config:/etc/gitlab \
    --volume /srv/gitlab/logs:/var/log/gitlab \
    --volume /srv/gitlab/data:/var/opt/gitlab \
    gitlab/gitlab-ce:latest
	
docker exec -it gitlab /bin/bash
docker exec -it gitlab vi /etc/gitlab/gitlab.rb
docker restart gitlab
docker logs gitlab
```
或者直接使用docker-compose.yml启动

访问链接：http://192.168.200.115/ 第一次登录要求设置密码,账号默认root

- Gogs
```
docker run --name=gogs -p 10022:22 -p 3000:3000 -v /var/gogs:/data gogs/gogs
grant all privileges on *.* to 'gogs1'@'172.17.0.4' identified by password '*6BB4837EB74329105EE4568DDA7DC67ED2CA2AD9';
flush privileges;
```
  - MySQL: 192.168.200.105 root 123456
  - 仓库路径：/data/git/gogs-repositories
  - 日志路径：/app/gogs/log

## 持续集成CI/CD
- Jenkins
  - 官网文档：https://github.com/jenkinsci/docker/blob/master/README.md
  - docker hub地址：https://hub.docker.com/r/jenkins/jenkins/
```
docker run -p 8080:8080 -p 50000:50000 --name jenkins jenkins/jenkins:lts
docker exec -it jenkins cat /var/jenkins_home/secrets/initialAdminPassword
```
