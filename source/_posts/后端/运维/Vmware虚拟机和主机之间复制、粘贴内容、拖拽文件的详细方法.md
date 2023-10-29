---
title: VMware虚拟机与主机之间不能复制粘贴问题
date: 2023年10月28日13:49:01
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

##### 1. 查看vmware Tools是否安装

打开虚拟机 ，点击上方导航栏 ‘虚拟机’ 查看`VMware Tools`是否安装，如果未安装，安装即可
![在这里插入图片描述](https://img-blog.csdnimg.cn/02d18881609b4f31b1256ee1a944590b.png)

##### 2. 命令行解决

如果第一种方法不行，可以试试第二种方法

输入命令

```bash
cd /usr/bin
```

切换到 `/usr/bin` 目录下

![在这里插入图片描述](https://img-blog.csdnimg.cn/28567ec76a8543f597995c97663598ed.png)
输入命令

```bash
vmware-user
```

![在这里插入图片描述](https://img-blog.csdnimg.cn/64c4ac1d23b643c78e993e11c727bce3.png)

##### 3.重新安装组件

如果前两种方法都不行，那就试试第三种
输入命令

```bash
sudo apt autoremove open-vm-tools
```

输入命令：

```bash
sudo apt install open-vm-tools
```

输入命令：

```bash
sudo apt install open-vm-tools-desktop
```