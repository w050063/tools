#!/bin/env bash

sed -i '/# JAVA bin PATH setup/d' /etc/profile ~/.bashrc
sed -i '/java-1.8.0-openjdk-1.8.0.171/d' /etc/profile ~/.bashrc
sed -i '/JAVA_HOME/d' /etc/profile ~/.bashrc

cat>>/etc/profile<<EOF

# JAVA bin PATH setup
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.171-8.b10.el7_5.x86_64/
export CLASSPATH=.:\$JAVA_HOME/jre/lib/rt.jar:\$JAVA_HOME/lib/dt.jar
export PATH=\$PATH:\$JAVA_HOME/bin 
EOF
source /etc/profile

cat>>~/.bashrc<<EOF

# JAVA bin PATH setup
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.171-8.b10.el7_5.x86_64/
export CLASSPATH=.:\$JAVA_HOME/jre/lib/rt.jar:\$JAVA_HOME/lib/dt.jar
export PATH=\$PATH:\$JAVA_HOME/bin 
EOF
source ~/.bashrc

