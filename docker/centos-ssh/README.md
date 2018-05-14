``` bash
git clone https://github.com/mds1455975151/tools.git
cd tools/docker/centos-ssh
docker build . -t centos-ssh:7.2

docker rm $(docker ps -a -q) 

docker run -d -it -p 20021:22 --name os-01 centos-ssh:7.2 /bin/bash
ssh -p 22 172.17.0.2
```
