#Docker for CentoS
FROM centos:7.2.1511

#Who
MAINTAINER dongsheng.ma@lemongrassmedia.cn

#PKG
RUN rm -f /etc/yum.repos.d/*
ADD epel-7.repo Centos-7.repo /etc/yum.repos.d/
RUN yum install -y wget net-tools openssl-devel openssh-clients openssh-server supervisor && yum clean all

#FOR SSH
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key
RUN ssh-keygen -A -t dsa -f /etc/ssh/ssh_host_dsa_key

#SET root password
RUN echo "root:123456" | chpasswd

#Supervisor
ADD supervisord.conf /etc/supervisord.conf
ADD sshd.ini /etc/supervisord.d/sshd.ini

EXPOSE 22

CMD ["/usr/bin/supervisord","-c","/etc/supervisord.conf"]
