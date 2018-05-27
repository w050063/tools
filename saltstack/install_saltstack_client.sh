#!/bin/bash

. /etc/init.d/functions

RED_COLOR='\E[1;31m'
GREEN_COLOR='\E[1;32m'
YELLOW_COLOR='\E[1;33m'
BLUE_COLOR='\E[1;34m'
RES='\E[0m'

if [ $# != 1 ]; then        
	echo -e "${GREEN_COLOR}Useage:$0 saltstack-masterip (hostname as salt client id)${RES}"        
	exit 0
fi

LOG_FILE='/var/log/saltstack_install.log'
#saltstack="27.131.221.88"
saltstack=$1

write_log(){
# write log function

now_time='['$(date +"%Y-%m-%d %H:%M:%S")']'
echo ${now_time} $1 | tee -a ${LOG_FILE}
}

get_masterid(){
#主机名称能表示业务类型最好 或者使用主机名+IP地址某几位也可以
#masterid=`hostname`
if [ -f /usr/local/workspace/agent/cfg.json ]
then
    IP=`awk -F '["]+' '/hostname/{print $4}' /usr/local/workspace/agent/cfg.json`
    echo ${IP}
    break
else
    for i in `seq 3`
    do
        IP=`curl -s http://ip.chinaz.com/getip.aspx|awk -F "[,']+" '{print $2}'`
        count=`echo ${#IP}`
        if [ ${count} -ge 53 ]
        then
            echo "not get ip"
            sleep 2
            continue
        else
            echo ${IP}
            break
        fi
    done
fi
}
yum_repo_install(){
host_type=`awk -F"[ .]+" '{print $3}' /etc/redhat-release`

write_log "masterid will be set ${masterid}"
if [ ${host_type} == "6" ]
then
    write_log "CentOS ${host_type}"
    # epel yum install
    if [ ! -f /etc/yum.repos.d/epel.repo ]
    then
        wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-6.repo
    fi

    if [ ! -f /etc/yum.repos.d/CentOS-Base.repo ]
    then
        wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-6.repo
    fi
elif [ ${host_type} == "5" ]
then
    write_log "CentOS ${host_type}"
    # saltstack yum install
    if [ ! -f /etc/yum.repos.d/saltstack-rhel5.repo ]
    then
        wget -O /etc/yum.repos.d/saltstack-rhel5.repo http://repo.saltstack.com/yum/redhat/5/x86_64/saltstack-rhel5.repo
        if [ ! $? -eq ]
        then
            write_log "saltstack yum install is fail"
            exit 1
        fi
    fi
else
    write_log "os unknow"
fi
yum clean all
}

salt_minion_install(){
masterid=`get_masterid`

# saltstack minion install
rpm -qa |grep -q salt-minion
if [ ! $? -eq 0 ]
then
    yum_repo_install
    yum -y install salt-minion 
    if [ $? -eq 0 ]
    then
        # change master
        cp /etc/salt/minion{,.`date +%Y%m%d`}    
        sed -i "s/#master: salt/master: salt/g" /etc/salt/minion
        sed -i "s/#id:/id: $masterid/g" /etc/salt/minion
        # sed -i "s/#master: salt/master: $1/g" /etc/salt/minion
        grep -q salt /etc/hosts
        if [ $? -eq 0 ]
        then
            write_log "${saltstack} salt is exist!!!"    
        else
            echo "${saltstack} salt">> /etc/hosts
        fi

        # saltstack start setup
        /etc/init.d/salt-minion restart
        chkconfig salt-minion on
    else
       write_log "salt-minion install is fail !!!" 
    fi
else
     salt_minion_id=`awk '/^id/{print $2}' /etc/salt/minion`
     if [ ! -n "${salt_minion_id}" ]
     then
         salt_minion_id="null"
     fi
     write_log "salt-minion is installed !!!"
     write_log "salt-minion id is ${salt_minion_id}"
fi
}

salt_minion_install
