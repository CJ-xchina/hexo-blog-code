---
title: Websocket实现前后端实时通信
date: 2023年4月25日18:32:06
tags: Java开发 Vue开发
categories: 后端
keywords: 
description:
top_img: https://w.wallhaven.cc/full/l8/wallhaven-l83o92.jpg
comments:
cover: https://w.wallhaven.cc/full/l8/wallhaven-l83o92.jpg
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

# WebSocket简介

### 什么是[websocket](https://so.csdn.net/so/search?q=websocket&spm=1001.2101.3001.7020)

- WebSocket 是一种网络通信协议。RFC6455定义了它的通信标准。
- WebSocket是HTML5下一种新的协议（websocket协议本质上是一个基于tcp的协议）
- 它实现了浏览器与服务器[全双工](https://so.csdn.net/so/search?q=全双工&spm=1001.2101.3001.7020)通信，能更好的节省服务器资源和带宽并达到实时通讯的目的
- http是一种无状态，无连接，单向的[应用层协议](https://so.csdn.net/so/search?q=应用层协议&spm=1001.2101.3001.7020)，它采用了请求/响应模型，通信请求只能由客户端发起，服务端对请求做出应答处理。这样的弊端显然是很大的，只要服务端状态连续变化，客户端就必须实时响应，都是通过javascript与ajax进行轮询，这样显然是非常麻烦的，同时轮询的效率低，非常的浪费资源(http一直打开，一直重复的连接)。
- 于是就有了websocket，Websocket是一个持久化的协议，它是一种全面双工通讯的网络技术，任意一方都可以建立连接将数据推向另一方，websocket只需要建立一次连接，就可以一直保持

### websocket 原理

- websocket约定了一个通信的规范，通过一个握手的机制，客户端和服务器之间能建立一个类似tcp的连接，从而方便它们之间的通信
- 在websocket出现之前，web交互一般是基于http协议的短连接或者长连接
- websocket是一种全新的协议，不属于http无状态协议，协议名为"ws"
- 说它是TCP传输，主要体现在建立长连接后，浏览器是可以给服务器发送数据，服务器也可以给浏览器发送请求的。当然它的数据格式并不是自己定义的，是在要传输的数据外层有ws协议规定的外层包的。

### websocket与http的关系

- **相同点：**
- **都是基于tcp的，都是可靠性传输协议，都是应用层协议**
- **不同点：**
- **WebSocket是双向通信协议，模拟Socket协议，可以双向发送或接受信息**
- **HTTP是单向的**
- **WebSocket是需要浏览器和服务器握手进行建立连接的**
- **而http是浏览器发起向服务器的连接，服务器预先并不知道这个连接**
- **联系**
- **WebSocket在建立握手时，数据是通过HTTP传输的。但是建立之后，在真正传输时候是不需要HTTP协议的**
- **关系图**

**![img](https://img-blog.csdnimg.cn/11cd72c1e9434dcda18a1dbf059f5fb1.png)**

![img](https://img-blog.csdnimg.cn/ed6e4f8cf2ea4de7a33ccc282f18a0f1.png)



# 代码实现

## 后端代码

```java
package com.dce.blockchain.websocket;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.CopyOnWriteArraySet;

@Slf4j
@Component
// 定义连接时候的 url
@ServerEndpoint("/websocket/{key}")
public class WebSocketServer {

    //与某个客户端的连接会话，需要通过它来给客户端发送数据
    private Session session;

    private static CopyOnWriteArraySet<WebSocketServer> webSockets = new CopyOnWriteArraySet<>();
    //用来存放每个客户端对应的WebSocket对象。
    private static Map<String, Session> sessionPool = new HashMap<>();

    /**
     * 连接成功后调用的方法
     *
     * @param session
     * @param key key用来标记一个对话，一个对话对应一个key，key通过路径变量传递
     */
    @OnOpen
    public void onOpen(Session session, @PathParam("key") String key) throws IOException {
        //key为前端传给后端的token
        this.session = session;
        // 从token中获取到userid当做区分websocket客户端的key
        sessionPool.put(String.valueOf(key), session);
        if (sessionPool.get(String.valueOf(key)) == null) {
            webSockets.add(this);
        }
        webSockets.add(this);
        log.info("webSocket连接成功");
        log.info("WebSocket有新的连接，连接总数为：" + webSockets.size());
    }

    /**
     * 连接关闭调用的方法
     */
    @OnClose
    public void onClose() {
        webSockets.remove(this);
        log.info("webSocket连接关闭");
    }

    /**
     * 收到客户端消息后调用的方法，根据业务要求进行处理，这里就简单地将收到的消息直接群发推送出去
     *
     * @param message 客户端发送过来的消息
     */
    @OnMessage
    public void onMessage(String message) {
        log.info("WebSocket收到客户端消息：" + message);
    }

    /**
     * 发生错误时的回调函数
     *
     * @param session
     * @param error
     */
    @OnError
    public void onError(Session session, Throwable error) {
        log.error("发生错误");
        error.printStackTrace();
    }

    /**
     * 单点消息发送
     * @param key 发送session 对应的key
     * @param message
     */
    public static void sendTextMessage(String key, String message) {
        Session session = sessionPool.get(key);
        if (session != null) {
            try {
                session.getBasicRemote().sendText(message);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
```

## 前端代码

```javascript
// 提示信息
import { Message } from 'element-ui'
// 引入token 解析用户id在后端处理
import { getToken } from '@/utils/auth'

// 后端ip端口
var url = 'ws://localhost:8090/websocket/'

var ws
var tt
var lockReconnect = false // 避免重复连接
var clientId = getToken() // cookies中获取token值

var websocket = {
// 建立连接
  Init: function(clientId) {
    if ('WebSocket' in window) {
      ws = new WebSocket(url + clientId)
    } else if ('MozWebSocket' in window) {
      ws = new MozWebSocket(url + clientId)
    } else {
      // console.log('您的浏览器不支持 WebSocket!')
      return
    }
    // websocket 生命周期根据websocket状态自己会执行
    // websocket 成功 失败 错误 断开 这里会自动执行
    // 这个方法后端通过send调用 这个方法会执行和接收参数
    ws.onmessage = function(e) {
      // console.log('接收消息:' + e.data)
      var data = JSON.parse(e.data)
      console.log(data)
      heartCheck.start()
      if (data.msg !== '' && data.msg !== undefined) {
        Message({
          message: e.data.msg,
          type: 'success'
        })
      }
      // messageHandle(e.data)
    }

    ws.onclose = function() {
      console.log('连接已关闭')
      Message({
        message: 'webSocket连接已经关闭',
        type: 'error'
      })
      reconnect(clientId)
    }

    ws.onopen = function() {
      // console.log('连接成功')
      Message({
        message: 'webSocket连接成功',
        type: 'success'
      })
      heartCheck.start()
    }

    ws.onerror = function(e) {
      // console.log('数据传输发生错误')
      Message({
        message: '数据传输发生错误',
        type: 'error'
      })
      reconnect(clientId)
    }
  },
  // 我们单独写了一个方法 调用ws的关闭方法，这样就可以在退出登录的时候主动关闭连接
  // 关闭连接
  onClose: function() {
    console.log('主动关闭连接！')
    // 关闭websocket连接和关闭断开重连机制
    lockReconnect = true
    // 调用 上面的websocket关闭方法
    ws.close()
  },
  // 前端的send给后端发信息
  Send: function(sender, reception, body, flag) {
    const data = {
      sender: sender,
      reception: reception,
      body: body,
      flag: flag
    }
    const msg = JSON.stringify(data)
    // console.log('发送消息：' + msg)
    ws.send(msg)
  },
  // 返回ws对象
  getWebSocket() {
    return ws
  },
  // websocket 自带的状态码意思提示
  getStatus() {
    if (ws.readyState === 0) {
      return '未连接'
    } else if (ws.readyState === 1) {
      return '已连接'
    } else if (ws.readyState === 2) {
      return '连接正在关闭'
    } else if (ws.readyState === 3) {
      return '连接已关闭'
    }
  }
}

// 刷新页面后需要重连
if (window.performance.navigation.type === 1 && getToken() != null) {
  // 刷新后重连
  // reconnect(clientId);
  websocket.Init(clientId)
  // 如果websocket没连接成功，则开始延迟连接
  if (ws == null) {
    reconnect(clientId)
  }
}

export default websocket

// 根据消息标识做不同的处理
function messageHandle(message) {
  const msg = JSON.parse(message)
  switch (msg.flag) {
    case 'command':
      // console.log('指令消息类型')
      break
    case 'inform':
      // console.log('通知')
      break
    default:
    // console.log('未知消息类型')
  }
}
// 重连方法 刷新页面 连接错误 连接关闭时调用
function reconnect(sname) {
  if (lockReconnect) {
    return
  }
  lockReconnect = true
  // 没连接上会一直重连，设置延迟避免请求过多
  tt && clearTimeout(tt)
  tt = setTimeout(function() {
    // console.log('执行断线重连...')
    websocket.Init(sname)
    lockReconnect = false
  }, 4000)
}
```

在需要使用的页面，编写下面的代码：

```javascript
export default {
     created() {
          websocket.Init('mine')
          var wb = websocket.getWebSocket()
          wb.onmessage = this.handleMessage
     },
     methods: {
          handleMessage(e) {
               // console.log('接收消息:' + e.data)
               var data = JSON.parse(e.data)
               console.log(data)
               if (data.msg !== '') {
                    Message({
                         message: data.msg,
                         type: 'success'
                    })
               }
               if (data.code === '00') {

               }else if (data.code === '01'){
                    this.sha256Attempts = data.data
               }
               // messageHandle(e.data)
          },
     }
}
```

注意这里定义session的key为mine
