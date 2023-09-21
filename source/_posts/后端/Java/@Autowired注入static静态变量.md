---
title: @Autowired注入static静态变量
date: 2023年4月27日00:18:50
tags: Java
categories: 后端
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



# @Autowired注入static静态变量

开发过程中可以需要注入静态变量，但是如果使用常规方式，直接在静态变量上面使用@Autowired注解注入是不成功的，使用时报空指针异常，如下：

![img](https://img-blog.csdnimg.cn/20210827102132984.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBATXVzY2xlaGVuZw==,size_13,color_FFFFFF,t_70,g_se,x_16)

 常用的两种解决方式：

一、使用构造方法注入（注：spring中这种方式可能出现循环依赖错误）

```java
// @component 不能少
@Component
public class TestBean {
    public TestBean(){}
 
    // 静态变量
    private static DictService dictService;
 
    // 构造方法注入静态变量
    @Autowired
    public TestBean(DictService dictService){
        TestBean.dictService = dictService;
    }
 
    public static void getDict(String type) throws Exception {
        // 注入成功后，在静态方法里面使用静态变量
        dictService.getDict(type);
    }
}

```

二、set方法注入（推荐使用）

```java
@Component
public class TestBean {
    // 静态变量
    private static DictService dictService;
 
    // 构造方法注入静态变量
    @Autowired
    public void setDictService(DictService dictService){
        TestBean.dictService = dictService;
    }
 
    public static void getDict(String type) throws Exception {
        // 注入成功后，在静态方法里面使用静态变量
        dictService.getDict(type);
    }
}
```