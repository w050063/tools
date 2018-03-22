from QcloudApi.qcloudapi import QcloudApi

import json
import yaml

conf_file="api.yaml"

f = open(conf_file)
conf_yaml = yaml.load(f)
print conf_yaml
Region = conf_yaml['Region']
secretId = conf_yaml['secretId']
secretKey = conf_yaml['secretKey']
Version = conf_yaml['Version']

module = 'cvm'
action = 'DescribeInstances'
config = {'Region':Region, 'secretId':secretId, 'secretKey':secretKey, 'Version':Version}
params = {'Limit':1}
service = QcloudApi(module, config)
str_results = service.call(action, params)
json_results = json.loads(str_results)
print json_results
for i in json_results['Response']['InstanceSet']:
    name = i['InstanceName']
    wanip = i['PublicIpAddresses'][0]
    lanip = i['PrivateIpAddresses'][0]
    os = i['OsName']
    cpu = i['CPU']
    mem = i['Memory']
    info = "name=%s\twanip=%s\tlanip=%s\tconf=%score*%sG\tos=%s" % (name,wanip,lanip,cpu,mem,os)
    print info
