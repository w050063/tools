#!/bin/bash
. /etc/init.d/functions

RED_COLOR='\E[1;31m'
GREEN_COLOR='\E[1;32m'
YELLOW_COLOR='\E[1;33m'
BLUE_COLOR='\E[1;34m'
RES='\E[0m'

log_file='cdn_push_'$(date +%Y-%m-%d)'.log'

# log function
write_log(){
now_time='['$(date +"%Y-%m-%d %H:%M:%S")']'
echo ${now_time} $1|tee -a ${log_file}
}

kakao_push(){
write_log 'change /etc/rsync.passwd is kakao password'
cat >/etc/rsync.passwd<<EOF
xxx
EOF
write_log 'push /data0/kakaocdn/ to xxx xxx'
rsync -vzrtp --progress --password-file=/etc/rsync.passwd /data0/kakaocdn/ xxx@xxx::xxx
write_log 'push /data0/kakaocdn/ to 1xxx xxx is ok'
}

efun_push(){
write_log 'change /etc/rsync.passwd is efun password'
cat >/etc/rsync.passwd<<EOF
yyy
EOF
write_log 'push /data0/cdn/ to xxx xxx'
rsync -vzrtp --progress --password-file=/etc/rsync.passwd /data0/cdn/ xxx@xxx::xxx
write_log 'push /data0/cdn/ to xxx xxx is ok'
}

case "$1" in
  'kakao')
    kakao_push
    ;;

  'efun')
    efun_push
    ;;
    *)
      # usage
      echo -e "${GREEN_COLOR}Usage:$0 {kakao|efun} [cdn push options]${RES}"
      exit 1
    ;;
esac
