---
title: Docker
date: 2023年10月27日12:55:44
tags: 
    - Docker
categories: 中间件
keywords: 
description:
top_img: https://typora-md-bucket.oss-cn-beijing.aliyuncs.com/a0cc1dec07a243808bcd51a54425e89a.png
comments:
cover: https://typora-md-bucket.oss-cn-beijing.aliyuncs.com/a0cc1dec07a243808bcd51a54425e89a.png
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

# 一、Docker安装

## Linux环境

<font color='red'>**本文以Ubuntu20.05系统为例安装docker**</font>

### 检查卸载老版本docker

ubuntu下自带了docker的库，不需要添加新的源。
但是ubuntu自带的docker版本太低，需要先卸载旧的再安装新的。

注：docker的旧版本不一定被称为docker，docker.io 或 docker-engine也有可能，所以我们卸载的命令为：

```powershell
apt-get remove docker docker-engine docker.io containerd runc
```

如果不能正常卸载，出现如下情况，显示无权限时，需要添加管理员权限才可进行卸载：

![在这里插入图片描述](https://img-blog.csdnimg.cn/f0c4d4ec2b57475a820c3031e4645b05.png)
我们就需要使用`sudo apt-get remove docker docker-engine docker.io containerd runc`命令使用[root权限](https://so.csdn.net/so/search?q=root权限&spm=1001.2101.3001.7020)来进行卸载。

### 正式安装

**更新软件包**

在终端中执行以下命令来更新Ubuntu软件包列表和已安装软件的版本:

```bash
sudo apt update
sudo apt upgrade
```

**安装docker依赖**

Docker在Ubuntu上依赖一些软件包。执行以下命令来安装这些依赖:

```bash
apt-get install ca-certificates curl gnupg lsb-release
```

**添加Docker官方GPG密钥**

执行以下命令来添加Docker官方的GPG密钥:

```bash
curl -fsSL http://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -
```

结果如下：

![在这里插入图片描述](https://img-blog.csdnimg.cn/823b3a9fcf314de380b686071f385f9a.png)

**添加Docker软件源**

执行以下命令来添加Docker的软件源:

```bash
sudo add-apt-repository "deb [arch=amd64] http://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
```

注：该命令需要使用root权限

![在这里插入图片描述](https://img-blog.csdnimg.cn/d714625bc7394baf8f6d534ca3a69252.png)

**安装docker**

执行以下命令来安装Docker:

```bash
apt-get install docker.io
```

**配置用户组（可选）**

默认情况下，只有root用户和docker组的用户才能运行Docker命令。我们可以将当前用户添加到docker组，以避免每次使用Docker时都需要使用sudo。命令如下：

```bash
sudo usermod -aG docker $USER
```

### 运行docker

我们可以通过启动`docker`来验证我们是否成功安装。命令如下：

```bash
systemctl start docker
```

**安装工具**

```bash
apt-get -y install apt-transport-https ca-certificates curl software-properties-common
```

**重启docker**

```bash
service docker restart
```

**验证是否成功**

```bash
sudo docker run hello-world
```

运行命令后，结果如下：

![在这里插入图片描述](https://img-blog.csdnimg.cn/52fc9e6c6cc74cb9a5ff590a8761f6e1.png)

因为我们之前没有拉取过`hello-world`，所以运行命令后会出现本地没有该镜像，并且会自动拉取的操作。

**查看版本**

我们可以通过下面的命令来查看`docker`的版本

```bash
sudo docker version
```

结果如下：

![在这里插入图片描述](https://img-blog.csdnimg.cn/c4cc99c53bc44b9080e11957c095c613.png)

**查看镜像**

上面我们拉取了hello-world的镜像，现在我们可以通过命令来查看镜像，命令如下：

```bash
sudo docker images  
```

结果如下图：

![在这里插入图片描述](https://img-blog.csdnimg.cn/9703513287ab4a3cbf6dfcf0349aaada.png)

出现上述情况，即表示我们成功在Ubuntu系统上安装了docker。

