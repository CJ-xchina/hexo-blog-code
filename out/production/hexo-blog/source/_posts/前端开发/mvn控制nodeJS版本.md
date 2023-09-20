---
title: mvn控制nodeJS版本
date: 2023年4月23日19:28:51
tags: 
    - Vue开发
    - 环境搭建
categories: 前端
keywords: 
description: 安装mvn控制NodeJs版本，再也不会出现版本问题
top_img: https://w.wallhaven.cc/full/1p/wallhaven-1pd1o9.jpg
comments:
cover: https://w.wallhaven.cc/full/1p/wallhaven-1pd1o9.jpg
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



## 第一步：先清空本地安装的[node](https://so.csdn.net/so/search?q=node&spm=1001.2101.3001.7020).js版本

1.按健win+R弹出窗口，键盘输入[cmd](https://so.csdn.net/so/search?q=cmd&spm=1001.2101.3001.7020),然后敲回车（或者鼠标直接点击电脑桌面最左下角的win窗口图标弹出，输入cmd再点击回车键）

![在这里插入图片描述](https://img-blog.csdnimg.cn/img_convert/2ceb13e1cc7bb8544ca07831576fa007.png)

然后进入命令控制行窗口，并输入where node查看之前本地安装的node的路径

![在这里插入图片描述](https://img-blog.csdnimg.cn/img_convert/cf5559a76dc33265fe241f998be7d28e.png)

2.找到上面找到的路径，将node.exe所在的父目录里面的所有东西都删除

![在这里插入图片描述](https://img-blog.csdnimg.cn/img_convert/52be88af696a00930a577ee141a5ca4e.png)

3.为了彻底删除之前安装的node.js，鼠标点击电脑左面最左下角的win窗口图标弹出，输入“控制面板”再点击回车键进入，进入控制面板后，找到所安装的node.js并卸载。

## 第二步：安装[nvm](https://so.csdn.net/so/search?q=nvm&spm=1001.2101.3001.7020)管理工具（先关掉360等软件，不然会弹出警告！）

1.从官网下载安装包 https://github.com/coreybutler/nvm-windows/releases，下载红框里面的那个

![在这里插入图片描述](https://img-blog.csdnimg.cn/img_convert/641c4471bb2912d52cee46fe5e93f2ed.png)

2.将下载下来的压缩包进行解压（随便解压到任一你喜欢的位置），解压文件夹里面是一个.exe文件

![在这里插入图片描述](https://img-blog.csdnimg.cn/img_convert/9a173a0e26b00828ebf61c73df0b8179.png)

3.开始进行nvm安装：
(1) 鼠标双击nvm-setup.exe文件，选择“我接受…”那一行，点击next

![在这里插入图片描述](https://img-blog.csdnimg.cn/img_convert/cf4de1810aca5705a9a5d37e54f53fae.png)

(2) 可以根据自身情况自定义选择路径盘，**路径不要出现空格或中文符号**（路径最好是在路径盘的根目录下，如C盘、D盘下的根目录），我自己选择D盘根目录。选好后点击next

![在这里插入图片描述](https://img-blog.csdnimg.cn/img_convert/fff7f5f7c38bb327382742d44c70cf9f.png)

(3) 选择node.js的安装位置，可以根据自身情况自定义选择路径盘，**路径不要出现空格或中文符号**（路径最好是在路径盘的根目录下新建一个文件夹，如C盘、D盘下的根目录），我自己在D盘根目录下新建一个nodejs文件夹。选好后点击next

![在这里插入图片描述](https://img-blog.csdnimg.cn/img_convert/40387c70d12d2a545ee3fd0e1b3520db.png)

(4) 最后一步，点击install即可安装完成

![在这里插入图片描述](https://img-blog.csdnimg.cn/img_convert/058bd7541fc4f4654f48f0f899c0045c.png)

2.nvm安装完成后，检验是否安装成功，进入命令控制行窗口（进入方法见前面），
输入命令nvm v查看，如果出现版本号，即安装成功（如果安装不成功，查看之前自己安装的node.js有没有删除彻底、安装nvm工过程有没有漏掉什么！）。

![在这里插入图片描述](https://img-blog.csdnimg.cn/img_convert/ac1e2e3a4b207c8371dbe8a86c108c60.png)

3.接下来就是安装node.js版本

(1) 输入命令行nvm ls anaillable查看可用的node.js版本号

![在这里插入图片描述](https://img-blog.csdnimg.cn/img_convert/43f295cea509637126df05ee7033de46.png)

(2) 输入命令行nvm install [node版本](https://so.csdn.net/so/search?q=node版本&spm=1001.2101.3001.7020)号(例如：nvm install 12.17.0)即可安装对应版本以及自动安装对应的npm版本。除了上面显示的node.js版本，其他版本号也可以下载，只不过有些可以准确下载，有些会出现npm版本不会自动下载。

![在这里插入图片描述](https://img-blog.csdnimg.cn/img_convert/bed4e06b2a5494ce5807067ded8535be.png)

(3) 安装成功后，输入命令行nvm use node版本号（例如：nvm use 12.17.0）即可选择你本地所使用的Node.js版本，使用此命

令行可以根据你自己的需要随意切换node.js版本运行。

![在这里插入图片描述](https://img-blog.csdnimg.cn/img_convert/4fd9e94bc896739f292f1cf033fbdec5.png)
使用管理员身份运行（框搜索cmd，右键选择管理员身份运行）cmd再执行nvm use node版本号。

安装完成后可以分别输入命令行node -v和npm -v，检验node.js以及对应npm是否安装成功，如果可以显示版本号这说明安装成功。

![在这里插入图片描述](https://img-blog.csdnimg.cn/img_convert/7e22db38ec61b56011cd931bcba2f163.png)
(4) 输入命令行nvm ls查看你安装的所有node.js版本号，以及你当前所选择的node.js运行版本

![在这里插入图片描述](https://img-blog.csdnimg.cn/img_convert/2a5436a35ebd0031f74c985feaac504d.png)

(4) 如果想删除某node.js版本的话，输入命令行nvm uninstall node版本号（例如：nvm use 12.17.0）即可删除对应版本