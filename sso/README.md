# 单点登录(SSO)
## 概念
单点登录主要用于多系统集成，即在多个系统中，用户只需要到一个中央服务器登录一次即可访问这些系统中的任何一个，无须多次登录。单点登录(Single Sign ON)，简称SSO，是目前比较流行的企业业务整合的解决方案之一。SSO的定义是在多个应用系统中，用户只需要登录一次就可以访问所有相互信任的应用系统。
## web系统如何实现单点登录
目前已经有了成熟的单点登录实现方案，比如CAS，我们只要在web系统中应用单点登录方案CAS即可。(主要涉及到注册登录验证等模块的改动)


- [openam](https://www.forgerock.com/platform/access-management)
- [CAS](https://www.apereo.org/projects/cas)
- [Shiro](https://shiro.apache.org/)
- [django-cas](https://pypi.org/project/django-cas-client/)
- django-mama-cas
- [django-cas-ng](https://pypi.org/project/django-cas-ng/)

https://my.oschina.net/xiaomaijiang/blog/795056
https://www.helplib.com/GitHub/article_97222
