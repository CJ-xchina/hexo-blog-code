---
title: Vue request配置（前后端跨域）
date: 2023年4月24日17:04:51
tags: 
    - Java开发
    - Vue开发
categories: 前端
keywords:
description:
top_img: 
comments:
cover:
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

## 创建配置属性文件

- 在根目录下创建.env.development 文件放入request请求配置

![image-20230424170855986](https://typora-md-bucket.oss-cn-beijing.aliyuncs.com/image-20230424170855986.png)

- 在改文件下放入访问的地址

```bat
# 开发模式标识
ENV = 'development'

# 需要访问的后端地址
VUE_APP_BASE_API = 'http://localhost:8090'

# vue-cli uses the VUE_CLI_BABEL_TRANSPILE_MODULES environment variable,
# to control whether the babel-plugin-dynamic-import-node plugin is enabled.
# It only does one thing by converting all import() to require().
# This configuration can significantly increase the speed of hot updates,
# when you have a large number of pages.
# Detail:  https://github.com/vuejs/vue-cli/blob/dev/packages/@vue/babel-preset-app/index.js
VUE_CLI_BABEL_TRANSPILE_MODULES = true

```

## 配置vue.js解决跨域问题

```javascript
devServer: {
  port: port,
  open: true,
  overlay: {
    warnings: false,
    errors: true
  },
  proxy: {
     // 起别名
    '/api': {
      // 访问目标地址
      target: 'localhost:8090',
      // 开启跨域访问
      changeOrigin: true,
      // 别名置空
      pathRewrite: { '^/api': '' }
    }
  },
  after: require('./mock/mock-server.js')
},
```

## 配置request.js

```javascript
import axios from 'axios'
import { Message } from 'element-ui'
import store from '@/store'
import { getToken } from '@/utils/auth'

// create an axios instance
const service = axios.create({
  baseURL: process.env.VUE_APP_BASE_API,
  withCredentials: true, // send cookies when cross-domain requests
  timeout: 5000 // request timeout
})

// request interceptor
service.interceptors.request.use(
  config => {
    // do something before request is sent

    if (store.getters.token) {
      // let each request carry token
      // ['X-Token'] is a custom headers key
      // please modify it according to the actual situation
      config.headers['X-Token'] = getToken()
    }
    return config
  },
  error => {
    // do something with request error
    console.log(error) // for debug
    return Promise.reject(error)
  }
)

// 2.请求拦截器
service.interceptors.request.use(config => {
  config.data = JSON.stringify(config.data)
  config.headers = {
    'Content-Type': 'application/json'
  }

  return config
}, error => {
  Promise.reject(error)
})

service.interceptors.response.use(response => {
  if (response.data.success) {
    if (response.data.msg !== '') {
      Message.success({ type: 'success', message: response.data.msg })
      // 出错则不返回数据
      return response.data
    }
  } else {
    Message.error({ type: 'error', message: response.data.msg })
  }
}, error => {
  if (error && error.response) {
    switch (error.response.status) {
      case 400:
        error.message = '错误请求'
        break
      case 401:
        error.message = '未授权，请重新登录'
        break
      case 403:
        error.message = '拒绝访问'
        break
      case 404:
        error.message = '请求错误,未找到该资源'
        /*        window.location.href = "/NotFound"*/
        break
      case 405:
        error.message = '请求方法未允许'
        break
      case 408:
        error.message = '请求超时'
        break
      case 500:
        error.message = '服务器端出错'
        break
      case 501:
        error.message = '网络未实现'
        break
      case 502:
        error.message = '网络错误'
        break
      case 503:
        error.message = '服务不可用'
        break
      case 504:
        error.message = '网络超时'
        break
      case 505:
        error.message = 'http版本不支持该请求'
        break
      default:
        error.message = `连接错误${error.response.status}`
    }
  } else {
    if (JSON.stringify(error).includes('timeout')) {
      Message.error('服务器响应超时，请刷新当前页')
    }
    error.message = '连接服务器失败'
  }

  Message.error(error.message)

  return Promise.resolve(error.response)
})
// 4.导入文件
export default service

```

## 编写http.js

```javascript
/** **   http.js   ****/
// 导入封装好的axios实例
import request from './request'
const http = {
  /**
   * methods: 请求
   * @param url 请求地址
   * @param params 请求参数
   */
  get(url, params) {
    const config = {
      method: 'get',
      url: url
    }
    if (params) config.params = params
    return request(config)
  },
  post(url, params) {
    const config = {
      method: 'post',
      url: url
    }
    if (params) config.data = params
    return request(config)
  },
  put(url, params) {
    const config = {
      method: 'put',
      url: url
    }
    if (params) config.params = params
    return request(config)
  },
  delete(url, params) {
    const config = {
      method: 'delete',
      url: url
    }
    if (params) config.params = params
    return request(config)
  }

}
export default http
```

## 编写api接口

```javascript
import http from '@/utils/http'

export function createWallet() {
  return http.post('/createKeys')
}
```

## SpringBoot开启跨域访问

```java
package com.dce.blockchain.web.config;



/**
 * @author admin
 * @version 1.0.0
 * @ClassName portalCorsfilter.java
 * @Description 远程访问
 * @createTime 2021年09月18日 22:58:00
 */
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.Ordered;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.filter.CorsFilter;

@Configuration
public class CorsConfig {
    private CorsConfiguration buildConfig() {
        CorsConfiguration corsConfiguration = new CorsConfiguration();
        corsConfiguration.addAllowedOrigin("*"); // 1允许任何域名使用
        corsConfiguration.addAllowedHeader("*"); // 2允许任何头
        corsConfiguration.addAllowedMethod("*"); // 3允许任何方法（post、get等）
        corsConfiguration.setAllowCredentials(true); // 允许cookies跨域
        return corsConfiguration;
    }

    @Bean
    public FilterRegistrationBean corsFilter() {
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", buildConfig());
        FilterRegistrationBean filterRegistrationBean = new FilterRegistrationBean(new CorsFilter(source));
        // 设置 Filter 的优先级为最高优先级(如果有多个过滤器这些过滤器会有一个先后顺序的问题)
        filterRegistrationBean.setOrder(Ordered.HIGHEST_PRECEDENCE);
        return filterRegistrationBean;
    }
}
```