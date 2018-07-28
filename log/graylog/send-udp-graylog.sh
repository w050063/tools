#!/bin/sh

msg=$1
#msg=$( netstat  | grep a | awk {'print $4'})
version="1.1"
host="$(hostname) ($(hostname -i))"
level=5
_some_info="testing"
graylog_ip="10.130.0.224"
graylog_port=12201

obj='{"version": "'"$version"'", "host": "'"$host"'", "short_message": "'"$msg"'", "level": '"$level"', "_some_info": "'"$_some_info"'"}'

echo -n $obj | nc -w0 -u $graylog_ip $graylog_port
