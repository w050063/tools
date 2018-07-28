> [官网地址](http://maven.apache.org/install.html)

# demo
mvn archetype:generate -DgroupId=maven.demo.start -DartifactId=HelloMaven -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false
cd HelloMaven && mvn package
java -cp target/HelloMaven-1.0-SNAPSHOT.jar maven.demo.start.App

源地址：https://github.com/liuzl/learn/tree/master/maven
