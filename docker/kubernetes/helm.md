https://helm.sh/

- Chart：Helm应用（package），包括该应用的所有Kubernetes manifest模版，类似于YUM RPM或Apt dpkg文件
- Repository：Helm package存储仓库
- Release：chart的部署实例，每个chart可以部署一个或多个release

Helm包括两个部分，helm客户端和tiller服务端


```
wget https://storage.googleapis.com/kubernetes-helm/helm-v2.10.0-linux-amd64.tar.gz
tar -zxf helm-v2.10.0-linux-amd64.tar.gz
cd linux-amd64/
install helm /usr/bin/

helm init --upgrade -i registry.cn-hangzhou.aliyuncs.com/google_containers/tiller:v2.10.0 --stable-repo-url https://kubernetes.oss-cn-hangzhou.aliyuncs.com/charts

保证helm客户端，tiller服务器端版本一致性

helm version
helm search
helm repo update
helm list
helm lint mysql

kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'

# helm install stable/mariadb
NAME:   iron-woodpecker
LAST DEPLOYED: Wed Sep  5 15:22:46 2018
NAMESPACE: default
STATUS: DEPLOYED

RESOURCES:
==> v1/Secret
NAME                     TYPE    DATA  AGE
iron-woodpecker-mariadb  Opaque  2     1s

==> v1/ConfigMap
NAME                           DATA  AGE
iron-woodpecker-mariadb        1     1s
iron-woodpecker-mariadb-tests  1     1s

==> v1/PersistentVolumeClaim
NAME                     STATUS   VOLUME  CAPACITY  ACCESS MODES  STORAGECLASS  AGE
iron-woodpecker-mariadb  Pending  1s

==> v1/Service
NAME                     TYPE       CLUSTER-IP     EXTERNAL-IP  PORT(S)   AGE
iron-woodpecker-mariadb  ClusterIP  10.105.216.11  <none>       3306/TCP  1s

==> v1beta1/Deployment
NAME                     DESIRED  CURRENT  UP-TO-DATE  AVAILABLE  AGE
iron-woodpecker-mariadb  1        1        1           0          1s

==> v1/Pod(related)
NAME                                     READY  STATUS   RESTARTS  AGE
iron-woodpecker-mariadb-bb87c4b95-mkn69  0/1    Pending  0         0s


NOTES:
MariaDB can be accessed via port 3306 on the following DNS name from within your cluster:
iron-woodpecker-mariadb.default.svc.cluster.local

To get the root password run:

    MARIADB_ROOT_PASSWORD=$(kubectl get secret --namespace default iron-woodpecker-mariadb -o jsonpath="{.data.mariadb-root-password}" | base64 --decode)

To connect to your database:

1. Run a pod that you can use as a client:

    kubectl run iron-woodpecker-mariadb-client --rm --tty -i --env MARIADB_ROOT_PASSWORD=$MARIADB_ROOT_PASSWORD --image bitnami/mariadb --command -- bash

2. Connect using the mysql cli, then provide your password:
    mysql -h iron-woodpecker-mariadb -p$MARIADB_ROOT_PASSWORD

```

```
1、Error: could not find a ready tiller pod
tiller还未分配可用的pods

2、Error: incompatible versions client[v2.10.0] server[v2.5.1]
版本不一致

```
