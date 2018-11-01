# AWS

## AWS概述
- [AWS云全球服务基础设施区域列表](https://amazonaws-china.com/cn/about-aws/global-infrastructure/regional-product-services/)
- [AWS产品定价国外区](https://amazonaws-china.com/cn/pricing/services/)
- [AWS产品定价中国区](#)(注意！需要登陆账户才能查看)
- [AWS产品费用预算](http://calculator.s3.amazonaws.com/index.html)
- [AWS区域和终端节点](https://docs.aws.amazon.com/zh_cn/general/latest/gr/rande.html?key=cloudformation/27fc5750-8f03-4f10-b593-55c14d8d591c&lng=zh_CN#)
## EC2
参考资料: http://www.cnblogs.com/syaving/p/8583060.html

## CloudFormation
CloudFormation给予了用户一种简单的方法来创建和管理一系列有关联的AWS的资源,可以有序的及可预见的初始化和更新这些资源。

### Template 模板
Template本质上是一个json格式的文件。该文件定义了你需要使用那些AWS的资源，并且如何初始化这些资源。
### Stack 堆
### CloudFormer
CloudFormer是亚马逊提供的一个工具，用来给已有的AWS资源创建CloudFormation Template。这样你在以后创建相同的AWS资源时就可以直接使用这个Template了。

要使用CloudFormer首先要创建一个Stack，CloudFormer就被部署到一台EC2机器上，通过这个Stack返回的Outputs的URL我们可以一步步勾选使用到的资源，最终生成一个Template，该Template会自动放置到你的S3中。
## MySQL
## S3
## AWS Glue
https://aws.amazon.com/cn/glue/
https://docs.aws.amazon.com/zh_cn/glue/latest/dg/what-is-glue.html

jdbc-->glue
- https://www.cdata.com/kb/tech/mysql-jdbc-aws-glue.rst
- https://dzone.com/articles/extract-data-into-aws-glue-using-jdbc-drivers-and
- https://aws.amazon.com/cn/blogs/big-data/use-aws-glue-to-run-etl-jobs-against-non-native-jdbc-data-sources/
- https://www.progress.com/tutorials/jdbc/accessing-data-using-jdbc-on-aws-glue

## Amazon Athena
https://aws.amazon.com/cn/athena/
## IAM安全
## 其他
# 参考资料
- https://www.cnblogs.com/syaving/p/8649729.html

# to-do-list
- 添加一个服务账号，用于各类API调用使用
- 
