# getting-started 入门
## Contents 内容
  本节说明如何在Kubernetes上运行Vitess。它还提供了使用Google Container Engine启动Kubernetes集群的步骤。

  如何您已经在其他支出的平台之一运行Kubernetes v1.0+,则可以跳过这些gcloud步骤。这些kubectl步骤将适用于任何Kubernetes集群。
## Prerequisites 先决条件
  要完成本指南中的练习，您必须将etcd-operator安装在您计划运行Vitess的同一命名空间中。

  您还必须在本地安装Go 1.9+,Vitess的vtctlclient工具和kubectl。以下各节介绍如何在您的环境中进行设置。
### Install Go 1.9+
  您需要安装Go 1.9+来构建该vtctlclient工具，该工具向Vitess发布命令。

  安装Go之后，请确保您的GOPATH环境变量设置为工作区的根目录。最常见的设置是，并且该值应该标识非root用户具有写入权限的目录。GOPATH=$HOME/go

  另外，确保包含在你的。有关设置Go工作区的更多信息，请参阅 如何编写Go代码。$GOPATH/bin$PATH
### Build and install vtctlclient 构建并安装vtctlclient
该vtctlclient工具向Vitess发布命令。
> $ go get vitess.io/vitess/go/cmd/vtctlclient

该命令在以下位置下载并构建Vitess源代码：
> $GOPATH/src/vitess.io/vitess/

它还将构建的vtctlclient二进制文件复制到。$GOPATH/bin

### Set up Google Compute Engine, Container Engine, and Cloud tools 设置Google Compute Engine，容器引擎和云工具
**注意：** 如果您在其他地方运行Kubernetes，请跳至 找到kubectl。
要使用Google Compute Engine（GCE）在Kubernetes上运行Vitess，您必须拥有启用了结算功能的GCE帐户。以下说明介绍了如何启用结算以及如何将结算帐户与Google Developers Console中的项目相关联。
- 登录Google Developers Console以启用结算。
  - 如果您不在那里，请点击结算窗格。
  - 点击新的结算帐户。
  - 为结算帐户指定一个名称 - 例如“Kubernetes上的Vitess”。然后点击继续。您可以注册免费试用 以避免任何费用。
- 在Google Developers Console中使用您的结算帐户创建一个项目：
  - 在Google Developers Console的顶部，点击项目下拉菜单。
  - 点击创建项目...链接。
  - 为您的项目分配一个名称。然后点击创建按钮。您的项目应该创建并与您的结算帐户相关联。（如果您有多个结算帐户，请确认该项目与正确的帐户相关联。）
  - 创建项目后，点击左侧菜单中的API Manager。
  - 查找Google Compute Engine和Google Container Engine API。（两者都应在“Google Cloud API”下列出。）对于每一个，点击它，然后点击“启用API”按钮。
- 按照Google Cloud SDK快速入门说明设置和测试Google Cloud SDK。您还将在完成快速入门时设置您的默认项目ID。

**注意：** 如果您因为之前设置了Google Cloud SDK而忽略了快速入门指南，请确保通过运行以下命令来设置默认项目ID。替换PROJECT为分配给您的Google Developers Console 项目的项目ID 。您可以 通过导航到控制台中项目的Overview页面来查找ID。
> $ gcloud config set project PROJECT

安装或更新kubectl工具：
> $ gcloud components update kubectl

### Locate kubectl 找到kubectl
检查是否kubectl在你的PATH：
``` bash
$ which kubectl
### example output:
# ~/google-cloud-sdk/bin/kubectl
```

如果kubectl不在您的位置PATH，您可以通过设置KUBECTL环境变量来告诉我们的脚本在哪里找到它：
> $ export KUBECTL=/example/path/to/google-cloud-sdk/bin/kubectl

## Start a Container Engine cluster 启动一个容器引擎集群
**注意：** 如果您在其他地方运行Kubernetes，请跳到 启动Vitess集群。
设置 您的安装将使用的区域：
> $ gcloud config set compute/zone us-central1-b

创建一个容器引擎集群：
``` bash
$ gcloud container clusters create example --machine-type n1-standard-4 --num-nodes 5 --scopes storage-rw
### example output:
# Creating cluster example...done.
# Created [https://container.googleapis.com/v1/projects/vitess/zones/us-central1-b/clusters/example].
# kubeconfig entry generated for example.
```
**注意：** 该参数对于允许内置备份/还原 访问Google Cloud Storage是必需的 。--scopes storage-rw
创建一个云存储存储桶：
要将Cloud Storage插件用于内置备份，请首先 为Vitess备份数据创建一个 存储桶。 如果您不熟悉云存储，请参阅 存储桶命名指南。
``` bash
$ gsutil mb gs://my-backup-bucket
```

## Start a Vitess cluster 启动Vitess集群
- 导航到您的本地Vitess源代码
这个目录在安装时会被创建 vtctlclient：
> $ cd $GOPATH/src/vitess.io/vitess/examples/kubernetes

- 配置站点本地设置
运行该脚本以生成一个文件，该文件将用于定制您的群集设置。configure.shconfig.sh
目前，我们有在 Google云端存储中存储备份的开箱即用支持 。如果您使用的是GCS，请填写configure脚本请求的字段，包括上面创建的存储桶的名称。
``` bash
vitess/examples/kubernetes$ ./configure.sh
### example output:
# Backup Storage (file, gcs) [gcs]:
# Google Developers Console Project [my-project]:
# Google Cloud Storage bucket for Vitess backups: my-backup-bucket
# Saving config.sh...
```
对于其他平台，您需要选择file备份存储插件，并将读写网络卷挂载到vttablet和vtctldpod中。例如，您可以将任何通过NFS访问的存储服务挂载到 Kubernetes卷中。然后在此处提供装载路径到配置脚本。
通过实现Vitess BackupStorage插件接口，可以添加对Amazon S3等其他云BLOB存储的直接支持。 如果您有任何特定的插件请求，请在论坛上告诉我们。
- 启动一个etcd集群
Vitess 拓扑服务 存储Vitess集群中所有服务器的协调数据。它可以将这些数据存储在几个一致的存储系统之一中。在这个例子中，我们将使用etcd。请注意，我们需要我们自己的etcd群集，与Kubernetes本身使用的群集分开。我们将使用etcd-operator来管理这些集群。
如果您尚未这样做，请确保 在继续之前将etcd-operator安装在您计划运行Vitess的同一名称空间中。
``` bash
vitess/examples/kubernetes$ ./etcd-up.sh
### example output:
# Creating etcd service for 'global' cell...
# etcdcluster "etcd-global" created
# Creating etcd service for 'global' cell...
# etcdcluster "etcd-test" created
# ...
```
该命令创建两个集群。一个用于 全球小区，另一个用于 称为测试的 本地小区。您可以 通过运行以下命令来检查群集中Pod的状态 ：
``` bash
$ kubectl get pods
### example output:
# NAME                READY     STATUS    RESTARTS   AGE
# etcd-global-0000                1/1       Running   0          1m
# etcd-global-0001                1/1       Running   0          1m
# etcd-global-0002                1/1       Running   0          1m
# etcd-operator-857677187-rvgf5   1/1       Running   0          28m
# etcd-test-0000                  1/1       Running   0          1m
# etcd-test-0001                  1/1       Running   0          1m
# etcd-test-0002                  1/1       Running   0          1m
```
第一次需要它们时，每个Kubernetes节点可能需要一段时间下载Docker镜像。在下载图像时，吊舱状态将处于待定状态。
**注意：** 在此示例中，每个以名称结尾的 脚本还具有相应的脚本，可用于停止Vitess集群的某些组件，而不会关闭整个集群。例如，要拆除部署，请运行：-up.sh-down.shetcd
> vitess/examples/kubernetes$ ./etcd-down.sh

- 启动vtctld
该vtctld服务器提供了一个Web界面来检查Vitess集群的状态。它还接受来自vtctlclient修改群集的RPC命令。
``` bash
vitess/examples/kubernetes$ ./vtctld-up.sh
### example output:
# Creating vtctld ClusterIP service...
# service "vtctld" created
# Creating vtctld replicationcontroller...
# replicationcontroller "vtctld" create createdd
```
- 访问vtctld Web UI
要从Kubernetes外部访问vtctld，请使用kubectl代理 在您的工作站上创建经过身份验证的隧道：
注意：代理命令在前台运行，因此您可能希望在单独的终端中运行它。
``` bash
$ kubectl proxy --port=8001
### example output:
# Starting to serve on localhost:8001
```
然后，您可以在以下位置加载vtctld Web UI localhost：
HTTP：//本地主机：8001 / API / V1 /代理/命名空间/默认/服务/ vtctld：网络/
您还可以使用此代理访问Kubernetes Dashboard，您可以在其中监控节点，Pod和服务：
HTTP：//本地主机：8001 / UI

- 使用vtctlclient将命令发送到vtctld
您现在可以vtctlclient在本地运行以向vtctld您的Kubernetes群集上的服务发出命令。
要启用对Kubernetes集群的RPC访问，我们将再次使用 kubectl设置经过验证的隧道。与我们用于Web UI的HTTP代理不同，这次我们需要 vtctld的gRPC端口的原始端口转发。
由于隧道需要针对特定​​的vtctld pod名称，因此我们提供了脚本，该脚本用于发现pod名称并在运行之前设置隧道。kvtctl.shkubectlvtctlclient
现在，运行将测试您的连接 并列出 可用于管理Vitess集群的命令。kvtctl.sh helpvtctldvtctlclient
``` bash
vitess/examples/kubernetes$ ./kvtctl.sh help
### example output:
# Available commands:
#
# Tablets:
#   InitTablet ...
# ...
```
您还可以使用该help命令获取有关每个命令的更多详细信息：
vitess/examples/kubernetes$ ./kvtctl.sh help ListAllTablets
有关输出的Web格式版本，请参阅vtctl参考vtctl help。
- 在拓扑中设置单元
全局etcd集群是根据Kubernetes配置文件中指定的命令行参数配置的。然而，每个单元的etcd集群需要进行配置，因此Vitess可以访问它。以下命令设置它：
> ./kvtctl.sh AddCellInfo --root /test -server_address http://etcd-test-client:2379 test

- 启动vttablets
Vitess 平板电脑是数据库的缩放单位。片剂由以下部分组成 vttablet和mysqld工艺，在同一台主机上运行。我们通过把对vttablet和mysqld的相应的容器一个内强制执行Kubernetes这种耦合 吊舱。
运行以下脚本启动vttablet窗格，其中还包括mysqld：
``` bash
vitess/examples/kubernetes$ ./vttablet-up.sh
### example output:
# Creating test_keyspace.shard-0 pods in cell test...
# Creating pod for tablet test-0000000100...
# pod "vttablet-100" created
# Creating pod for tablet test-0000000101...
# pod "vttablet-101" created
# Creating pod for tablet test-0000000102...
# pod "vttablet-102" created
# Creating pod for tablet test-0000000103...
# pod "vttablet-103" created
# Creating pod for tablet test-0000000104...
# pod "vttablet-104" created
```
在vtctld网络界面，您应该很快就会看到一个 密钥空间命名test_keyspace 与单个碎片命名0。点击分片名称查看平板电脑列表。当所有5个平板电脑出现在分片状态页面上时，您就可以继续。请注意，此时平板电脑很不健康，因为您尚未初始化数据库。
如果在尚未下载Vitess Docker映像的节点上安排Pod，则平板电脑首次出现可能需要一些时间。您还可以使用以下命令从命令行检查平板电脑的状态：kvtctl.sh
``` bash
vitess/examples/kubernetes$ ./kvtctl.sh ListAllTablets test
### example output:
# test-0000000100 test_keyspace 0 spare 10.64.1.6:15002 10.64.1.6:3306 []
# test-0000000101 test_keyspace 0 spare 10.64.2.5:15002 10.64.2.5:3306 []
# test-0000000102 test_keyspace 0 spare 10.64.0.7:15002 10.64.0.7:3306 []
# test-0000000103 test_keyspace 0 spare 10.64.1.7:15002 10.64.1.7:3306 []
# test-0000000104 test_keyspace 0 spare 10.64.2.6:15002 10.64.2.6:3306 []
```
- 初始化MySQL数据库
一旦所有平板电脑出现，您就可以初始化底层的MySQL数据库。
**注意：** 许多vtctlclient命令在成功时不产生输出。
首先，指定其中一个平板电脑作为初始主人。Vitess会自动连接其他从属的mysqld实例，以便它们从主设备的mysqld开始复制。这也是在创建默认数据库时。由于我们的密钥空间是命名的test_keyspace，MySQL数据库将被命名vt_test_keyspace。
``` bash
vitess/examples/kubernetes$ ./kvtctl.sh InitShardMaster -force test_keyspace/0 test-0000000100
### example output:
# master-elect tablet test-0000000100 is not the shard master, proceeding anyway as -force was used
# master-elect tablet test-0000000100 is not a master in the shard, proceeding anyway as -force was used
```
**注意：** 由于这是碎片第一次启动，平板电脑尚未进行任何复制，并且没有现有的主设备。InitShardMaster上面的命令使用该标志绕过通常的适用性检查，如果这不是全新的碎片，则适用。-force
平板电脑完成更新后，您应该看到一位主人，以及多个副本和rdonly平板电脑：
``` bash
vitess/examples/kubernetes$ ./kvtctl.sh ListAllTablets test
### example output:
# test-0000000100 test_keyspace 0 master 10.64.1.6:15002 10.64.1.6:3306 []
# test-0000000101 test_keyspace 0 replica 10.64.2.5:15002 10.64.2.5:3306 []
# test-0000000102 test_keyspace 0 replica 10.64.0.7:15002 10.64.0.7:3306 []
# test-0000000103 test_keyspace 0 rdonly 10.64.1.7:15002 10.64.1.7:3306 []
# test-0000000104 test_keyspace 0 rdonly 10.64.2.6:15002 10.64.2.6:3306 []
```
该副本片剂用于服务的实时网络流量，而 RDONLY片用于离线处理，例如批处理作业和备份。 可以在脚本中配置您启动的每种平板电脑类型的数量。vttablet-up.sh

- 创建一个表
该vtctlclient工具可用于在键盘空间中的所有平板电脑上应用数据库架构。以下命令创建文件中定义的表格：create_test_table.sql
``` bash
# Make sure to run this from the examples/kubernetes dir, so it finds the file.
vitess/examples/kubernetes$ ./kvtctl.sh ApplySchema -sql "$(cat create_test_table.sql)" test_keyspace
```
下面显示了创建表的SQL：
``` bash
CREATE TABLE messages (
  page BIGINT(20) UNSIGNED,
  time_created_ns BIGINT(20) UNSIGNED,
  message VARCHAR(10000),
  PRIMARY KEY (page, time_created_ns)
) ENGINE=InnoDB
```
您可以运行此命令来确认模式是否在给定平板电脑上正确创建，其中 是平板别名，如命令所示：test-0000000100ListAllTablets
``` bash
vitess/examples/kubernetes$ ./kvtctl.sh GetSchema test-0000000100
### example output:
# {
#   "DatabaseSchema": "CREATE DATABASE `` /*!40100 DEFAULT CHARACTER SET utf8 */",
#   "TableDefinitions": [
#     {
#       "Name": "messages",
#       "Schema": "CREATE TABLE `messages` (\n  `page` bigint(20) unsigned NOT NULL DEFAULT '0',\n  `time_created_ns` bigint(20) unsigned NOT NULL DEFAULT '0',\n  `message` varchar(10000) DEFAULT NULL,\n  PRIMARY KEY (`page`,`time_created_ns`)\n) ENGINE=InnoDB DEFAULT CHARSET=utf8",
#       "Columns": [
#         "page",
#         "time_created_ns",
#         "message"
#       ],
# ...
```
- 采取备份
现在应用了初始模式，现在是进行第一次备份的好时机 。此备份将用于自动恢复您运行的任何其他副本，然后将它们连接到主服务器并赶上复制。如果现有的平板电脑出现故障并在没有数据的情况下进行备份，它也会自动从最新的备份中恢复，然后恢复复制。
选择一个rdonly平板电脑并告诉它进行备份。我们使用 rdonly平板电脑而不是副本，因为平板电脑会暂停复制并在数据复制期间停止提供以创建一致的快照。
> vitess/examples/kubernetes$ ./kvtctl.sh Backup test-0000000104

备份完成后，您可以列出碎片的可用备份：
``` bash
vitess/examples/kubernetes$ ./kvtctl.sh ListBackups test_keyspace/0
### example output:
# 2015-10-21.042940.test-0000000104
```
- 初始化Vitess路由架构
在这些例子中，我们只是使用一个没有特定配置的数据库。所以我们只需要使这个（空的）配置可见即可使用。这是通过运行以下命令完成的：
> vitess/examples/kubernetes$ ./kvtctl.sh RebuildVSchemaGraph
（当它工作时，这个命令不会显示任何输出。）

- 启动vtgate
Vitess使用vtgate将每个客户端查询路由到正确的路由vttablet。在Kubernetes中，一项vtgate服务将连接分配到一组vtgate吊舱。这些吊舱由复制控制器进行策划。
``` bash
vitess/examples/kubernetes$ ./vtgate-up.sh
### example output:
# Creating vtgate service in cell test...
# service "vtgate-test" created
# Creating vtgate replicationcontroller in cell test...
# replicationcontroller "vtgate-test" created
```

## Test your cluster with a client app 用客户端应用程序测试您的群集
示例中的GuestBook应用程序从Kubernetes GuestBook示例移植而来 。服务器端代码已被Python重写，以使用Vitess作为存储引擎。客户端代码（HTML / JavaScript）已被修改为支持多个留言页面，这对于在以后的指南中演示Vitess分片很有用。
``` bash
vitess/examples/kubernetes$ ./guestbook-up.sh
### example output:
# Creating guestbook service...
# services "guestbook" created
# Creating guestbook replicationcontroller...
# replicationcontroller "guestbook" created
```
与vtctld服务一样，默认情况下，留言簿应用程序无法从外部访问Kubernetes。在这种情况下，由于这是一个面向用户的前端，因此我们在GuestBook服务定义中设置了该定义，该定义告诉Kubernetes 使用API​​为您的Kubernetes群集所在的任何平台创建公共 负载均衡器。type: LoadBalancer

您还需要允许通过平台的防火墙进行访问。
``` bash
# For example, to open port 80 in the GCE firewall:
$ gcloud compute firewall-rules create guestbook --allow tcp:80
```
注意：为了简单起见，上面的防火墙规则将打开 项目中所有 GCE实例上的端口。在生产系统中，您可能会将其限制到特定的实例。

然后，获取该留言服务的负载均衡器的外部IP：
``` bash
$ kubectl get service guestbook
### example output:
# NAME        CLUSTER-IP      EXTERNAL-IP     PORT(S)   AGE
# guestbook   10.67.242.247   3.4.5.6         80/TCP    1m
```
如果仍然为空，请给它几分钟来创建外部负载平衡器并再次检查。EXTERNAL-IP

运行pod后，应可从负载平衡器的外部IP访问该GuestBook应用程序。在上面的例子中，它会在 。http://3.4.5.6

您可以通过在多个浏览器窗口中打开该应用程序来看到Vitess的复制功能，并使用相同的留言簿页码。每个新条目都被提交给主数据库。与此同时，页面上的JavaScript不断轮询应用程序服务器以检索GuestBook条目列表。该应用程序通过在“副本”模式下查询Vitess来提供只读请求，确认复制正在工作。

您还可以检查应用程序存储的数据：
``` bash
vitess/examples/kubernetes$ ./kvtctl.sh ExecuteFetchAsDba test-0000000100 "SELECT * FROM messages"
### example output:
# +------+---------------------+---------+
# | page |   time_created_ns   | message |
# +------+---------------------+---------+
# |   42 | 1460771336286560000 | Hello   |
# +------+---------------------+---------+
```
该留言板的源代码 提供有关应用服务器如何与Vitess交互的更多细节。

## Try Vitess resharding 尝试Vitess重新粉碎
现在您已经运行了完整的Vitess堆栈，您可能想要继续 阅读Kubernetes工作流指南中的Sharding 或Kubernetes codelab中的Sharding （如果您希望通过命令手动运行每个步骤）来尝试 动态重新分解。
如果是这样，你可以跳过拆除指南，因为拆分指南在这里提取。如果不是，继续下面的清理步骤。
## Tear down and clean up
在停止容器引擎集群之前，您应该拆除Vitess服务。然后Kubernetes将负责清理它为这些服务创建的任何实体，如外部负载均衡器。
``` bash
vitess/examples/kubernetes$ ./guestbook-down.sh
vitess/examples/kubernetes$ ./vtgate-down.sh
vitess/examples/kubernetes$ ./vttablet-down.sh
vitess/examples/kubernetes$ ./vtctld-down.sh
vitess/examples/kubernetes$ ./etcd-down.sh
```
然后拆除容器引擎集群本身，这将停止在Compute Engine上运行的虚拟机：
> $ gcloud container clusters delete example

删除您创建的所有防火墙规则也是一个好主意，除非您计划尽快再次使用它们：
> $ gcloud compute firewall-rules delete guestbook

## Troubleshooting 故障排除
### Server logs 服务器日志
如果pod进入Running状态，但服务器未按预期做出响应，请使用该kubectl logs 命令检查pod输出：
``` bash
# show logs for container 'vttablet' within pod 'vttablet-100'
$ kubectl logs vttablet-100 vttablet

# show logs for container 'mysql' within pod 'vttablet-100'
# Note that this is NOT MySQL error log.
$ kubectl logs vttablet-100 mysql
```
将日志发布到某处并发送链接到Vitess邮件列表 以获得更多帮助。

### Shell access  shell访问
如果你想在一个容器内徘徊，你可以用它来运行一个shell。kubectl exec
例如，要在vttablet容器的容器中 启动一个shell ：vttablet-100
``` bash
$ kubectl exec vttablet-100 -c vttablet -t -i -- bash -il
root@vttablet-100:/# ls /vt/vtdataroot/vt_0000000100
### example output:
# bin-logs   innodb                  my.cnf      relay-logs
# data       memcache.sock764383635  mysql.pid   slow-query.log
# error.log  multi-master.info       mysql.sock  tmp
```
### Root certificates 根证书
如果你在日志中看到这样的消息：
``` bash
x509: failed to load system roots and no roots provided
```
这通常意味着您的Kubernetes节点正在运行一个主机操作系统，该主机操作系统将根证书放在与我们的配置默认情况下预期不同的位置（例如Fedora）。有关 如何为主机操作系统设置正确位置的示例，请参见etcd控制器模板中的注释 。您还需要在vtctld和vttablet模板中调整相同的证书路径设置 。
### Status pages for vttablets vttablets的状态页面
每个服务器vttablet在其主端口上提供一组HTML页面。该vtctld界面为每个平板提供了一个STATUS链接。

如果您通过上述的kubectl代理访问vtctld Web UI，它将自动通过同一个代理链接到vttablets，为您提供从群集外部访问的权限。

您也可以使用代理直接访问平板电脑。例如，要查看带有ID的平板电脑的状态页面100，可以导航到：

HTTP：//本地主机：8001 / API / V1 /代理/命名空间/默认/荚/ vttablet-100：15002 /调试/状态

### Direct connection to mysqld 直接连接到mysqld
由于mysqld该内vttablet舱只是意味着通过vttablet被访问，我们默认的引导程序设置只允许从本地主机连接。

如果你想检查或操作底层的mysqld，你可以通过vtctlclient这样的方式发出简单的查询或命令：
``` bash
# Send a query to tablet 100 in cell 'test'.
vitess/examples/kubernetes$ ./kvtctl.sh ExecuteFetchAsDba test-0000000100 "SELECT VERSION()"
### example output:
# +------------+
# | VERSION()  |
# +------------+
# | 5.7.13-log |
# +------------+
```
如果您需要真正直接连接到mysqld，则可以在mysql容器中启动一个shell，然后连接到mysql 命令行客户端：
``` bash
$ kubectl exec vttablet-100 -c mysql -t -i -- bash -il
root@vttablet-100:/# export TERM=ansi
root@vttablet-100:/# mysql -S /vt/vtdataroot/vt_0000000100/mysql.sock -u vt_dba
```

## Custom Docker Build  自定义Docker构建
略 地址：https://vitess.io/getting-started/docker-build/
## Run Vitess Locally 本地运行Vitess
### Contents  内容
您可以使用Docker或手动构建过程来构建Vitess

如果您还遇到问题或由任何疑问，请在我们的论坛上发帖。
### Docker Build  Docker构建
  在Docker中运行Vitess，您可以在Docker Hub上使用我们预先构建的images,或者自己构建它们。

- Docker Hub Images
  - 该vitess/base镜像包含一个完整的开发环境，能够建立Vitess和运行集成测试。
  - 该vitess/lite镜像只包含已编译的二进制文件Vitess，排除的ZooKeeper。它可以运行Vitess，但缺乏构建Vitess或运行测试所需的环境。它主要用于Kubernetes指南上的Vitess。

例如，您可以直接运行vitess/base，Docker会为您下载映像：
``` bash
$ sudo docker run -ti vitess/base bash
vitess@32f187ef9351:/vt/src/vitess.io/vitess$ make build
```
现在，您可以继续在刚刚启动的Docker容器内启动Vitess集群。请注意，如果您想从容器外部访问服务器，则需要按Docker Engine参考指南中所述公开端口。

对于本地测试，您还可以通过Docker访问为容器创建的本地IP地址上的服务器：
``` bash
$ docker inspect 32f187ef9351 | grep IPAddress
### example output:
#    "IPAddress": "172.17.3.1",
```
- Custom Docker Image 自定义Docker镜像
您还可以自己构建Vitess Docker镜像以包含您自己的修补程序或配置数据。该 Dockerfile 在Vitess树的根构建vitess/base图像。该搬运工 子目录包含用于构建其它图像，如脚本vitess/lite。

我们Makefile还包含构建图像的规则。例如：
``` bash
# Create vitess/bootstrap, which prepares everything up to ./bootstrap.sh
vitess$ make docker_bootstrap
# Create vitess/base from vitess/bootstrap by copying in your local working directory.
vitess$ make docker_base
```
### Manual Build 手动构建
#### Install Dependencies  安装依赖关系

我们目前经常在Ubuntu 14.04（Trusty）和Debian 8（Jessie）上测试Vitess。OS X 10.11（El Capitan）也应该可以工作，安装说明如下。

##### Ubuntu和Debian

另外，Vitess需要下面列出的软件和库。
- 安装Go 1.9+。
- 安装MariaDB 10.0或 MySQL 5.6。您可以使用任何安装方法（src / bin / rpm / deb），但一定要包含客户端开发头文件（libmariadbclient-dev或libmysqlclient-dev）。

  Vitess开发团队目前正在对MariaDB 10.0.21和MySQL 5.6.27进行测试。

  如果您正在安装MariaDB，请注意您必须安装10.0或更高版本。如果您正在使用apt-get，请确认您的存储库提供了安装该版本的选项。您也可以直接从mariadb.org下载源代码。

  如果您在MySQL 5.6中使用Ubuntu 14.04，则默认安装可能会丢失文件/usr/share/mysql/my-default.cnf。它会显示为类似的错误Could not find my-default.cnf。如果遇到这个问题，只需添加以下内容：
  ``` bash
  [mysqld]
  sql_mode=NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES
  ```
- 卸载或禁用AppArmor。某些版本的MySQL带有Vitess工具尚未识别的默认AppArmor配置。当Vitess通过该mysqlctl工具初始化MySQL实例时，这会导致各种权限失败。这只是测试环境的一个问题。如果AppArmor在生产中是必需的，则可以在不通过mysqlctl的情况下适当地配置MySQL实例。
  ``` bash
  $ sudo service apparmor stop
  $ sudo service apparmor teardown
  $ sudo update-rc.d -f apparmor remove
  ```
  重新启动，以确保AppArmor完全禁用。

- 从下面列出的选项中选择一项锁定服务。技术上可以使用另一台锁服务器，但插件目前仅适用于ZooKeeper，etcd和consul。
  - ZooKeeper 3.4.10 is included by default.
  - Install etcd v3.0+. If you use etcd, remember to include the etcd command on your path.
  - Install Consul. If you use consul, remember to include the consul command on your path.

- 安装构建和运行Vitess所需的以下其他工具：
  - make
  - automake
  - libtool
  - python-dev
  - python-virtualenv
  - python-mysqldb
  - libssl-dev
  - g++
  - git
  - pkg-config
  - bison
  - curl
  - unzip
这些可以通过以下apt-get命令来安装：
  ``` bash
  $ sudo apt-get install make automake libtool python-dev python-virtualenv python-mysqldb libssl-dev g++ git pkg-config bison curl unzip
  ```
如果您决定在步骤3中使用ZooKeeper，则还需要安装Java Runtime，如OpenJDK。
  ``` bash
  $ sudo apt-get install openjdk-7-jre
  ```
##### OS X
- 安装Homebrew。如果你的/ usr / local目录不是空的，你以前从未使用过Homebrew，那么 运行以下命令将是 强制性的：
  ``` bash
  sudo chown -R $(whoami):admin /usr/local
  ```
- 在OS X上，必须使用MySQL 5.6，MariaDB由于某种原因而不起作用。它应该从Homebrew安装（安装步骤如下）。

- 如果安装了Xcode（使用控制台工具，自7.1版以来应自动捆绑），则在此步骤中应满足所有开发依赖关系。如果不存在Xcode，则需要安装pkg-config。
  ``` bash
  brew install pkg-config
  ```
- ZooKeeper被用作锁定服务。

- 运行以下命令：
  ``` bash
  brew install go automake libtool python git bison curl wget homebrew/versions/mysql56
  pip install --upgrade pip setuptools
  pip install virtualenv
  pip install MySQL-python
  pip install tox
  ```
- 从此URL安装Java运行时：https : //support.apple.com/kb/dl1572? locale =zh_CN Apple仅支持Java 6.如果您需要安装较新版本，此链接可能会有所帮助： http：// osxdaily .COM / 2015/10/17 /如何安装的-java的在-OS-X-EL-匹/

- Vitess引导脚本会对运行时执行一些检查，因此建议在〜/ .profile或〜/ .bashrc或〜/ .zshrc中包含以下命令：
  ``` bash
  export PATH=/usr/local/opt/go/libexec/bin:$PATH
  export GOROOT=/usr/local/opt/go/libexec
  ```
- 使用pip安装enum34 Python包时存在问题，因此必须编辑以下文件：
  ``` bash
  /usr/local/opt/python/Frameworks/Python.framework/Versions/2.7/lib/python2.7/distutils/distutils.cfg
  ```
和这一行：
  ``` bash
  prefix=/usr/local
  ```
必须注释掉：
  ``` bash
  # prefix=/usr/local
  ```
从下一步运行./bootstrap.sh脚本之后，您可以恢复更改。

- 为使Vitess主机名解析功能正常工作，必须将新条目添加到/ etc / hosts文件中，并将当前计算机的LAN IP地址（最好是IPv4）和当前主机名添加到当前主机名中，您可以通过键入'主机名'命令在终端。

在〜/ .profile或〜/ .bashrc或〜/ .zshrc中加入以下命令强制使用Go DNS解析器也是一个好主意：
  ``` bash
  export GODEBUG=netdns=go
  ```
#### Build Vitess  构建Vitess

- 导航到您想要下载Vitess源代码的目录并克隆Vitess Github回购。完成后，导航到该src/vitess.io/vitess目录。
  ``` bash
  cd $WORKSPACE
  git clone https://github.com/vitessio/vitess.git \
      src/vitess.io/vitess
  cd src/vitess.io/vitess
  ```
- 设置MYSQL_FLAVOR环境变量。为您的数据库选择适当的值。该值区分大小写。
  ``` bash
  export MYSQL_FLAVOR=MariaDB
  # or (mandatory for OS X)
  # export MYSQL_FLAVOR=MySQL56
  ```
- 如果您选择的数据库安装在除了以外的位置/usr/bin，请将该VT_MYSQL_ROOT变量设置为MariaDB安装的根目录。例如，如果安装了MariaDB /usr/local/mysql，请运行以下命令。
  ``` bash
  export VT_MYSQL_ROOT=/usr/local/mysql

  # on OS X, this is the correct value:
  # export VT_MYSQL_ROOT=/usr/local/opt/mysql56
  ```
  请注意，该命令表示mysql应该在位置找到可执行文件/usr/local/mysql/bin/mysql。

- 运行mysqld --version并确认您正在运行MariaDB或MySQL的正确版本。MariaDB和MySQL的值应该是10或更高。

  使用下面的命令构建Vitess。请注意，该 bootstrap.sh脚本需要下载一些依赖项。如果你的机器需要代理服务器访问Internet，您将需要设置常用的环境变量（例如http_proxy， https_proxy，no_proxy）。

  运行boostrap.sh脚本：
  ``` bash
  ./bootstrap.sh
  ### example output:
  # skipping zookeeper build
  # go install golang.org/x/tools/cmd/cover ...
  # Found MariaDB installation in ...
  # creating git pre-commit hooks
  #
  # source dev.env in your shell before building
  # Remaining commands to build Vitess
  . ./dev.env
  make build
  ```
#### Run Tests 运行测试

注意：如果您使用的是etcd，请设置以下环境变量：
  ``` bash
  export VT_TEST_FLAGS='--topo-server-flavor=etcd2'
  ```
注意：如果您使用consul，请设置以下环境变量：
  ``` bash
  export VT_TEST_FLAGS='--topo-server-flavor=consul'
  ```

运行时的默认目标make test包含一整套旨在帮助Vitess开发人员验证代码更改的测试。这些测试通过在本地计算机上启动许多服务器来模拟小型Vitess集群。为此，他们需要大量资源; 建议至少使用8GB RAM和SSD来运行测试。

一些测试需要额外的包。例如，在Ubuntu上：
  ``` bash
  $ sudo apt-get install chromium-browser mvn xvfb
  ```
如果您只想检查Vitess是否在您的环境中工作，则可以运行一组较轻的测试：
  ``` bash
  make site_test
  ```
- 常见测试问题

尝试make test在动力不足的机器上运行完整的开发人员测试套件（）通常会导致失败。如果您在运行较轻的测试集时仍然看到相同的失败（make site_test），请在vitess@googlegroups.com 论坛上告诉开发团队 。

  - Node already exists, port in use, etc.

  > 失败的测试可能会导致孤立的进程。如果您使用默认设置，则可以使用以下命令来识别并终止这些进程：
  ``` bash
  pgrep -f -l '(vtdataroot|VTDATAROOT)' # list Vitess processes
  pkill -f '(vtdataroot|VTDATAROOT)' # kill Vitess processes
  ```

  - Too many connections to MySQL, or other timeouts
  > 此错误通常意味着您的磁盘太慢。如果您无法访问SSD，则可以尝试使用虚拟硬盘进行测试。

  - Connection refused to tablet, MySQL socket not found, etc.
  > 这些错误可能表明机器内存耗尽，并且尝试分配更多RAM时服务器崩溃。一些较重的测试需要高达8GB的RAM。

  - Connection refused in zkctl test
  > 此错误可能表示机器没有安装Java Runtime，如果您将ZooKeeper用作锁定服务器，则这是一项要求。

  - Running out of disk space
  > 一些较大的测试在磁盘上使用高达4GB的临时空间。

#### Start a Vitess cluster  启动Vitess集群

在完成上面构建Vitess的指示后，可以使用Github repo中的示例脚本在本地机器上启动Vitess集群。这些脚本使用ZooKeeper作为锁定服务。Vitess发行版中包含ZooKeeper。

- 检查系统设置

> 一些Linux发行版的默认文件描述符限制对数据库服务器来说太低。这个问题可能会在数据库崩溃时显示消息“打开的文件过多”。
检查系统范围的file-max设置以及用户特定的 ulimit值。我们建议将它们设置在100K以上以确保安全。确切的程序 可能因您的Linux发行版而异。

- 配置环境变量

> 如果您仍然在用于运行构建命令的终端窗口中，则可以跳到下一步，因为环境变量已经设置。
如果您将此示例适用于您自己的部署，则运行脚本之前所需的唯一环境变量是VTROOT和VTDATAROOT。

设置VTROOT为Vitess源代码树的父级。例如，如果你跑make build进去$HOME/vt/src/vitess.io/vitess，那么你应该设置：
  ``` bash
  export VTROOT=$HOME/vt
  ```
设置VTDATAROOT到您想要存储数据文件和日志的目录。例如：
  ``` bash
  export VTDATAROOT=$HOME/vtdataroot
  ```
- 启动ZooKeeper或Etcd

Vitess集群中的服务器通过查找存储在分布式锁定服务中的动态配置数据来相互找到对方。以下脚本创建一个小型ZooKeeper集群：
  ``` bash
  $ cd $VTROOT/src/vitess.io/vitess/examples/local
  vitess/examples/local$ ./zk-up.sh
  ### example output:
  # Starting zk servers...
  # Waiting for zk servers to be ready...
  ```
在ZooKeeper集群运行之后，我们只需告诉每个Vitess进程如何连接到ZooKeeper。然后，每个进程都可以通过ZooKeeper进行协调来找到所有其他的Vitess进程。

我们的每个脚本自动使用TOPOLOGY_FLAGS环境变量指向全局ZooKeeper实例。全局实例依次被配置为指向本地实例。在我们的示例脚本中，它们都托管在相同的ZooKeeper服务中。

如果您想将Etcd用作分布式锁定服务，则以下脚本将创建一个Etcd实例：
  ``` bash
  $ cd $VTROOT/src/vitess.io/vitess/examples/local
  vitess/examples/local$ source ./topo-etcd2.sh
  vitess/examples/local$ ./etcd-up.sh
  ### example output:
  # enter etcd2 env
  # etcdmain: etcd Version: 3.X.X
  # ...
  # etcd start done...
  ```
- 启动vtctld

该vtctld服务器提供了显示所有存储在ZooKeeper的协调信息的Web界面。
  ``` bash
  vitess/examples/local$ ./vtctld-up.sh
  # Starting vtctld
  # Access vtctld web UI at http://localhost:15000
  # Send commands with: vtctlclient -server localhost:15999 ...
  ```
打开http://localhost:15000以验证 vtctld正在运行。目前还没有任何信息，但菜单应该出现，这表明 vtctld正在运行。

所述vtctld服务器还接受来自命令vtctlclient工具，其用于管理群集。请注意，RPC的端口（在本例中15999）与Web UI端口（15000）不同。这些端口可以使用命令行标志进行配置，如演示vtctld-up.sh。

为了方便起见，我们将lvtctl.sh在示例命令中使用脚本，以避免每次都输入vtctld地址。
  ``` bash
  # List available commands
  vitess/examples/local$ ./lvtctl.sh help
  ```
- 启动vttablets

该vttablet-up.sh脚本会引出三个vttablets，并根据脚本文件顶部设置的变量将它们分配给一个keyspace和shard。
  ``` bash
  vitess/examples/local$ ./vttablet-up.sh
  # Output from vttablet-up.sh is below
  # Starting MySQL for tablet test-0000000100...
  # Starting vttablet for test-0000000100...
  # Access tablet test-0000000100 at http://localhost:15100/debug/status
  # Starting MySQL for tablet test-0000000101...
  # Starting vttablet for test-0000000101...
  # Access tablet test-0000000101 at http://localhost:15101/debug/status
  # Starting MySQL for tablet test-0000000102...
  # Starting vttablet for test-0000000102...
  # Access tablet test-0000000102 at http://localhost:15102/debug/status
  ```
此命令完成后，刷新vtctld Web UI，您应该看到一个名为test_keyspace单个分片的密钥空间0。这是一个未硬化的密钥空间。

如果您点击分片框，您会看到该分片中的平板电脑列表。请注意，此时平板电脑不健康是正常现象，因为您尚未初始化它们。

您也可以点击每台平板电脑上的状态链接进入其状态页面，显示其操作的更多细节。每个Vitess服务器都/debug/status在其Web端口上提供状态页面。

- 初始化MySQL数据库

接下来，指定其中一个平板电脑作为初始主人。Vitess会自动连接其他从属的mysqld实例，以便它们从主设备的mysqld开始复制。这也是在创建默认数据库时。由于我们的密钥空间是命名的test_keyspace，MySQL数据库将被命名vt_test_keyspace。
``` bash
vitess/examples/local$ ./lvtctl.sh InitShardMaster -force test_keyspace/0 test-100
### example output:
# master-elect tablet test-0000000100 is not the shard master, proceeding anyway as -force was used
# master-elect tablet test-0000000100 is not a master in the shard, proceeding anyway as -force was used
```
注意：由于这是碎片第一次启动，平板电脑尚未进行任何复制，并且没有现有的主设备。InitShardMaster上面的命令使用该-force标志绕过通常的适用性检查，如果这不是全新的碎片，则适用。

运行此命令后，返回到vtctld Web界面中的Shard Status页面。当你刷新页面时，你应该看到一个vttablet是主，两个是副本，另外两个是rdonly。

你也可以在命令行看到这个：
``` bash
vitess/examples/local$ ./lvtctl.sh ListAllTablets test
### example output:
# test-0000000100 test_keyspace 0 master localhost:15100 localhost:17100 []
# test-0000000101 test_keyspace 0 replica localhost:15101 localhost:17101 []
# test-0000000102 test_keyspace 0 replica localhost:15102 localhost:17102 []
# test-0000000103 test_keyspace 0 rdonly localhost:15103 localhost:17103 []
# test-0000000104 test_keyspace 0 rdonly localhost:15104 localhost:17104 []
```
- 创建一个表

该vtctlclient工具可用于在键盘空间中的所有平板电脑上应用数据库架构。以下命令创建create_test_table.sql文件中定义的表格：
``` bash
# Make sure to run this from the examples/local dir, so it finds the file.
vitess/examples/local$ ./lvtctl.sh ApplySchema -sql "$(cat create_test_table.sql)" test_keyspace
下面显示了创建表的SQL：

CREATE TABLE messages (
  page BIGINT(20) UNSIGNED,
  time_created_ns BIGINT(20) UNSIGNED,
  message VARCHAR(10000),
  PRIMARY KEY (page, time_created_ns)
) ENGINE=InnoDB
```
- 采取备份

现在应用了初始模式，现在是进行第一次备份的好时机 。此备份将用于自动恢复您运行的任何其他副本，然后将它们连接到主服务器并赶上复制。如果现有的平板电脑出现故障并在没有数据的情况下进行备份，它也会自动从最新的备份中恢复，然后恢复复制。
``` bash
vitess/examples/local$ ./lvtctl.sh Backup test-0000000102
```
备份完成后，您可以列出碎片的可用备份：
``` bash
vitess/examples/local$ ./lvtctl.sh ListBackups test_keyspace/0
### example output:
# 2016-05-06.072724.test-0000000102
```
注意：在此单服务器示例设置中，备份存储在 $VTDATAROOT/backups。在多服务器部署中，您通常会在那里挂载一个NFS目录。您还可以通过-file_backup_storage_root在vtctld和vttablet上设置标志来更改位置 ，如vtctld-up.sh和中所示vttablet-up.sh。

- 初始化Vitess路由架构

在这些例子中，我们只是使用一个没有特定配置的数据库。所以我们只需要使这个（空的）配置可见即可使用。这是通过运行以下命令完成的：

vitess/examples/local$ ./lvtctl.sh RebuildVSchemaGraph
（当它工作时，这个命令不会显示任何输出。）

- 启动vtgate

Vitess使用vtgate将每个客户端查询路由到正确的vttablet。这个本地示例运行单个vtgate实例，但真正的部署可能会运行多个vtgate实例来共享负载。
``` bash
vitess/examples/local$ ./vtgate-up.sh
```
##### Run a Client Application  运行客户端应用横向

该client.py文件是一个简单的示例应用程序，它连接到vtgate并执行一些查询。要运行它，您需要：

将Vitess Python包添加到您的PYTHONPATH。

要么

使用client.sh包装脚本，它临时设置环境然后运行client.py。
``` bash
vitess/examples/local$ ./client.sh
### example output:
# Inserting into master...
# Reading from master...
# (5L, 1462510331910124032L, 'V is for speed')
# (15L, 1462519383758071808L, 'V is for speed')
# (42L, 1462510369213753088L, 'V is for speed')
# ...
```
在Java，PHP和Go的同一目录中也有示例客户端。请参阅每个示例文件顶部的注释以获取使用说明。
##### Try Vitess resharding 尝试Vitess重新粉碎

现在您已经完成了一个完整的Vitess堆栈，您可能想要继续使用 Horizo​​ntal Sharding工作流指南 或Horizo​​ntal Sharding codelab （如果您希望通过命令手动运行每个步骤）来尝试 动态重新分片。

如果是这样，你可以跳过拆除指南，因为拆分指南在这里提取。如果不是，继续下面的清理步骤。

##### Tear down the cluster 清理集群

每个-up.sh脚本都有相应的-down.sh脚本来停止服务器。
``` bash
vitess/examples/local$ ./vtgate-down.sh
vitess/examples/local$ ./vttablet-down.sh
vitess/examples/local$ ./vtctld-down.sh
vitess/examples/local$ ./zk-down.sh  # If you use Etcd, run ./etcd-down.sh
```
请注意，这些-down.sh脚本将留下任何创建的数据文件。如果您已完成此示例数据，则可以清除以下内容VTDATAROOT：
``` bash
$ cd $VTDATAROOT
/path/to/vtdataroot$ rm -rf *
```

### Troubleshooting 故障排除

如果出现任何问题，请检查$VTDATAROOT/tmp目录中的日志以获取错误消息。还有一些平板特定的日志，以及各种$VTDATAROOT/vt_*目录中的MySQL日志。

如果您需要帮助诊断问题，请将邮件发送到我们的 邮件列表。除了在命令行中看到的任何错误之外，还可以帮助将VTDATAROOT目录的存档上载到文件共享服务并提供指向它的链接。
