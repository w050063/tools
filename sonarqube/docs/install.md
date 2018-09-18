sonar-scanner \
  -Dsonar.projectKey=loveserver \
  -Dsonar.sources=. \
  -Dsonar.host.url=http://xxxx:9000 \
  -Dsonar.login=02c153b9f6df4688cbdf5b92c30b1f8a09f3f9e8

jenkins与sonarqube集成

SonarQube Scanners
SonarQube Plugins
SonarLint

# FQA
Please provide compiled classes of your project with sonar.java.binaries property
https://blog.csdn.net/pengyuan_d/article/details/79932905


```
# cat conf/sonar-scanner.properties
sonar.host.url=http://10.0.0.30:9000
sonar.projectKey=loveserver
sonar.sources=.
sonar.sourceEncoding=UTF-8
#sonar.language=php
sonar.exclusions=vendor/*
```
