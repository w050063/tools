> https://docs.hortonworks.com/HDPDocuments/Ambari-2.7.0.0/administering-ambari/content/amb_understanding_ambari_terminology.html

# 了解Ambari术语
熟悉以下基本术语可以帮助您理解与Ambari管理相关的关键概念：
- Ambari Admin
授予用户的特定权限，使该用户能够管理Ambari。具有Ambari Admin权限的用户可以将此权限授予其他用户，或从其中撤消该权限。
- Ambari管理页面
Ambari网页仅供具有Ambari管理员权限的用户访问。
- Ambari Web
图形用户界面（GUI），为用户提供对Ambari管理的群集资源的访问。
- 帐户
用户名，密码和权限。
- 簇
基于特定堆栈的Hadoop集群的安装，由Ambari管理。
- 组
Ambari中独特的用户群。
- 组类型
本地和LDAP。本地组在Ambari数据库中维护。如果配置了LDAP组，则将LDAP组导入（并与之同步）外部LDAP。
- 权限
授予特定视图的主体用户或组的权限。
- 主要
可由Ambari进行身份验证的用户或组。
- 特权
主体到权限或角色以及资源的映射。例如，用户joe.operator在集群DevCluster上被授予Cluster Operator角色。
- 资源
Ambari中可用和管理的资源。Ambari支持两种类型的资源：集群和视图。Ambari管理员为用户和组分配资源的权限。
- 角色
分配给特定群集上的主体（用户或组）的角色。
- 用户
Ambari的独特用户。
- 用户类型
本地和LDAP。本地用户在Ambari数据库中维护，并对Ambari数据库执行身份验证。LDAP用户将导入（并与之同步）外部LDAP（如果已配置）。
- 版
堆栈版本，其中包含一组用于在群集上安装该版本的存储库。
- 视图
Ambari可用的用户界面组件。
