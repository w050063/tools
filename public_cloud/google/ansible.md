# 概述
# 参考资料
https://docs.ansible.com/ansible/latest/scenario_guides/guide_gce.html
# 实践记录
```
python >= 2.6
pip install apache-libcloud
1、Create a Service Account
IAM和管理-->服务账号--选择项目--
2、Download JSON credentials

ansible -i gce.py all -m ping --private-key=/etc/ansible/ssh-keys/ssh-key-google-04.pem -u mdscdpc
```
