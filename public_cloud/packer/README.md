# 概述
- Packer官网：https://www.packer.io/
- 官网文档地址：https://www.packer.io/intro/index.html
- https://www.packer.io/docs/builders/index.html

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
#  cat dummy_artifact
ubuntu#
# to-do-list
