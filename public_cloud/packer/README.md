# 概述
- Packer官网：https://www.packer.io/
- 官网文档地址：https://www.packer.io/intro/index.html
- https://www.packer.io/docs/builders/index.html

## 案例
### file模块
```
# cat 1.json
{
"builders": [
  {
    "type": "file",
    "content": "ubuntu",
    "target": "dummy_artifact"
  }
]
}

# ./packer build 1.json  
file output will be in this color.

Build 'file' finished.

==> Builds finished. The artifacts of successful builds are:
--> file: Stored file: dummy_artifact
```
### google模块
```
# cat google.json
{
  "builders": [
    {
      "type": "googlecompute",
      "account_file": "account.json",
      "project_id": "xxx",
      "source_image": "debian-7-wheezy-v20150127",
      "ssh_username": "packer",
      "zone": "us-central1-a"
    }
  ]
}

# ./packer build google.json
googlecompute output will be in this color.

==> googlecompute: Checking image does not exist...
==> googlecompute: Creating temporary SSH key for instance...
==> googlecompute: Using image: debian-7-wheezy-v20150127
==> googlecompute: Creating instance...
    googlecompute: Loading zone: us-central1-a
    googlecompute: Loading machine type: n1-standard-1
    googlecompute: Requesting instance creation...
    googlecompute: Waiting for creation operation to complete...
    googlecompute: Instance has been created!
==> googlecompute: Waiting for the instance to become running...
    googlecompute: IP: 35.202.237.72
==> googlecompute: Using ssh communicator to connect: 35.202.237.72
==> googlecompute: Waiting for SSH to become available...
==> googlecompute: Connected to SSH!
==> googlecompute: Deleting instance...


    googlecompute: Instance has been deleted!
==> googlecompute: Creating image...
==> googlecompute: Deleting disk...
    googlecompute: Disk has been deleted!
Build 'googlecompute' finished.

==> Builds finished. The artifacts of successful builds are:
--> googlecompute: A disk image was created: packer-1541417917
You have new mail.
```
#  cat dummy_artifact
ubuntu#
# to-do-list
