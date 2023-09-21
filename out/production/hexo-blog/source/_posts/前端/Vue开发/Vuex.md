---
title: Vuex 实战笔记
date: 2023年4月23日22:29:56
tags: Vue开发
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

# 初识Vuex

## vuex的概念

vuex是一个专为 Vue.js 应用程序开发的**状态管理模式**， 采用**集中式存储**管理应用的所有组件的状态，解决多组件数据通信。(简单来说就是管理数据的,相当于一个仓库,里面存放着各种需要共享的数据,所有组件都可以拿到里面的数据)

要点:

> 1. vue官方搭配,专属,有专门的调试工具
>
> 2. 数据变化是可预测的(响应式)
>
> 3. **集中式**管理数据状态方案

![vue11.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/fa98f16ce41a4e04b3fc19982a3c307d~tplv-k3u1fbpfcp-zoom-in-crop-mark:4536:0:0:0.awebp?)



## Vuex的使用

### 安装VueX

1.安装

```css
npm i vuex
```

2.实例化store

新建store文件夹,在该文件夹下建index.js文件

```javascript
import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

const store = new Vuex.Store({
  state: {
    count: 0
  }
})
export default store
```

3.在vue实例中,注入store

```javascript
// 省略其他
// 1. 导入store
import store from './store' 

new Vue({
  // 省略其他...
  store // 2. 注入Vue实例
})
```

### 在组件中使用store

#### 方式一

在任意组件中，通过`this.$store.state.属性名` 来读取公共数据。

在模块中,则可以直接省略this而直接写成：`{{$store.state.属性名}}`

![使用store.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/b16969670e774a5dab490c03b9899984~tplv-k3u1fbpfcp-zoom-in-crop-mark:4536:0:0:0.awebp?)

#### 方式二

基于 Vuex 提供的 mapState 辅助函数，可以方便的把 Store 中指定的数据，映射为当前组件的计算属性

![img](https://img-blog.csdnimg.cn/img_convert/ff2e11475f21cad24173c79fbeb0a6e6.png)

map辅助函数：

```cobol
computed: { 
  ...mapState(['xxx']), 
  ...mapState({'新名字': 'xxx'})
}
```

另一种映射方式：

```javascript
computed: {
     ...mapState({
          wallet: state => state.user.wallets[state.user.selectedWallet]
     })
},
```

### Vuex实现刷新保持数据

在app.vue里直接加上这段代码，加上之后怎么刷新数据都不会丢失了

```javascript
created() {
     if (sessionStorage.getItem('store')) {
          this.$store.replaceState(Object.assign({}, this.$store.state, JSON.parse(sessionStorage.getItem('store'))));
     }
     window.addEventListener('beforeunload', () => {
          sessionStorage.setItem('store', JSON.stringify(this.$store.state));
     });
}
```

### Vue中监控Vuex数据变化

**场景如下图所示**

切换主页面中的组织（即：改变组织id orgid),需要刷新组件中的列表

![img](https://img-blog.csdnimg.cn/20190729142156202.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM3ODk5Nzky,size_16,color_FFFFFF,t_70)

#### 第一种

**通过改变router-view中的key来达到刷新组件的目的（野路子，推荐第三种）**

当改变state中的值时，改变router-view中的key,这个key为[时间戳](https://so.csdn.net/so/search?q=时间戳&spm=1001.2101.3001.7020)

```html
<router-view  :key="timeValue"/>
<script>
 
  export default {
    name: 'mainMenu',
    data() {
      return {
        orgid:'',
        timeValue:''
      }
    },
    computed: {
     
    },
    components: {
      
    },
    created() {
    
    },
    mounted() {
      
    },
    methods: {
      changeOr(){
        this.orgid = "23"
        this.$store.commit('ogrid',this.orgid);
        var timeNow = new Date().getTime();
        this.timeValue = timeNow 
       
      }
    },
 
  }
</script>
```



####  第二种

**用watch(两种方法不可共存，用第一种时，watch失效)**

在子组件中，用watch监听

```html
<script>
 
  export default {
    name: 'sub',
    data() {
      return {
       
      }
    },
    computed: {
     
    },
    watch:{
      '$store.state.orgid'(){
        alert('改变')
        this.initTable()
      }
    },
    components: {
      
    },
    created() {
    
    },
    mounted() {
      
    },
    methods: {
      initTable(){}
    },
 
  }
</script>
```

#### **第三种** 

vue全局更新以及孙组件调用祖组件（利用provide和inject）

参考文章

[vue全局更新以及孙组件调用祖组件（利用provide和inject）_有蝉的博客-CSDN博客_vue孙组件调用祖组件方法](https://blog.csdn.net/qq_37899792/article/details/100710967)

# Vuex实战



