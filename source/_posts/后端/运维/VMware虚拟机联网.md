---
title: VMware虚拟机联网
date: 2023年10月25日14:16:23
tags: 
    - ubuntu
categories: 运维
keywords:
description:
top_img: https://w.wallhaven.cc/full/d5/wallhaven-d582rg.png
comments:
cover: https://w.wallhaven.cc/full/d5/wallhaven-d582rg.png
toc:
toc_number:
toc_style_simple:
copyright:
copyright_author:
copyright_author_href: 
copyright_url: 
copyright_info: 
mathjax: 
katex:
aplayer:
highlight_shrink:
aside:



---

<meta name="referrer" content="no-referrer"/>

# 1 虚拟机网络编辑器查看

## 1.1 打开虚拟网络编辑器

编辑 >> 虚拟网络编辑器

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200201154504154.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjAwOTQwOA==,size_16,color_FFFFFF,t_70)

## 1.2 查看NAT和[DHCP](https://so.csdn.net/so/search?q=DHCP&spm=1001.2101.3001.7020)信息

部分用户需获取权限，若提示“需要具备管理器特权才能修改网络配置”，则点击“更改设置”并确认

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200201154830625.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjAwOTQwOA==,size_16,color_FFFFFF,t_70)

选定NAT模式，然后点击NAT设置

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200201154841273.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjAwOTQwOA==,size_16,color_FFFFFF,t_70)

可以查看到子网IP、掩码和网关，点击确定

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200201154850456.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjAwOTQwOA==,size_16,color_FFFFFF,t_70)

回到上一步，再点击DHCP设置

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200201154900147.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjAwOTQwOA==,size_16,color_FFFFFF,t_70)

这里注意查看起始IP地址和结束IP地址，如本文中是：

192.168.61.128 192.168.61.254

之后我们需要在linux中设置静态IP，选择的IP地址就在上述区间内选择，此外还有广播地址，这个一般不重要。

## 1.3 修改子网ip和子网掩码（非必须步骤）

若不想使用默认设置， 可以修改子网ip和子网掩码，修改NAT设置和NHCP设置需要做同步变动

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200201154912265.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjAwOTQwOA==,size_16,color_FFFFFF,t_70)

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200201154936524.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjAwOTQwOA==,size_16,color_FFFFFF,t_70)

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200201155036379.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjAwOTQwOA==,size_16,color_FFFFFF,t_70)

# 2 给服务器配置静态IP

## 2.1 右键，选择“Open in Terminal”打开命令窗口

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200201155042333.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjAwOTQwOA==,size_16,color_FFFFFF,t_70)

## 2.2 进行网络配置

```
cd /etc/sysconfig/network-scripts/ #进入network-scripts
ls    #查看当前目录下有哪些文件
vi ifcfg-eno16777736    #编辑配置文件ifcfg-eno16777736，不同的操作系统，这个文件名有所不同，格式一样，用vi打开即可
```

打开文件后，点击 “i”键，进入编辑状态

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200201155213410.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjAwOTQwOA==,size_16,color_FFFFFF,t_70)

按照下面圈红的内容进行修改，IP地址的选择一定要在1.2查询的IP范围内，否则依然连不上网络。

这里为服务器配置的静态ip为192.168.61.254，敲黑板，后面会经常用到请务必记住！

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200201155257833.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjAwOTQwOA==,size_16,color_FFFFFF,t_70)

按 ESC --Shift+Q --输入wq --Enter键，保存并退出。

## 2.2 重启网络，配置生效

```
systemctl restart network.service
```

Redhat6.x和Centos6.x的系统重启网络的命令为：service network restart
重启后，用命令“ip addr”即可查看到我们为服务器配置的ip

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200201155352647.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjAwOTQwOA==,size_16,color_FFFFFF,t_70)

# 3 给服务器配置网络连接

我们可以用“ping www.baidu.com”命令来测试服务器是否可以联网，做完上面的配置后一般还不能联网，还需要有以下配置

## 3.1 设置国内DNS服务器

输入命令 “vi /etc/resolv.conf” ，添加 “nameserver 114.114.114.114”
![在这里插入图片描述](https://img-blog.csdnimg.cn/2020020115550337.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjAwOTQwOA==,size_16,color_FFFFFF,t_70)

依次按 ESC --Shift+Q --输入wq --Enter键，保存并退出。

## 3.2 重启网络，配置生效

```
systemctl restart network.service
```

重启后，即可用“ping www.baidu.com”命令来测试服务器是否可以联网
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200201155515784.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjAwOTQwOA==,size_16,color_FFFFFF,t_70)

## 3.3 启动VM网络服务

若做完上面的操作还不能联网，可前往计算机管理界面，检查VMnetDHCP和[VMware](https://so.csdn.net/so/search?q=VMware&spm=1001.2101.3001.7020) NAT Service是否已启动，若未启动则手动启动

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200201155537678.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjAwOTQwOA==,size_16,color_FFFFFF,t_70)

若VMnetDHCP和VMware NAT Service的属性里启动类型不是自动，可设置为自动并保存

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200201155553870.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjAwOTQwOA==,size_16,color_FFFFFF,t_70)
网络配置完成后，我们就可以使用这个虚拟机了，不过直接在VMware里操作和上传文件不方便，我们推荐使用XShell远程连接服务器。