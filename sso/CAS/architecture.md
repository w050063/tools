> https://apereo.github.io/cas/5.3.x/planning/Architecture.html

![image](cas_architecture.png)
# 系统组件
- CAS服务器
CAS服务器是基于Spring Framework构建的Java servlet，其主要职责是通过颁发和验证票证来对用户进行身份验证并授予对启用CAS的服务（通常称为CAS客户端）的访问权限。当服务器在成功登录后向用户发出票证授予票证（TGT）时，将创建SSO会话。使用TGT作为令牌，通过浏览器重定向，根据用户的请求向服务发出服务票据（ST）。随后通过反向信道通信在CAS服务器上验证ST。这些相互作用在CAS协议文档中有详细描述。

- CAS客户端
# 支持的协议
# 软件组件
  - spring框架
