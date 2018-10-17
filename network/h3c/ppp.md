# PPP点到点协议概述
PPP点到点协议（Point to Point Protocol，PPP）是IETF（Internet Engineering Task Force，因特网工程任务组）推出的点到点类型线路的数据链路层协议。它解决了SLIP中的问题，并成为正式的因特网标准。
PPP协议在RFC 1661、RFC 1662和RFC 1663中进行了描述。
PPP支持在各种物理类型的点到点串行线路上传输上层协议报文。PPP有很多丰富的可选特性，如支持多协议、提供可选的身份认证服务、可以以各种方式压缩数据、支持动态地址协商、支持多链路捆绑等等。这些丰富的选项增强了PPP的功能。同时，不论是异步拨号线路还是路由器之间的同步链路均可使用。因此，应用十分广泛。
## PAP
PPP提供了两种可选的身份认证方法：口令验证协议PAP（Password Authentication Protocol，PAP）和质询握手协议（Challenge Handshake Authentication Protocol，CHAP）。如果双方协商达成一致，也可以不使用任何身份认证方法.
PAP是一个简单的、实用的身份验证协议。
PAP认证进程只在双方的通信链路建立初期进行。如果认证成功，在通信过程中不再进行认证。如果认证失败，则直接释放链路。
PAP的弱点是用户的用户名和密码是明文发送的，有可能被协议分析软件捕获而导致安全问题。但是，因为认证只在链路建立初期进行，节省了宝贵的链路带宽。

## CHAP
CHAP全称为：Challenge Handshake Authentication Protocol(挑战握手认证协议)，主要就是针对PPP的，除了在拨号开始时使用外，还可以在连接建立后的任何时刻使用。
CHAP协议基本过程是认证者先发送一个随机挑战信息给对方，接收方根据此挑战信息和共享的密钥信息，使用单向HASH函数计算出响应值，然后发送给认证者，认证者也进行相同的计算，验证自己的计算结果和接收到的结果是否一致，一致则认证通过，否则认证失败。这种认证方法的优点即在于密钥信息不需要在通信信道中发送，而且每次认证所交换的信息都不一样，可以很有效地避免监听攻击。
CHAP缺点：密钥必须是明文信息进行保存，而且不能防止中间人攻击。
使用CHAP的安全性除了本地密钥的安全性外，网络上的安全性在于挑战信息的长度、随机性和单向HASH算法的可靠性。

## MS_CHAP

微软开发的通过交换挑战和握手信息来进行认证的远程访问认证协议。它是由CHAP派生出来的，和CHAP有些差异。1998年发布的RFC2433给出了MS-CHAP的详细定义。它以如下手续对用户进行认证。
- 当PC向认证服务器发出认证请求时，认证服务器向PC发送被称为挑战的比特列。
- PC使用MD5散列函数根据挑战和用户的密码计算出散列值，然后把散列值和用户名一起发送给认证服务器。
- 认证服务器从数据库中取出用户的密码，从密码和挑战计算出散列值，然后把散列值与收到的散列值进行比较。如果一致，认证成功。

## CHAP V2
Microsoft 质询握手身份验证协议 (MS-CHAP v2) 是一个通过单向加密密码进行的相互身份验证过程，工作流程如下：
- 身份验证器（远程访问服务器或 NPS 服务器）向远程访问客户端发送质询，其中包含会话标识符和任意质询字符串。
- 远程访问客户端发送包含下列信息的响应：
用户名。
任意对等质询字符串。
接收的质询字符串、对等质询字符串、会话标识符和用户密码的单向加密。
- 身份验证器检查来自客户端的响应并发送回包含下列信息的响应：
指示连接尝试是成功还是失败。
经过身份验证的响应，基于发送的质询字符串、对等质询字符串、加密的客户端响应和用户密码。
- 远程访问客户端验证身份验证响应，如果正确，则使用该连接。如果身份验证响应不正确，远程访问客户端将终止该连接。
MS-CHAP v2 是随 Windows Server® 2008 系列提供的、唯一支持在身份验证过程中更改密码的身份验证协议。

## EAP
扩展认证协议EAP（读作"eep")
英文全称：Extensible Authentication Protocol
是一个普遍使用的认证机制，它常被用于无线网络或点到点的连接中。EAP不仅可以用于无线局域网，而且可以用于有线局域网，但它在无线局域网中使用的更频繁。最近，WPA和WPA2标准已经正式采纳了5类EAP作为正式的认证机制。
EAP是一个认证框架，不是一个特殊的认证机制。EAP提供一些公共的功能，并且允许协商所希望的认证机制。这些机制被叫做EPA方法，现在大约有40种不同的方法。IETF的RFC中定义的方法包括：EAP-MD5, EAP-OTP, EAP-GTC, EAP-TLS, EAP-SIM,和EAP-AKA,
还包括一些厂商提供的方法和新的建议。无线网络中常用的方法包括EAP-TLS, EAP-SIM, EAP-AKA, PEAP, LEAP,和EAP-TTLS. 当EAP被基于802.1x的网络接入设备（诸如802.11a/b/g ，无线接入点）调用时，现代的EAP方法可以提供一个安全认证机制，并且在用户和网络接入服务器之间协商一个安全的PMK。该PMK可以用于使用TKIP和AES加密的无线会话。

## MPPE（传输协议非认证)
MPPE协议是由Microsoft设计的，它规定了如何在数据链路层对通信机密性保护的机制。它通过对PPP链接中PPP分组的加密以及PPP封装处理，实现数据链路层的机密性保护。
描述了在PPP协议中进行数据加密的方法，通常用其实现PPTP模式的VPN。
MPPE中的加密算法是固定的，使用RC4加密算法而不能是其他算法。


附：ubuntu 9.10 pptp server 认证典型配置 pptp-options 部分
```
# Encryption
# Debian: on systems with a kernel built with the package
# kernel-patch-mppe >= 2.4.2 and using ppp >= 2.4.2, ...
# {{{
refuse-pap
require-chap
require-mschap
# Require the peer to authenticate itself using MS-CHAPv2 [Microsoft
# Challenge Handshake Authentication Protocol, Version 2] authentication.
require-mschap-v2
# Require MPPE 128-bit encryption
# (note that MPPE requires the use of MSCHAP-V2 during authentication)
#require-mppe-128
# }}}

chap-secrets 中配置用户帐号
# client server secret IP addresses
name pptpd pass   *
name2 pptpd pass2 *
```
