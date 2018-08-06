``` shell
# minikube -h
# minikube start --vm-driver=none
# minikube dashboard --url
http://10.1.16.152:30000
# minikube status
minikube: Running
cluster: Running
kubectl: Correctly Configured: pointing to minikube-vm at 10.1.16.152
# minikube addons list
- addon-manager: enabled
- coredns: disabled
- dashboard: enabled
- default-storageclass: enabled
- efk: disabled
- freshpod: disabled
- heapster: disabled
- ingress: disabled
- kube-dns: enabled
- metrics-server: disabled
- nvidia-driver-installer: disabled
- nvidia-gpu-device-plugin: disabled
- registry: disabled
- registry-creds: disabled
- storage-provisioner: enabled

# kubectl get pods --all-namespaces
NAMESPACE     NAME                                    READY     STATUS    RESTARTS   AGE
kube-system   etcd-minikube                           1/1       Running   0          18m
kube-system   kube-addon-manager-minikube             1/1       Running   0          19m
kube-system   kube-apiserver-minikube                 1/1       Running   1          20m
kube-system   kube-controller-manager-minikube        1/1       Running   1          19m
kube-system   kube-dns-86f4d74b45-w268m               3/3       Running   0          19m
kube-system   kube-proxy-wk49c                        1/1       Running   0          19m
kube-system   kube-scheduler-minikube                 1/1       Running   0          20m
kube-system   kubernetes-dashboard-5498ccf677-zvhtn   1/1       Running   0          19m
kube-system   storage-provisioner                     1/1       Running   0          19m
# minikube addons enable heapster; minikube addons enable ingress
heapster was successfully enabled
ingress was successfully enabled

# kubectl run nginx --image nginx --port 80
deployment.apps "nginx" created
# # kubectl expose deployment nginx --type NodePort --port 80
service "nginx" exposed
# minikube service nginx --url
http://10.1.16.152:30272

docker pull nginx
docker pull registry
docker pull hyper/docker-registry-web
docker pull chadmoon/socat:latest
docker pull jenkins
docker pull chadmoon/jenkins-docker-kubectl

```
参考资料：
- https://kubernetes.io/docs/tutorials/#ci-cd-pipeline
- https://github.com/kenzanlabs/kubernetes-ci-cd
