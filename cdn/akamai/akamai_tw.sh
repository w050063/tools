#!/bin/bash

. /etc/init.d/functions

RED_COLOR='\E[1;31m'
GREEN_COLOR='\E[1;32m'
YELLOW_COLOR='\E[1;33m'
BLUE_COLOR='\E[1;34m'
RES='\E[0m'

LOG_FILE='akakmai_script.log'

scp_files=$2
remote_dir=$3

write_log(){
# write log function

now_time='['$(date +"%Y-%m-%d %H:%M:%S")']'
echo ${now_time} $1 | tee -a ${LOG_FILE}
}

ssh_host(){
write_log "ssh -t sshacs@xxx.upload.akamai.com -i akakmai_tw cms"
ssh -t sshacs@xxx.upload.akamai.com -i akakmai_tw cms
}

scp_file(){
if [ $# -eq 2 ]
then
    write_log "scp -i akakmai_tw $1 sshacs@xxx.upload.akamai.com:$2"
    scp -i akakmai_tw ${scp_files} sshacs@xxx.upload.akamai.com:${remote_dir}
else
    echo -e "${GREEN_COLOR}Usage: $0 scp_files remote_dir ${RES}"
    echo -e "${RED_COLOR}Example: $0 akamai_tw.sh /300291/ss/${RES}"
fi
}

case "$1" in
  ssh)
        ssh_host
        ;;
  scp)
        scp_file ${scp_files} ${remote_dir}
        ;;
  *)
        echo -e "${GREEN_COLOR}Usage: $0 {ssh|scp}${RES}"
        exit 1
esac
