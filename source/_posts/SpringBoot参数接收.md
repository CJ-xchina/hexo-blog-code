---
title: SpringBoot参数接收
date: 2023年5月12日16:21:18
tags: Java开发
categories: 后端
keywords: 
description: 总结SpringBoot参数接收的方法
top_img: 
comments:
cover: https://w.wallhaven.cc/full/1p/wallhaven-1pd1o9.jpg
toc:
toc_number: https://w.wallhaven.cc/full/1p/wallhaven-1pd1o9.jpg
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



# @RequestParam

主要用于将请求参数区域的数据映射到控制层方法的参数上，在 GET 与 POST 方法中都适用，两种请求方法对应前端两种不同的请求方式，下面是@RequestParam一种出现方式

![在这里插入图片描述](https://img-blog.csdnimg.cn/2296b983ed7a4bd689c61bcb076dce3a.png)

我们需要知道@RequestParam注解主要有哪些参数

- **value**：请求中传入参数的名称，如果不设置后台接口的value值，则会默认为该变量名。比如上图中第一个参数如果不设置value=“page”,则前端传入的参数名必须为pageNum,否则在后台接口中pageNum将接收不到对应的数据
- **required**：该参数是否为必传项。**默认是true**，表示请求中一定要传入对应的参数，**否则会报404错误**，如果设置为false时，当请求中没有此参数，**将会默认为null,而对于基本数据类型的变量，则必须有值，这时会抛出空指针异常**。如果允许空值，则接口中变量需要使用包装类来声明。
- **defaultValue**：参数的默认值，如果请求中没有同名的参数时，该变量默认为此值。



## GET 请求

### 问号传参

- 前端代码

```javascript
axios.get("http://localhost:8081/boot/one?name=xxx&age=22")
  .then(function (res) {
    console.log(res)
  })
  .catch(function (err) {
    console.log(err)
  })
```

- 后端接收

```java
/**
 * axios问号传参
 * 无Content-Type
 * Payload: Query String Parameters name: xxx age: 22
 * 没有注解
 */
@GetMapping(value = "/boot/get1")
public Result getParamByQ(String name, Integer age) {
    if (name != null && age != null) {
        return new Result(name + age, "请求成功", 100);
    }
    return new Result(null, "请求失败", -1);
}
```

### 反斜杠传参

- 前端代码

```javascript
axios.get("http://localhost:8081/boot/get2/xxx/22")
  .then(function (res) {
    console.log(res)
  })
  .catch(function (err) {
    console.log(err)
  })
```

- 后端代码

```java
/**
 * 反斜杠传参
 * 无Content-Type
 * 参数在请求的url中
 * 注解: @PathVariable
 */
@GetMapping(value = "/boot/get2/{name}/{age}")
public Result getParamByX(@PathVariable String name, @PathVariable Integer age) {
    if (name != null && age != null) {
        return new Result(name + age, "请求成功", 100);
    }
    return new Result(null, "请求失败", -1);
}
```

## POST 请求

### x-www-form-urlencoded方式

- 前端代码
  需要引入Qs模块，前端控制台执行`npm install Qs`

```javascript
axios.post("http://localhost:8081/boot/post1", Qs.stringify({name: 'hqz', age: 22}), {
     headers: {
          'Content-Type': 'application/x-www-form-urlencoded'
     }
}).then(function (res) {
     console.log(res)
}).catch(function (err) {
     console.log(err)
})
```

- 后端代码

```java
/**
 * post传表单方式
 * url: 不变
 * Content-Type: application/x-www-form-urlencoded
 * Payload: Form Data name: hqz age: 22
 * 注解: @RequestParam(value = "name")
 */
@PostMapping(value = "/boot/post1")
public Result getDataByForm(@RequestParam(value = "name") String name, @RequestParam(value = "age") Integer age) {
    if (name != null && age != null) {
        return new Result(name + age, "请求成功", 100);
    }
    return new Result(null, "请求失败", -1);
}
```

### FormData方式

- 前端代码
  前端需要构造一个FormData类

```javascript
let fd = new FormData()
fd.append("name", "xxx")
fd.append("age", 22)

axios.post("http://localhost:8081/boot/post2", fd, {
     headers: {'Content-Type': 'multipart/form-data'}
}).then(function (res) {
     console.log(res)
}).catch(function (err) {
     console.log(err)
})
```

- 后端代码

```java
/**
 * post传FormData
 * url: 不变
 * Content-Type: multipart/form-data
 * Payload: Form Data name: xxx age: 22
 * 注解: @RequestParam
 */
@PostMapping(value = "/boot/post2")
public Result getDataByFormData(@RequestParam(value = "name") String name, @RequestParam(value = "age") Integer age) {
     if (name != null && age != null) {
          return new Result(name + age, "请求成功", 100);
     }
     return new Result(null, "请求失败", -1);
}
```



























