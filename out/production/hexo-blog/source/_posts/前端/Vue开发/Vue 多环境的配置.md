---
title: Vue 多环境的配置
date: 2023年5月13日21:43:31
tags: Vue
categories: 前端
keywords: 
description: Vue多环境
top_img: https://w.wallhaven.cc/full/m3/wallhaven-m3zjx1.jpg
comments:
cover: https://w.wallhaven.cc/full/m3/wallhaven-m3zjx1.jpg
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



# Vue 多环境的配置

首先 我们得了解 什么是多环境变量，以及多环境变量的作用，下面用一句简短的话来描述

> 我们在vue项目开发中，项目在运行时会根据启动的指令来运行不同的环境，在不同的环境中，我们配置对应所需的变量来满足我们的开发需求，称为多环境变量。

环境一般分为**开发环境**，**测试环境**，**生产环境**

**作用：**

> 一个项目的完整流程，包含开发阶段、打包阶段、测试阶段，与之对应的则是不同的环境，因为每个环境的接口域名、webpack 配置都是不同的，所以在打包构建时，我们需要区分这些环境，这时就用到了环境变量。

### 配置流程：

> 1. [创建文件 包含环境变量的配置信息](https://blog.csdn.net/qq_50975965/article/details/125469585#t1)
> 2. [修改启动命令](https://blog.csdn.net/qq_50975965/article/details/125469585#t2)
> 3. [测试](https://blog.csdn.net/qq_50975965/article/details/125469585#t3)

#### 1.创建文件

> 下面我们就创建 开发环境 和生产环境

文件创建的位置 根目录下
![img](https://img-blog.csdnimg.cn/img_convert/c0a5ffc4995bd4c6877a257c033777f0.png)

**开发环境 配置**

> .env.dev

![img](https://img-blog.csdnimg.cn/img_convert/28ba116bd42a44e4036f99eb421cb09a.png)

**生产环境**

> .env.prod

![img](https://img-blog.csdnimg.cn/img_convert/e12428a80aafeb5b7aeb46290e84b2c1.png)

#### 2.修改启动命令

> 找到 package.json文件
>
> 可以看到 我们修改了serve-dev 和serve-prod

![img](https://img-blog.csdnimg.cn/img_convert/5574473bb357237c2348b58f006ce04a.png)

来到控制台 启动命令吧 下面我将演示 启动开发环境的指令 其他环境类似

![img](https://img-blog.csdnimg.cn/img_convert/aa6916aa4a462e4a1dfd735528f2fccf.png)

为了方便测试 我们来到 main.ts 文件中 输出当前的环境 你们的可能是js 不影响大局

> **[process.env](https://blog.csdn.net/sxy705242410/article/details/110955327?ops_request_misc=%7B%22request%5Fid%22%3A%22165621749516782391815400%22%2C%22scm%22%3A%2220140713.130102334..%22%7D&request_id=165621749516782391815400&biz_id=0&utm_medium=distribute.pc_search_result.none-task-blog-2~all~top_click~default-1-110955327-null-null.142^v24^huaweicloudv2,157^v15^new_3&utm_term=process.env&spm=1018.2226.3001.4187)**的意思是 当前系统的环境变量 可以获取到一些信息

![img](https://img-blog.csdnimg.cn/img_convert/f8eba29de76f5434aed412c35fcc2aa8.png)

#### 3.测试结果

> 我们来到 控制台 查看结果
> ![img](https://img-blog.csdnimg.cn/img_convert/bc958f39af225d2d7f087a7205b2ccbc.png)