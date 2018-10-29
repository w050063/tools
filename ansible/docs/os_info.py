#!/usr/bin/env python

import re
import copy
import datetime
import commands
import json
import socket
import subprocess

date = str(datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S'))
localIP = socket.gethostbyname(socket.gethostname())
sys_id = localIP.split('.')[1]
outIp = "163.177.76.147"
route = commands.getoutput("ip route |grep 'default' |head -n 1 |awk '{print $3}'")
hostname = commands.getoutput('hostname')
hostclass = commands.getoutput('hostname|egrep -o "app|web"')
backupip = commands.getoutput("grep -r 'G_MOVE_IP=10.' /etc/keepalived/* | head -n 1 |awk -F '=' '{print $NF}'")
rsync_state = commands.getoutput(
    'if ps -ef |grep "rsync_007ka"|grep -q "inotifywait";then echo "Source";else echo "Backce";fi')
inode_usage = commands.getoutput('df -i | grep "/$" | grep -oE "[0-9]{1,3}%"')
disk_usage = commands.getoutput('df -h | grep "/$" | grep -oE "[0-9]{1,3}%"')
swap_free = commands.getoutput("free -m | grep Swap |awk '{print int($4/$2*100)\"%\"}'")

runing_online_num = commands.getoutput(
    'ps aux|grep ^apps|grep -vw "grep\|vim\|vi\|mv\|cp\|scp\|cat\|dd\|tail\|head\|script\|ls\|echo\|sys_log\|logger\|tar\|rsync\|ssh\|new_sysmon\|inotifywait"|grep "/usr/local/007ka/"|wc -l')
psaux_data = subprocess.Popen("ps aux |grep ^apps", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
all_program = subprocess.Popen(
    'find /usr/local/007ka/ -type f -name "run.sh" -o -name "run_*.sh" | grep -v "/usr/local/007ka/bin"|grep -v "new_sysmon" | sed -e "s/\/run.*.sh//"| uniq',
    shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
global g_list_psaux_data, g_list_all_program
prgram_data_all = []
g_list_psaux_data = copy.deepcopy(psaux_data.stdout.readlines())
g_list_all_program = copy.deepcopy(all_program.stdout.readlines())

for line in g_list_all_program:
    tmp_proname = str(line.strip('\n').split('/')[-1])
    program_line = ''.join([x for x in g_list_psaux_data if x.find(tmp_proname, re.M) != -1])
    if program_line.strip():
        tmp_pid = program_line.split()[1]
        dict_program = {
            "Name": tmp_proname,
            "pid": tmp_pid,
            "SysId": sys_id
        }
        prgram_data_all.append(dict_program)
        # print dict_program
        # print prgram_data_all

# retval = psaux_data.wait()
# retval = all_program.wait()

# print json data
print json.dumps({
    "Name": date,
    "Sys_Id": sys_id,
    "In_Ipaddress": localIP,
    "Out_Ipaddress": outIp,
    "Route": route,
    "HostName": hostname,
    "HostClass": hostclass,
    "BackupIp": backupip,
    "Rsync_State": rsync_state,
    "Disk_Total": {
        "Inode_Usage": inode_usage,
        "Disk_Usage": disk_usage,
        "Swap_Free": swap_free
    },
    "Runing_Online_Num": runing_online_num,
    "Program_Data": prgram_data_all
})

