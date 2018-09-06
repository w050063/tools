
# 概述
HTTPDNS使用HTTP协议进行域名解析，代替现有基于UDP的DNS协议，域名解析请求直接发送到HTTPDNS服务器，从而绕过运营商的Local DNS，能够避免Local DNS造成的域名劫持问题和调度不精准问题。

HTTPDNS 是一款递归DNS服务，与权威DNS不同，HTTPDNS 并不具备决定解析结果的能力，而是主要负责解析过程的实现。

# 优势
- 防劫持
绕过运营商 Local DNS ，避免域名劫持，让每一次访问都畅通无阻。
- 精准调度
由于运营商策略的多样性，其 Local DNS 的解析结果可能不是最近、最优的节点，HTTPDNS 能直接获取客户端 IP ，基于客户端 IP 获得最精准的解析结果，让客户端就近接入业务节点。
- 0ms解析延迟
通过热点域名预解析、缓存DNS解析结果、解析结果懒更新策略等方式实现0延迟的域名解析效果。
- 快速生效
解决 “Local DNS 不遵循权威 TTL ，变更域名解析结果后全网无法即时生效”的问题。

# 参考资料
- 阿里云httpdns: https://help.aliyun.com/product/30100.html
- 腾讯云httpdns：https://cloud.tencent.com/product/hd
