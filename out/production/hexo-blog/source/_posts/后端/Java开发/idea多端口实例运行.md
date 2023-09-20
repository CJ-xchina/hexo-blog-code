---
title: idea多端口实例运行
date: 2023年5月13日22:08:26
tags: Java开发
categories: 后端
keywords:
description: idea多端口运行是我一直以来的痛，因为idea默认运行实例不支持多端口运行，这也让我踩了很多的坑
top_img: https://w.wallhaven.cc/full/1p/wallhaven-1ppld1.jpg
comments:
cover: https://w.wallhaven.cc/full/1p/wallhaven-1ppld1.jpg
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

## 1 问题场景

我们在进行新项目开发的时候， 可能做完一个新的模块功能并自测通过之后， 我们希望测试人员能帮我跑一些[单元测试用例](https://so.csdn.net/so/search?q=单元测试用例&spm=1001.2101.3001.7020)来进行测试验证， 但是我们又需要在此基础上技术开发新的功能， 这是我们就需要在我们的开发PC上同时运行多实例来保证开发及内部测试的需求，下面就说说怎么在IDEA上实现这个同项目多实例运行

## 2 环境准备

- JDK 1.8
- IDEA 2021.3.2

## 3 配置过程

### 3.1 运行实例配置

修改当前项目的启动配置
![在这里插入图片描述](https://img-blog.csdnimg.cn/2c206beeb9a44f95a9159e5f1ae67b8e.png)
设置项目实例名称
![在这里插入图片描述](https://img-blog.csdnimg.cn/cdb0b9b98b43415ba841a5bf38c8816b.png)
开启多实例配置
![在这里插入图片描述](https://img-blog.csdnimg.cn/98db3121e54440b383f9df973682d003.png)
设置当前实例的运行端口
![在这里插入图片描述](https://img-blog.csdnimg.cn/bca5caab4cfe4d86a354c33cc1b02996.png)
复制当前实例
![在这里插入图片描述](https://img-blog.csdnimg.cn/aea48a907e0a49e8abc0a82126a36219.png)
修改复制实例的名称及运行端口
![在这里插入图片描述](https://img-blog.csdnimg.cn/1b1b263407824ff2a74c0584aec05e50.png)

### 3.2 设置运行组

新建一个运行组
![在这里插入图片描述](https://img-blog.csdnimg.cn/3ee472dd63014acc9fc2e59cc37753aa.png)
![在这里插入图片描述](https://img-blog.csdnimg.cn/674cbd4e2a7144bb9345bfdb289b8447.png)
修改运行组名称和运行组中的启动实例
![在这里插入图片描述](https://img-blog.csdnimg.cn/083c2929546a43619890167c0f0acbd1.png)

### 3.3 运行组启动测试

通过以上操作，基本就配置好了， 这里我们来运行一下， 看看两个服务是否都可以正常运行起来。
![在这里插入图片描述](https://img-blog.csdnimg.cn/f173f2643dba42e9b4b8892915105a42.png)
AppRun-8009成功启动
![在这里插入图片描述](https://img-blog.csdnimg.cn/11c9748207c843dd955e8f670ca2cbab.png)
AppRun-8010成功启动
![在这里插入图片描述](https://img-blog.csdnimg.cn/594e0c15c25141a8bd51fed0f7c11175.png)

OK, 配置结束， 之后让测试在8010端口进行测试， 我们可以在8009端口继续进行新的业务模块功能开发，匹配不会互相影响。当然正常的我们应该打包到测试环境提供一个稳定的环境让测试人员进行测试，咱们这只是内部转测试，还没到集成阶段， 只是能尽早让测试人员介入到项目中的一种解决方案，每个公司可能对于[项目管理](https://so.csdn.net/so/search?q=项目管理&spm=1001.2101.3001.7020)的要求都不一样，根据实际情况调整处理就好了。

## 4 多环境运行配置

在项目开发中，难免会遇上需要配置多个运行环境，例如开发环境、测试环境、上线环境等等，如果需要IDEA能够在不同端口运行不同的环境，则需要进行以下配置，这里我的环境：

![image-20230513221053596](https://typora-md-bucket.oss-cn-beijing.aliyuncs.com/image-20230513221053596.png)

在运行实例配置中，只需要指定该实例所运行的环境即可：

![image-20230513221202978](https://typora-md-bucket.oss-cn-beijing.aliyuncs.com/image-20230513221202978.png)



