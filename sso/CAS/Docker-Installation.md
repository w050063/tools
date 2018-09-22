```
install_docker_ce.yml
docker run -p 80:8080 -p 443:8443 -d --name="cas" apereo/cas:v5.2.2

2018-09-22 02:39:36,106 ERROR [org.apache.catalina.core.StandardService] - <Failed to start connector [Connector[HTTP/1.1-8443]]>
org.apache.catalina.LifecycleException: Failed to start component [Connector[HTTP/1.1-8443]]
        at org.apache.catalina.util.LifecycleBase.start(LifecycleBase.java:167) ~[tomcat-catalina-8.5.32.jar!/:8.5.32]
        at org.apache.catalina.core.StandardService.addConnector(StandardService.java:225) ~[tomcat-catalina-8.5.32.jar!/:8.5.32]
        at org.springframework.boot.context.embedded.tomcat.TomcatEmbeddedServletContainer.addPreviouslyRemovedConnectors(TomcatEmbeddedServletContainer.java:265) ~[spring-boot-1.5.14.RELEASE.jar!/:1.5.14.RELEASE]
        at org.springframework.boot.context.embedded.tomcat.TomcatEmbeddedServletContainer.start(TomcatEmbeddedServletContainer.java:208) ~[spring-boot-1.5.14.RELEASE.jar!/:1.5.14.RELEASE]
        at org.springframework.boot.context.embedded.EmbeddedWebApplicationContext.startEmbeddedServletContainer(EmbeddedWebApplicationContext.java:297) ~[spring-boot-1.5.14.RELEASE.jar!/:1.5.14.RELEASE]
        at org.springframework.boot.context.embedded.EmbeddedWebApplicationContext.finishRefresh(EmbeddedWebApplicationContext.java:145) ~[spring-boot-1.5.14.RELEASE.jar!/:1.5.14.RELEASE]
        at org.springframework.context.support.AbstractApplicationContext.refresh(AbstractApplicationContext.java:546) ~[spring-context-4.3.18.RELEASE.jar!/:4.3.18.RELEASE]
        at org.springframework.boot.context.embedded.Embedded
```
