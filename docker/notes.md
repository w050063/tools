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
github:https://github.com/prometheus/prometheus
```
docker run --name prometheus -d -p 9090:9090 quay.io/prometheus/prometheus
```

## 
