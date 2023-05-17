---
title: Linux系统中安装Elasticsearch并实现开机自动启动
date: 2023年5月15日16:26:51
tags: ElasticSearch,数据库
categories: 中间件
keywords:
description: 
top_img: https://img1.baidu.com/it/u=950222251,316656728&fm=253&fmt=auto&app=138&f=JPG?w=967&h=500
comments:
cover: https://img1.baidu.com/it/u=950222251,316656728&fm=253&fmt=auto&app=138&f=JPG?w=967&h=500
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

## 安装环境

- Linux Centos 7
- Java 1.8环境
- Elasticsearch 7.5.0

## 安装 JAVA 运行环境

Elasticsearch 是用JAVA实现的，必须要有JDK支持，所以必须先[安装JDK](https://so.csdn.net/so/search?q=安装JDK&spm=1001.2101.3001.7020)。

```bash
yum update -y
yum install -y java-1.8.0-openjdk-devel.x86_64
java -vaersion
which java
```

## 安装 Elasticsearch

### 下载安装包

Elasticsearch 去官网直接[下载](https://elasticsearch.cn/download/)，本人使用的是 7.5.0 版本；

```bash
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.10.2-linux-x86_64.tar.gz
```

### 解压安装包

```bash
tar -zxvf elasticsearch-7.10.2-linux-x86_64.tar.gz -C /usr/local/
```

### 创建es用户

从5.0开始 elasticsearch 安全级别提高了 不允许采用root帐号启动 所以我们要添加一个用户用来启动 elasticsearch，创建es用户并给[elasticsearch安装](https://so.csdn.net/so/search?q=elasticsearch安装&spm=1001.2101.3001.7020)目录赋予权限。

```bash
groupadd es
useradd es -g es
chown -R es:es /usr/local/elasticsearch-7.5.0/
```

### 修改配置文件

#### 修改elasticsearch.yml配置文件

切换到es用户，修改 elasticsearch.yml 配置文件：

```bash
su es
vi /usr/local/elasticsearch-7.10.2/config/elasticsearch.yml
```

配置文件修改参考：

```bash
#集群的名称
cluster.name: logs-app
#节点名称,其余两个节点分别为node-1 和node-3
node.name: node-1
#指定该节点是否有资格被选举成为master节点，默认是true，es是默认集群中的第一台机器为master，如果这台机挂了就会重新选举master
node.master: true
#允许该节点存储数据(默认开启)
node.data: true
#设置为true来锁住内存。因为内存交换到磁盘对服务器性能来说是致命的，当jvm开始swapping时es的效率会降低，所以要保证它不swap
bootstrap.memory_lock: true
#绑定的ip地址
network.host: 0.0.0.0
#设置对外服务的http端口，默认为9200
http.port: 9200
# 设置节点间交互的tcp端口,默认是9300
transport.tcp.port: 9300
#Elasticsearch将绑定到可用的环回地址，并将扫描端口9300到9305以尝试连接到运行在同一台服务器上的其他节点。 
```

#### 修改jvm.options配置文件

优化elasticsearch占用内存，修改配置文件jvm.options

```bash
-Xms32g
-Xmx32g
-XX:+UseConcMarkSweepGC
-XX:CMSInitiatingOccupancyFraction=75
-XX:+UseCMSInitiatingOccupancyOnly
-Des.networkaddress.cache.negative.ttl=10
-XX:+AlwaysPreTouch
-Xss1m
-Djava.awt.headless=true
-Dfile.encoding=UTF-8
-Djna.nosys=true
-XX:-OmitStackTraceInFastThrow
-Dio.netty.noUnsafe=true
-Dio.netty.noKeySetOptimization=true
-Dio.netty.recycler.maxCapacityPerThread=0
-Dlog4j.shutdownHookEnabled=false
-Dlog4j2.disable.jmx=true
-Djava.io.tmpdir=${ES_TMPDIR}
-XX:+HeapDumpOnOutOfMemoryError
-XX:HeapDumpPath=data
-XX:ErrorFile=logs/hs_err_pid%p.log

## JDK 8 GC logging
8:-XX:+PrintGCDetails
8:-XX:+PrintGCDateStamps
8:-XX:+PrintTenuringDistribution
8:-XX:+PrintGCApplicationStoppedTime
8:-Xloggc:logs/gc.log
8:-XX:+UseGCLogFileRotation
8:-XX:NumberOfGCLogFiles=32
8:-XX:GCLogFileSize=64m

## JDK 9 GC logging
9-:-Xlog:gc*,gc+age=trace,safepoint:file=logs/gc.log:utctime,pid,tags:filecount=32,filesize=64m
9-:-Djava.locale.providers=COMPAT

## JDK 10 GC logging
10-:-XX:UseAVX=2 
```

### 配置elasticsearch启动文件和启动配置

创建elasticsearch的系统启动服务文件，进入到 cd /etc/init.d 目录

```bash
cd /etc/init.d    　　【进入到目录】
vi elasticsearch 　　 【创建elasticsearch系统启动服务文件】
```

编写启动脚本

```bash
#!/bin/bash
#chkconfig: 345 63 37
#description: elasticsearch
#processname: elasticsearch-7.10.2

# 这个目录是你Es所在文件夹的目录
export ES_HOME=/usr/local/elasticsearch-7.10.2
case $1 in
start)
    su es<<!
    cd $ES_HOME
    ./bin/elasticsearch -d -p pid
    exit
!
    echo "elasticsearch is started"
    ;;
stop)
    pid=`cat $ES_HOME/pid`
    kill -9 $pid
    echo "elasticsearch is stopped"
    ;;
restart)
    pid=`cat $ES_HOME/pid`
    kill -9 $pid
    echo "elasticsearch is stopped"
    sleep 1
    su es<<!
    cd $ES_HOME
    ./bin/elasticsearch -d -p pid
    exit
!
    echo "elasticsearch is started"
    ;;
*)
    echo "start|stop|restart"
    ;;
esac
exit 0
```

修改文件权限

```bash
chmod 777 elasticsearch
```

添加和删除服务并设置启动方式

```bash
# 添加系统服务
chkconfig --add elasticsearch
# 删除系统服务
chkconfig --del elasticsearch
```

关闭和启动服务

```bash
# 启动服务
service elasticsearch start
# 停止服务
service elasticsearch stop
# 重启服务
service elasticsearch restart
```

设置服务是否开机启动

```bash
# 开启开机自动启动服务
chkconfig elasticsearch on
# 关闭开机自动启动服务
chkconfig elasticsearch off
```

查看当前的开机启动服务命令

```bash
chkconfig --list
```

### 验证下服务是否正常运行

```
curl  http://127.0.0.1:9200
```

## 安装常见问题

在启动ES时可能会出现几种错误情况

#### max file descriptors [4096] for elasticsearch process is too low, increase to at least [65535]

修改/etc/security/limits.conf文件，

```bash
[es@localhost root]# su root
vi /etc/security/limits.conf
```

在文件末尾添加如下：

```bash
*               hard    nofile          65536
*               soft    nofile          65536
*               hard    nproc           4096
*               soft    nproc           4096
*               hard    memlock         unlimited
*               soft    memlock         unlimited
```

#### max number of threads [3818] for user [es] is too low, increase to at least [4096]

修改/etc/security/limits.d/20-nproc.conf文件，

```bash
[es@localhost root]# su root
vi /etc/security/limits.d/20-nproc.conf
```

修改内容如下：

```bash
*          soft    nproc     4096
*          hard    nproc     4096
root       soft    nproc     unlimited
```

#### memory locking requested for elasticsearch process but memory is not locked

修改/etc/security/limits.conf文件，

```bash
[es@localhost root]# su root
vi /etc/security/limits.conf
```

在文件末尾添加如下：

```bash
*               hard    memlock         unlimited
*               soft    memlock         unlimited
```

#### max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144]

/etc/sysctl.conf文件末尾添加 vm.max_map_count = 262144

```bash
[es@localhost root]# su root
vi /etc/sysctl.conf
# 立即生效
sudo sysctl -p /etc/sysctl.conf  
```

修改内容如下：

```bash
#
# For more information, see sysctl.conf(5) and sysctl.d(5).
vm.max_map_count = 262144
```

#### the default discovery settings are unsuitable for production use; at least one of [discovery.seed_hosts, discovery.seed_providers, cluster.initial_master_nodes] must be configured

修改 elasticsearch.yml，取消注释保留一个节点cluster.initial_master_nodes: [“node-1”]这个设置，这里的node-1是上面一个默认的记得打开就可以了重启ES