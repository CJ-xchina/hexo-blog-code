---
title: Matploblib
date: 2023年9月13日23:10:52
tags: 
    - Python
    - Python工具包
categories: 后端
keywords:
description:
top_img: https://w.wallhaven.cc/full/d5/wallhaven-d582rg.png
comments:
cover: https://w.wallhaven.cc/full/d5/wallhaven-d582rg.png
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

## 

## 一、初识Matploblib

Matplotlib是Python中的绘图库，类似于MATLAB，可以用来绘制各种静态，动态，交互式的图表。

### 1.1 Figure

 在绘图之前，我们需要一个Figure对象，可以理解成我们需要一张画布才能开始绘图。 

```python
import matplotlib.pyplot as plt
fig = plt.figure()
```

### 1.2 [Axes](https://so.csdn.net/so/search?q=Axes&spm=1001.2101.3001.7020)

拥有Figure对象之后，我们还需要创建绘图区域，添加Axes。在绘制[子图](https://so.csdn.net/so/search?q=子图&spm=1001.2101.3001.7020)过程中，对于每一个子图可能有不同设置，而 Axes 可以直接实现对于单个子图的设定。figure、axes和axis（轴）的区别如下图所示。

<img src="https://img-blog.csdnimg.cn/20210609155829318.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM4MDQ4NzU2,size_16,color_FFFFFF,t_70" alt="img" style="zoom: 67%;" />



```python
fig = plt.figure()
ax = fig.add_subplot(111)
ax.set(xlim=[0.5, 4.5], ylim=[-2, 8], title='An Example Axes',
       ylabel='Y-Axis', xlabel='X-Axis')
plt.show()
```

以上的代码，在一幅图上添加了一个Axes，然后设置了这个Axes的X轴以及Y轴的取值范围（这些设置并不是强制的，后面会再谈到关于这些设置），效果如下图：

<img src="https://img-blog.csdnimg.cn/8fe8d5b843ba4ea3b98d10ab2956dadc.png" alt="img" style="zoom: 50%;" />

`add_subplot(nrows, ncols, index, **kwargs)`

说明：将整个Figure区域划分为$nrows * col$的网格，在索引号为index处创建一个Axes

我们要创建一个2*2的网格，参数和索引如下图所示：

<img src="https://imgconvert.csdnimg.cn/aHR0cDovL3AzLnBzdGF0cC5jb20vbGFyZ2UvcGdjLWltYWdlLzUwZDgzYmExMWM5MTRlZTk5YjdiNWZhODQ5OTM3ODc2?x-oss-process=image/format,png" alt="Matplotlib学习手册A006_Figure的add_subplot()方法" style="zoom:67%;" />

代码如下：

```python
fig = plt.figure()
ax1 = fig.add_subplot(221)
ax2 = fig.add_subplot(222)
ax3 = fig.add_subplot(224)
```

<img src="https://img-blog.csdnimg.cn/52a3605f7c23415ebe078e8d9e60b892.png" alt="img" style="zoom: 67%;" />

可以发现我们上面添加 Axes 似乎有点弱鸡，所以提供了下面的`subplots()`方式一次性生成所有 Axes：

```python
fig, axes = plt.subplots(nrows=2, ncols=2)
axes[0,0].set(title='Upper Left')
axes[0,1].set(title='Upper Right')
axes[1,0].set(title='Lower Left')
axes[1,1].set(title='Lower Right')

# 另一种写法
fig, (ax1,ax2,ax3,ax4) = plt.subplots(nrows=2, ncols=2)
ax1.set(title='Upper Left')
ax2.set(title='Upper Right')
ax3.set(title='Lower Left')
ax4.set(title='Lower Right')
```

fig 还是我们熟悉的画板， axes 成了我们常用二维数组的形式访问，这在循环绘图时，额外好用。

### 1.3 设置画布大小

在使用matplotlib作图时，会遇到图片显示不全或者图片大小不是我们想要的，这个时候就需要调整画布大小。下例左图为500*500像素，右图为1000*1000像素。

```python
import matplotlib.pyplot as plt
 
# 500 x 500 像素（先宽度 后高度）
# 注意这里的宽度和高度的单位是英寸，1英寸=100像素
fig = plt.figure(figsize=(5, 5))
ax = fig.add_subplot(111)
plt.show()
```

### 1.4 plot()绘制线条

#### 常用的调用方式

`plt.plot()`函数是我们平时绘图的时候最常用的另外一个函数之一，先放一下[官网上的介绍](https://matplotlib.org/api/_as_gen/matplotlib.pyplot.plot.html#matplotlib.pyplot.plot)，该函数的关键字参数不多，其中***\*kwargs**是将可变的关键字参数字典传给函数实参，该字典长度可为任意长度[\*args和**kwargs介绍](https://zhuanlan.zhihu.com/p/50804195)。

```python
matplotlib.pyplot.plot(*args, scalex=True, scaley=True, data=None, **kwargs)
 
 
#调用格式说明
plot([x], y, [fmt], *, data=None, **kwargs)
plot([x], y, [fmt], [x2], y2, [fmt2], ..., **kwargs)
```

最简洁的调用方式是直接传入一个数组对象y，其他参数都是可选的。如下：先创建一个服从正态分布的数据，共100个点，直接传入plot()。

```python
data = np.random.normal(5, 1, 100)
fig = plt.figure()
plt.plot(data)
plt.show()
```

![img](https://img-blog.csdnimg.cn/20210102121704939.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3N0ZWZhbmpvZQ==,size_16,color_FFFFFF,t_70)

当只传入绘制的数据列表时，**默认数据作为Y轴值，而X轴的坐标则是由数据的下标组成的，共100个点对应X轴的100个坐标。**`plt.plot()`肯定也支持自定义X轴坐标，只需要调用的时候传入两个大小相同的数组即可，X坐标在前，Y坐标在后。`plt.plot()`默认是将每个点通过直线连接起来，所以当点比较少的时候就呈现下左图，当点较多时就呈现下右图，看似是曲线。

```py
x = np.linspace(-np.pi, np.pi, 10)   #x = np.linspace(-np.pi, np.pi, 100)
y = np.sin(x)
fig = plt.figure()
plt.plot(x, y)
plt.show()
```

<img src="https://img-blog.csdnimg.cn/20210102122258995.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3N0ZWZhbmpvZQ==,size_16,color_FFFFFF,t_70" alt="img" style="zoom:67%;" />

<img src="https://img-blog.csdnimg.cn/20210102122312142.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3N0ZWZhbmpvZQ==,size_16,color_FFFFFF,t_70" alt="img" style="zoom:67%;" />

#### 关键字参数

格式fmt : 字符串str, [可选optional]，定义线条的颜色和样式的操作

如“ro”就是红色的圆圈，更多组合参见[官网列表](https://matplotlib.org/api/_as_gen/matplotlib.pyplot.plot.html#matplotlib.pyplot.plot)，

```py
x = np.linspace(-np.pi, np.pi, 50)   #x = np.linspace(-np.pi, np.pi, 100)
y = np.sin(x)
fig = plt.figure()
fig.suptitle('fmt: ro')
plt.plot(x, y, 'ro')     #不可写成fmt='ro'，目前不识别关键字fmt
plt.show()
```

![image-20230914190819767](https://typora-md-bucket.oss-cn-beijing.aliyuncs.com/image-20230914190819767.png)

注意上面这样每个点之间就不能连接起来了，plot()函数还定义了每个点之间的连接方式，如'-.'表示点画线、'-'表示实线。

```python
x = np.linspace(-np.pi, np.pi, 50)   #x = np.linspace(-np.pi, np.pi, 100)
y = np.sin(x)
fig = plt.figure()
fig.suptitle('fmt: r-*')
plt.plot(x, y, 'r-*')     #不可写成fmt='ro'，目前不识别关键字fmt
plt.show()
```

<img src="https://img-blog.csdnimg.cn/20210102141914460.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3N0ZWZhbmpvZQ==,size_16,color_FFFFFF,t_70" alt="img" style="zoom:67%;" />

**详细的标记如下面三个表所示。** 

| **标记character** | **描述description** | **标记character** | **描述description** |
| ----------------- | ------------------- | ----------------- | ------------------- |
| 'o'               | 圆圈                | '.'               | 点                  |
| 'D'               | 菱形                | 's'               | 正方形              |
| 'd'               | 小菱形              | '*'               | 星号                |
| 'H'               | 六边形1             | 'v'               | 一角朝下的三角形    |
| 'h'               | 六边形2             | '<'               | 一角朝左的三角形    |
| '_'               | 水平线              | '>'               | 一角朝右的三角形    |
| '\|'              | 竖线                | '^'               | 一角朝上的三角形    |
| '8'               | 八边形              | '+'               | 加号                |
| 'p'               | 五边形              | 'x'               | X                   |
| ','               | 像素                | 'None', '', ' '   | 无                  |

| **线条风格** | **描述** | **线条风格**    | **描述**   |
| ------------ | -------- | --------------- | ---------- |
| '-'          | 实线     | ':'             | 虚线       |
| '--'         | 破折线   | 'None', ' ', '' | 什么都不画 |
| '-.'         | 点划线   |                 |            |

| **别名** | **颜色** | **别名** | **颜色** |
| -------- | -------- | -------- | -------- |
| B        | 蓝色     | G        | 绿色     |
| R        | 红色     | Y        | 黄色     |
| C        | 青色     | K        | 黑色     |
| M        | 洋红色   | W        | 白色     |

#### **各种属性\**kwargs：**[`Line2D`](https://matplotlib.org/api/_as_gen/matplotlib.lines.Line2D.html#matplotlib.lines.Line2D) properties

这个属性就相当之多了，借用官网一句话：*kwargs* are used to specify properties like a line label (for auto legends), linewidth, antialiasing, marker face color.就是说该参数主要用来指明绘线的一些属性，如标签、线宽、标记、背景颜色等。下面就介绍几个常用的properties，其他的可以去官网查。

```python
第一个是label，表示标签，如图就是说画的线的标签，通过调用plt.legend()之后会显示出来；
fig = plt.figure()
fig.suptitle('Figure: example for label')
plt.plot([1,2,3,4], label='a')
plt.plot([4,3,2,1], label='b')
plt.legend()
plt.show()
 
 
第二个是linewidth，表示线宽，也可以调用缩写lw=1等价于lienwidth=1；
plt.plot([1,2,3,4], linewidth=1)
plt.plot([4,3,2,1], linewidth=5)
 
 
第三个是color，表示颜色，一般来说会自动分配合适的颜色，用户也可以自定义任意符合的颜色；
plt.plot([1,2,3,4], color='r')
plt.plot([4,3,2,1], color='g')
 
 
第四个是linestyle，表示线的类型，也可以调用缩写ls='-.'等价于linestyle='-.'
plt.plot([1,2,3,4], linestyle='--')
plt.plot([4,3,2,1], linestyle='-.')
 
 
第五个是alpha，表示透明度，浮点类型
plt.plot([1,2,3,4], label='a', alpha=0.8)
plt.plot([4,3,2,1], label='b', alpha=0.2)
 
 
第六个凑数的visible，表示是否显示
plt.plot([1,2,3,4], label='a', visible=True)
plt.plot([4,3,2,1], label='b', visible=False)
```

 

<img src="https://img-blog.csdnimg.cn/20210102143446508.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3N0ZWZhbmpvZQ==,size_16,color_FFFFFF,t_70" alt="img" style="zoom: 50%;" /><img src="https://img-blog.csdnimg.cn/20210102143720771.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3N0ZWZhbmpvZQ==,size_16,color_FFFFFF,t_70" alt="img" style="zoom:50%;" /><img src="https://img-blog.csdnimg.cn/20210102143856204.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3N0ZWZhbmpvZQ==,size_16,color_FFFFFF,t_70" alt="img" style="zoom:50%;" /><img src="https://img-blog.csdnimg.cn/20210102144756920.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3N0ZWZhbmpvZQ==,size_16,color_FFFFFF,t_70" alt="img" style="zoom:50%;" /><img src="https://img-blog.csdnimg.cn/20210102145102244.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3N0ZWZhbmpvZQ==,size_16,color_FFFFFF,t_70" alt="img" style="zoom:50%;" /><img src="https://img-blog.csdnimg.cn/20210102145246838.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3N0ZWZhbmpvZQ==,size_16,color_FFFFFF,t_70" alt="img" style="zoom:50%;" />

### 1.5 设置网格线

通过 axes 对象提供的 grid() 方法可以开启或者关闭画布中的网格以及网格的主/次刻度。除此之外，grid() 函数还可以设置网格的颜色、线型以及线宽等属性。

grid() 的函数使用格式如下：

```python
grid(color='b', ls = '-.', lw = 0.25)
```

参数含义如下：

- color：表示网格线的颜色；
- ls：表示网格线的样式；
- lw：表示网格线的宽度；

网格在默认状态下是关闭的，通过调用上述函数，网格会被自动开启，如果只是想开启不带任何样式的网格，可以通过 grid(True) 来实现。

实例如下：

```python
import matplotlib.pyplot as plt
import numpy as np
 
# fig画布；axes子图区域
fig, axes = plt.subplots(1, 3, figsize=(12, 4))
x = np.arange(1, 11)
axes[0].plot(x, x ** 3, 'g', lw=2)
# 开启网格
axes[0].grid(True)
axes[0].set_title('default grid')
axes[1].plot(x, np.exp(x), 'r')
# 设置网格的颜色，线型，线宽
axes[1].grid(color='b', ls='-.', lw=0.25)
axes[1].set_title('custom grid')
axes[2].plot(x, x)
axes[2].set_title('no grid')
fig.tight_layout()
plt.show()
```

![img](https://img-blog.csdnimg.cn/81172cef8c034b9c8a4769f920d1163e.png)

### 1.6 设置坐标轴

`set_xlabel` 用字符串列表来设置坐标轴的标签，`fontsize` 设置轴标签的字体和字号等参数。

```python
import matplotlib.pyplot as plt
import numpy as np
 
fontdict = {'weight': 'normal', 'family': 'Times New Roman', 'size': 20}
 
fig, axes = plt.subplots(1, 1)
x = np.arange(1, 5)
axes.plot(x, np.exp(x))
axes.plot(x, x ** 2)
 
# 设置标题
axes.set_title("Normal scale", fontdict=fontdict)
 
# 设置x、y轴标签
axes.set_xlabel("x axis", fontdict=fontdict)
axes.set_ylabel("y axis", fontdict=fontdict)
 
plt.show()
```

![img](https://img-blog.csdnimg.cn/6121c443fc754563866e1690841ac05e.png)

Matplotlib 可以根据自变量与因变量的取值范围，自动设置 x 轴与 y 轴的数值大小。当然，您也可以用自定义的方式，通过 set_xlim() 和 set_ylim() 对 x、y 轴的数值范围进行设置。

```python
import matplotlib.pyplot as plt
import numpy as np
 
fig, a1 = plt.subplots(1, 1)
 
x = np.arange(1, 10)
a1.plot(x, np.exp(x), 'r')
a1.set_title('exp')
# 设置y轴
a1.set_ylim(0, 4000)
# 设置x轴
a1.set_xlim(0, 8)
plt.show()
```

![img](https://img-blog.csdnimg.cn/859c5939485d4a6c9c46865df3005fb6.png)

移动坐标轴以及为坐标轴添加箭头可以通过mpl_toolkits.axisartist实现，如下例所示。

```python
import numpy as np
import matplotlib.pyplot as plt
import mpl_toolkits.axisartist as axisartist
 
# 新建一个画板（画图视窗）
fig = plt.figure('Sine Wave')
 
# 新建一个绘图区对象ax,并添加到画板中
ax = axisartist.Subplot(fig, 1, 1, 1)
fig.add_axes(ax)
 
# 隐藏默认坐标轴（上下左右边框）
ax.axis[:].set_visible(False)
# ax.axis["top"].set_visible(False)
# ax.axis["right"].set_visible(False)
 
# 新建可移动的坐标轴X-Y
ax.axis["x"] = ax.new_floating_axis(0, 0)
ax.axis["y"] = ax.new_floating_axis(1, 0)
 
# 设置刻度标识方向
ax.axis["x"].set_axis_direction('top')
ax.axis["y"].set_axis_direction('left')
 
# 加上坐标轴箭头，设置刻度标识位置
ax.axis["x"].set_axisline_style("->", size=2.0)
ax.axis["y"].set_axisline_style("->", size=2.0)
ax.axis["x"].set_axis_direction('top')
ax.axis["y"].set_axis_direction('left')
 
# 画上y=sin(t)折线图，设置刻度范围，设置刻度标识，设置坐标轴位置
t = np.linspace(0, 2 * np.pi)
y = np.sin(t)
ax.plot(t, y, color='red', linewidth=2)
plt.title('y = 2sin(2t)', fontsize=14, pad=20)
 
ax.set_xticks(np.linspace(0.25, 1.25, 5) * np.pi)
ax.set_yticks([0, 1, 2])
 
# 设置刻度标识显示
ax.set_xlim(-0.5 * np.pi, 1.5 * np.pi)
ax.set_ylim(-2, 2)
plt.show()
```

![img](https://img-blog.csdnimg.cn/2727e1ac530f4dee8341e75dedeaf359.png)

 

其中，创建坐标轴的方法有两种：

`new_fixed_axis(self, loc, offset=None)`和`new_floating_axis(self, nth_coord, value, axis_direction=‘bottom’)`，而`new_floating_axis()`相对更加灵活。
（1）**nth_coord：**坐标轴方向，0代表X方向，1代表Y方向
（2）**value：**坐标轴处于位置，如果是平行与X轴的新坐标轴，则代表Y位置（即通过（0，value）），如果是平行与Y轴的新坐标轴，则代表X位置（即通过（value，0））。
（3）**axis_direction：**代表刻度标识字的方向，可选[‘top’, ‘bottom’, ‘left’, ‘right’]

### 1.7 设置刻度和标签

刻度指的是轴上数据点的标记，Matplotlib 能够自动的在 x 、y 轴上绘制出刻度。这一功能的实现得益于 Matplotlib 内置的刻度定位器和格式化器（两个内建类）。在大多数情况下，这两个内建类完全能够满足我们的绘图需求，但是在某些情况下，刻度标签或刻度也需要满足特定的要求，比如将刻度设置为“英文数字形式”或者“大写阿拉伯数字”，此时就需要对它们重新设置。

xticks() 和 yticks() 函数接受一个列表对象作为参数，列表中的元素表示对应数轴上要显示的刻度。如下所示：

```python
ax.set_xticks([2,4,6,8,10])
```

x 轴上的刻度标记，依次为 2，4，6，8，10。您也可以分别通过 set_xticklabels() 和 set_yticklabels() 函数设置与刻度线相对应的刻度标签。

下面示例介绍了刻度和标签的使用方法，其中对标签逆时针旋转了90°：

```python
import matplotlib.pyplot as plt
import numpy as np
import math
 
x = np.arange(0, math.pi * 2, 0.05)
 
fig, ax = plt.subplots(1, 1, figsize=(5, 6))
 
y = np.sin(x)
ax.plot(x, y)
# 设置x轴标签
ax.set_xlabel('angle')
# ax.set_title('sine')
ax.set_xticks([0, 2, 4, 6])
# 设置x轴刻度标签,并旋转90°
ax.set_xticklabels(['zero', 'two', 'four', 'six'], rotation=90)
# 设置y轴刻度
ax.set_yticks([-1, 0, 1])
plt.show()
```

![img](https://img-blog.csdnimg.cn/0e4f7e928ce94422a6f5c5f76c7b3467.png)

### 1.8 添加图例和标题

图例通过`ax.legend`或者`plt.legend()`实现，标题通过`ax.set_title()`或者`plt.title()`实现，基本用法如下例所示。

```python
import matplotlib as mpl
 
mpl.rcParams["font.sans-serif"] = ["SimHei"]
mpl.rcParams["axes.unicode_minus"] = False
 
import matplotlib.pyplot as plt
import numpy as np
 
fig = plt.figure()
ax = fig.add_subplot(111)
x = np.linspace(-2 * np.pi, 2 * np.pi, 200)
y = np.sin(x)
y1 = np.cos(x)
 
ax.plot(x, y, label=r"$\sin(x)$")
ax.plot(x, y1, label=r"$\cos(x)$")
 
ax.legend(loc="best")
ax.set_title("正弦函数和余弦函数的折线图")
 
plt.show()
```

![img](https://img-blog.csdnimg.cn/f03409b8592b4307b55ce191da7fbbc9.png)

**调整图例**

对于图例，我们还可以通过改变legend()的参数来改变图例的显示位置，展示样式（包括图例的外边框、图例中的文本标签的排列位置和图例的投影效果等方面）。

```python
import matplotlib.pyplot as plt
import numpy as np
 
 
x = np.arange(0, 2.1, 0.1)
y = np.power(x, 3)
y1 = np.power(x, 2)
y2 = np.power(x, 1)
 
plt.plot(x, y, ls="-", lw=2, label="$x^{3}$")
plt.plot(x, y1, c="r", ls="-", lw=2, label="$x^{2}$")
plt.plot(x, y2, c="y", ls="-", lw=2, label="$x^{1}$")
 
plt.legend(loc="upper left", bbox_to_anchor=(0.05, 0.95),
           ncol=3, title="power function", shadow=True,
           fancybox=True)
plt.show()
```

![img](https://img-blog.csdnimg.cn/143fa867ac8b4e16b43a2a2fbf386a4d.png)

` plt.legend()`的位置参数loc也可以使用数字，其对应如下：

|       字符串       | 位置编号 |   位置表述   |
| :----------------: | :------: | :----------: |
|     **`best`**     |    0     |   最佳位置   |
| **`upper right`**  |    1     |    右上角    |
|  **`upper left`**  |    2     |    左上角    |
|  **`lower left`**  |    3     |    右下角    |
| **`lower right`**  |    4     |    左下角    |
|    **`right`**     |    5     |     右侧     |
| **`center left`**  |    6     | 左侧垂直居中 |
| **`center right`** |    7     | 右侧垂直居中 |
| **`lower center`** |    8     | 下方水平居中 |
| **`upper center`** |    9     | 上方水平居中 |
|    **`center`**    |    10    |    正中间    |

此外还用到了线框位置参数bbox_to_anchor，它的参数值是一个四元元组，且使用Axes坐标系统。也就是说第一个元素代表距离画布左侧的x轴长度的倍速的距离；第二个元素代表距离画布底部的y轴长度的倍数的距离；第三个元素代表元素x轴长度的倍数的线框长度；第四个元素代表y轴长度的倍数的线框宽度。plt.legend(loc = "upper left",bbox_to_anchor=(0.05,0.95),ncol = 3,title = "power function",shadow=True,fancybox=True)会把图例放在上方左手边拐角处的距离坐标轴左边0.1，底部7.6的位置。关键字参数shadow控制线框是否添加阴影；fancybox控制线框是直角还是圆角。 

**调整标题**

对于标题，也可以通过参数控制各种文本属性。

```python
import matplotlib.pyplot as plt
import numpy as np
 
x = np.linspace(-2, 2, 1000)
y = np.exp(x)
 
plt.plot(x, y, ls="-", lw=2, color="g")
 
plt.title("center demo")
plt.title("Left Demo", loc="left",
          fontdict={"size": "xx-large",
                    "color": "r",
                    "family": "Times New Roman"})
plt.title("Right Demo", loc="right",
          size=20, color="c",
          style="oblique",
          family="Comic Sans MS")
plt.show()
```

![img](https://img-blog.csdnimg.cn/9bdf76a7becf40588d6eb8e38314f728.png)

上面展示了plt.title()中参数的两种使用方法。其中位置参数loc可以选择“left”，“center”和“right”。family控制的是字体类别，size控制字体大小，color控制字体颜色，style控制字体风格。

### 1.9 设置中文显示

Matplotlib 默认不支持中文字体，只支持 ASCII 字符，但中文标注更加符合中国人的阅读习惯。

当直接使用中文时，Matplotlib 绘制的图像会出现中文乱码，如左图所示。通过临时重写配置文件的方法，可以解决 Matplotlib 显示中文乱码的问题，代码如下所示：

```python
import matplotlib.pyplot as plt
 
plt.rcParams["font.sans-serif"] = ["SimHei"]  # 设置字体
plt.rcParams["axes.unicode_minus"] = False  # 正常显示负号
year = [2017, 2018, 2019, 2020]
people = [20, 40, 60, 70]
# 生成图表
plt.plot(year, people)
plt.xlabel('年份')
plt.ylabel('人口')
plt.title('人口增长')
# 设置纵坐标刻度
plt.yticks([0, 20, 40, 60, 80])
# 设置填充选项：参数分别对应横坐标，纵坐标，纵坐标填充起始值，填充颜色
plt.fill_between(year, people, 20, color='green')
# 显示图表
plt.show()
```

![img](https://img-blog.csdnimg.cn/5a959b0060214ef4a17221eee131e7e1.png)![img](https://img-blog.csdnimg.cn/3f25e2d0719c4b87816440c1a288fb28.png)

### 1.10 设置数学表达式显示

Matplotlib中的文本字符串都可以使用 Latex 格式显现出来，具体的使用方法是将文本标记符放在一对美元符号`$`内，语法格式如下： 

```python
# 绘制表达式 r'$\alpha_i> \beta_i$'
import numpy as np
import matplotlib.pyplot as plt
 
t = np.arange(0.0, 2.0, 0.01)
s = np.sin(2 * np.pi * t)
# 绘制函数图像
plt.plot(t, s)
# 设置标题
plt.title(r'$\alpha_i> \beta_i$', fontsize=20)
# 设置数学表达式
plt.text(0.6, 0.6, r'$\mathcal{A}\mathrm{sin}(2 \omega t)$', fontsize=20)
# 设置数学表达式
plt.text(0.1, -0.5, r'$\sqrt{2}$', fontsize=10)
plt.xlabel('time (s)')
plt.ylabel('volts (mV)')
plt.show()
```

![img](https://img-blog.csdnimg.cn/84086091cf4147e1a216af975a9ca454.png)

### 1.11 调整子图布局

在pyplot模块中，与调整子图布局的函数主要为subplots_adjust和tight_layout，其中subplots_adjust是修改子图间距的通用函数，tight_layout默认执行一种固定的间距配置，也可以自定义间距配置，底层原理类似于subplots_adjust函数。

**subplots_adjust**

subplots_adjust函数的功能为调整子图的布局参数。对于没有设置的参数保持不变，初始值由rcParams["figure.subplot.[name]"]提供。

> **用法：**matplotlib.pyplot.subplots_adjust(left=None, bottom=None, right=None, top=None, wspace=None, hspace=None)

**参数：**

- **left：**所有子图整体相对于图像的左外边距，距离单位为图像宽度的比例（小数）。可选参数。浮点数。默认值为0.125。
- **right：**所有子图整体相对于图像的右外边距，距离单位为图像宽度的比例（小数）。可选参数。浮点数。默认值为0.0。
- **bottom：**所有子图整体相对于图像的下外边距，距离单位为图像高度的比例（小数）。可选参数。浮点数。默认值为0.11。
- **top：**所有子图整体相对于图像的上外边距，距离单位为图像高度的比例（小数）。可选参数。浮点数。默认值为0.88。
- **wspace：**子图间宽度内边距，距离单位为子图平均宽度的比例（小数）。浮点数。默认值为0.2。
- **hspace：**子图间高度内边距，距离单位为子图平均高度的比例（小数）。可选参数。浮点数。默认值为0.2。

示例代码如下：

```python
import matplotlib.pyplot as plt
 
# 原始间距配置
fig, ax = plt.subplots(3, 3)
print(vars(fig.subplotpars))
# 通过subplots_adjust()设置间距配置
plt.subplots_adjust(left=0.1, bottom=0.1, right=0.9, top=0.9, wspace=0.5, hspace=0.5)
print(vars(fig.subplotpars))
plt.show()
```

原始间距：![img](https://img-blog.csdnimg.cn/e496616ffb4f4e4480e2d1980c84d298.png)

修改间距后（wspace=0.5, hspace=0.5）： 

![img](https://img-blog.csdnimg.cn/da6a3386872a434688a088500e12ccfb.png)

**tight_layout**

pyplot模块中的tight_layout()函数可用于自动调整子图参数或按指定参数填充。通过设置rcParams['figure.autolayout']=True可图像自动应用tight_layout。

> **用法：** matplotlib.pyplot.tight_layout(pad=1.08, h_pad=None, w_pad=None, rect=None)

**参数**：

- **pad：**此参数用于在图形边和子图的边之间进行填充，以字体大小的一部分表示。
- **h_pad，w_pad：**这些参数用于相邻子图的边之间的填充(高度/宽度)，作为字体大小的一部分。
- **rect：**此参数是整个子图区域将适合的归一化图形坐标中的矩形。

### 1.12 保存图片

 使用savefig()函数可将图片保存在指定目录下，在show()前插入，如果在show()后面会出现保存图片为空白现象。

```python
plt.savefig("example.png")
```

采用下面的方法可以保存去除旁边空白区域和坐标轴的图片，论文绘图时常用。 

```python
pyplot.axis('off') #增加这行关闭坐标轴显示
#关键在于bbox_inches = 'tight',pad_inches = 0，去掉空白区域
pyplot.savefig(save_dir,bbox_inches = 'tight',pad_inches = 0)
```

## 二、常见绘图属性

### 2.1 绘图标记

绘图过程如果我们想要给坐标自定义一些不一样的标记，就可以使用 **plot()** 方法的 marker 参数来定义。

以下实例定义了实心圆标记：

```python
import matplotlib.pyplot as plt
import numpy as np
 
ypoints = np.array([1, 3, 4, 5, 8, 9, 6, 1, 3, 4, 5, 2, 4])
 
plt.plot(ypoints, marker='o')
plt.show()
```

![img](https://img-blog.csdnimg.cn/d66d0f964c474973a9f13063903bd434.png)

 marker 可以定义的符号如下：

以下实例定义了 * 标记：

```python
import matplotlib.pyplot as plt
import numpy as np
 
ypoints = np.array([1, 3, 4, 5, 8, 9, 6, 1, 3, 4, 5, 2, 4])
 
plt.plot(ypoints, marker='*')
plt.show()
```

![img](https://img-blog.csdnimg.cn/db64f14b1c1e497984d20d5a58407da9.png)

**fmt 参数**

fmt 参数定义了基本格式，如标记、线条样式和颜色。

```python
fmt = '[marker][line][color]'
```

例如 o:r，o 表示实心圆标记，: 表示虚线，r 表示颜色为红色。

```python
import matplotlib.pyplot as plt
import numpy as np
 
ypoints = np.array([6, 2, 13, 10])
 
plt.plot(ypoints, 'o:r')
plt.show()
```

![img](https://img-blog.csdnimg.cn/5e510d6ea32542ae9a2bd0d231954c4d.png)



线类型：

| 线类型标记 |  描述  |
| :--------: | :----: |
|    '-'     |  实线  |
|    ':'     |  虚线  |
|    '--'    | 破折线 |
|    '-.'    | 点划线 |

颜色类型：

| 颜色标记 | 描述 |
| :------: | :--: |
|   'r'    | 红色 |
|   'g'    | 绿色 |
|   'b'    | 蓝色 |
|   'c'    | 青色 |
|   'm'    | 品红 |
|   'y'    | 黄色 |
|   'k'    | 黑色 |
|   'w'    | 白色 |



**详细颜色对照表** 

![109fa03e9a1a0ef1d53f8999766ddd56.png](https://img-blog.csdnimg.cn/img_convert/109fa03e9a1a0ef1d53f8999766ddd56.png)

**颜色及十六进制对应**

> ```cobol
> cnames = {
> 'aliceblue':            '#F0F8FF',
> 'antiquewhite':         '#FAEBD7',
> 'aqua':                 '#00FFFF',
> 'aquamarine':           '#7FFFD4',
> 'azure':                '#F0FFFF',
> 'beige':                '#F5F5DC',
> 'bisque':               '#FFE4C4',
> 'black':                '#000000',
> 'blanchedalmond':       '#FFEBCD',
> 'blue':                 '#0000FF',
> 'blueviolet':           '#8A2BE2',
> 'brown':                '#A52A2A',
> 'burlywood':            '#DEB887',
> 'cadetblue':            '#5F9EA0',
> 'chartreuse':           '#7FFF00',
> 'chocolate':            '#D2691E',
> 'coral':                '#FF7F50',
> 'cornflowerblue':       '#6495ED',
> 'cornsilk':             '#FFF8DC',
> 'crimson':              '#DC143C',
> 'cyan':                 '#00FFFF',
> 'darkblue':             '#00008B',
> 'darkcyan':             '#008B8B',
> 'darkgoldenrod':        '#B8860B',
> 'darkgray':             '#A9A9A9',
> 'darkgreen':            '#006400',
> 'darkkhaki':            '#BDB76B',
> 'darkmagenta':          '#8B008B',
> 'darkolivegreen':       '#556B2F',
> 'darkorange':           '#FF8C00',
> 'darkorchid':           '#9932CC',
> 'darkred':              '#8B0000',
> 'darksalmon':           '#E9967A',
> 'darkseagreen':         '#8FBC8F',
> 'darkslateblue':        '#483D8B',
> 'darkslategray':        '#2F4F4F',
> 'darkturquoise':        '#00CED1',
> 'darkviolet':           '#9400D3',
> 'deeppink':             '#FF1493',
> 'deepskyblue':          '#00BFFF',
> 'dimgray':              '#696969',
> 'dodgerblue':           '#1E90FF',
> 'firebrick':            '#B22222',
> 'floralwhite':          '#FFFAF0',
> 'forestgreen':          '#228B22',
> 'fuchsia':              '#FF00FF',
> 'gainsboro':            '#DCDCDC',
> 'ghostwhite':           '#F8F8FF',
> 'gold':                 '#FFD700',
> 'goldenrod':            '#DAA520',
> 'gray':                 '#808080',
> 'green':                '#008000',
> 'greenyellow':          '#ADFF2F',
> 'honeydew':             '#F0FFF0',
> 'hotpink':              '#FF69B4',
> 'indianred':            '#CD5C5C',
> 'indigo':               '#4B0082',
> 'ivory':                '#FFFFF0',
> 'khaki':                '#F0E68C',
> 'lavender':             '#E6E6FA',
> 'lavenderblush':        '#FFF0F5',
> 'lawngreen':            '#7CFC00',
> 'lemonchiffon':         '#FFFACD',
> 'lightblue':            '#ADD8E6',
> 'lightcoral':           '#F08080',
> 'lightcyan':            '#E0FFFF',
> 'lightgoldenrodyellow': '#FAFAD2',
> 'lightgreen':           '#90EE90',
> 'lightgray':            '#D3D3D3',
> 'lightpink':            '#FFB6C1',
> 'lightsalmon':          '#FFA07A',
> 'lightseagreen':        '#20B2AA',
> 'lightskyblue':         '#87CEFA',
> 'lightslategray':       '#778899',
> 'lightsteelblue':       '#B0C4DE',
> 'lightyellow':          '#FFFFE0',
> 'lime':                 '#00FF00',
> 'limegreen':            '#32CD32',
> 'linen':                '#FAF0E6',
> 'magenta':              '#FF00FF',
> 'maroon':               '#800000',
> 'mediumaquamarine':     '#66CDAA',
> 'mediumblue':           '#0000CD',
> 'mediumorchid':         '#BA55D3',
> 'mediumpurple':         '#9370DB',
> 'mediumseagreen':       '#3CB371',
> 'mediumslateblue':      '#7B68EE',
> 'mediumspringgreen':    '#00FA9A',
> 'mediumturquoise':      '#48D1CC',
> 'mediumvioletred':      '#C71585',
> 'midnightblue':         '#191970',
> 'mintcream':            '#F5FFFA',
> 'mistyrose':            '#FFE4E1',
> 'moccasin':             '#FFE4B5',
> 'navajowhite':          '#FFDEAD',
> 'navy':                 '#000080',
> 'oldlace':              '#FDF5E6',
> 'olive':                '#808000',
> 'olivedrab':            '#6B8E23',
> 'orange':               '#FFA500',
> 'orangered':            '#FF4500',
> 'orchid':               '#DA70D6',
> 'palegoldenrod':        '#EEE8AA',
> 'palegreen':            '#98FB98',
> 'paleturquoise':        '#AFEEEE',
> 'palevioletred':        '#DB7093',
> 'papayawhip':           '#FFEFD5',
> 'peachpuff':            '#FFDAB9',
> 'peru':                 '#CD853F',
> 'pink':                 '#FFC0CB',
> 'plum':                 '#DDA0DD',
> 'powderblue':           '#B0E0E6',
> 'purple':               '#800080',
> 'red':                  '#FF0000',
> 'rosybrown':            '#BC8F8F',
> 'royalblue':            '#4169E1',
> 'saddlebrown':          '#8B4513',
> 'salmon':               '#FA8072',
> 'sandybrown':           '#FAA460',
> 'seagreen':             '#2E8B57',
> 'seashell':             '#FFF5EE',
> 'sienna':               '#A0522D',
> 'silver':               '#C0C0C0',
> 'skyblue':              '#87CEEB',
> 'slateblue':            '#6A5ACD',
> 'slategray':            '#708090',
> 'snow':                 '#FFFAFA',
> 'springgreen':          '#00FF7F',
> 'steelblue':            '#4682B4',
> 'tan':                  '#D2B48C',
> 'teal':                 '#008080',
> 'thistle':              '#D8BFD8',
> 'tomato':               '#FF6347',
> 'turquoise':            '#40E0D0',
> 'violet':               '#EE82EE',
> 'wheat':                '#F5DEB3',
> 'white':                '#FFFFFF',
> 'whitesmoke':           '#F5F5F5',
> 'yellow':               '#FFFF00',
> 'yellowgreen':          '#9ACD32'}
> ```

**标记大小与颜色**

我们可以自定义标记的大小与颜色，使用的参数分别是：

- markersize，简写为 **ms**：定义标记的大小。
- markerfacecolor，简写为 **mfc**：定义标记内部的颜色。
- markeredgecolor，简写为 **mec**：定义标记边框的颜色。

设置标记大小：

```python
import matplotlib.pyplot as plt
import numpy as np
 
ypoints = np.array([6, 2, 13, 10])
 
plt.plot(ypoints, marker='o', ms=20)
plt.show()
```

![img](https://img-blog.csdnimg.cn/abd593a5c05c425fb32f2d22a8330012.png)



 设置标记外边框颜色：

```python
import matplotlib.pyplot as plt
import numpy as np
 
ypoints = np.array([6, 2, 13, 10])
 
plt.plot(ypoints, marker='o', ms=20, mec='r')
plt.show()
```

![img](https://img-blog.csdnimg.cn/b5a92bf7a3d24958a97dad4bff724ae4.png)



 设置标记内部颜色：

```python
import matplotlib.pyplot as plt
import numpy as np
 
ypoints = np.array([6, 2, 13, 10])
 
plt.plot(ypoints, marker='o', ms=20, mfc='r')
plt.show()
```

![img](https://img-blog.csdnimg.cn/7232c3cacfd9461b815af404cc7fd2ec.png)



 自定义标记内部与边框的颜色：

```python
import matplotlib.pyplot as plt
import numpy as np
 
ypoints = np.array([6, 2, 13, 10])
plt.plot(ypoints, marker='o', ms=20, mec='r', mfc='y')
plt.show()
```

![img](https://img-blog.csdnimg.cn/f7b2defff22d40b0b7f8e1225d96b82b.png)



### 2.2 Windows字体中英文名称对照

| **中文名称** | **英文名称**    |
| ------------ | --------------- |
| 黑体         | SimHei          |
| 微软雅黑     | Microsoft YaHei |
| 微软雅黑     | Microsoft YaHei |
| 新宋体       | NSimSun         |
| 新细明体     | PMingLiU        |
| 细明体       | MingLiU         |
| 标楷体       | DFKai-SB        |
| 仿宋         | FangSong        |
| 楷体         | KaiTi           |
| 仿宋_GB2312  | FangSong_GB2312 |
| 楷体_GB2312  | KaiTi_GB2312    |

## 三、基本绘图

### 3.1 [折线图](https://so.csdn.net/so/search?q=折线图&spm=1001.2101.3001.7020) 

[plot](https://so.csdn.net/so/search?q=plot&spm=1001.2101.3001.7020)()函数画出一系列的点，并且用线将它们连接起来。看下例子：

```python
import numpy as np
import matplotlib.pyplot as plt

x = np.linspace(0, np.pi)
y_sin = np.sin(x)
y_cos = np.cos(x)

# Create the figure and axes objects
fig, (ax1, ax2, ax3) = plt.subplots(3, 1, figsize=(8, 12))

# Plot y_sin on ax1
ax1.plot(x, y_sin)

# Plot y_sin on ax2 with green circles, dashed lines, and larger markers
ax2.plot(x, y_sin, 'go--', linewidth=2, markersize=12)

# Plot y_cos on ax3 with red plus markers and dashed lines
ax3.plot(x, y_cos, color='red', marker='+', linestyle='dashed')

# Display the plots
plt.show()
```

![image-20230914193259068](https://typora-md-bucket.oss-cn-beijing.aliyuncs.com/image-20230914193259068.png)

在上面的三个Axes上作画。plot，前面两个参数为x轴、y轴数据。ax2的第三个参数是 MATLAB风格的绘图，对应ax3上的颜色，marker，线型。

 另外，我们可以通过关键字参数的方式绘图，如下例：

```python
x = np.linspace(0, 10, 200)
data_obj = {'x': x,
            'y1': 2 * x + 1,
            'y2': 3 * x + 1.2,
            'mean': 0.5 * x * np.cos(2*x) + 2.5 * x + 1.1}
 
fig, ax = plt.subplots()
 
#填充两条线之间的颜色
ax.fill_between('x', 'y1', 'y2', color='yellow', data=data_obj)
 
# Plot the "centerline" with `plot`
ax.plot('x', 'mean', color='black', data=data_obj)
 
plt.show()
```

![img](https://img-blog.csdnimg.cn/c2810644cd574927a15be41722ace8e1.png)



发现上面的作图，在数据部分只传入了字符串，这些字符串对一个这 data_obj 中的关键字，当以这种方式作画时，将会在传入给 data 中寻找对应关键字的数据来绘图。 

### 3.2 散点图

只画点，不用线连接起来。

```python
import matplotlib.pyplot as plt
import numpy as np
 
x = np.arange(10)
y = np.random.randn(10)
plt.scatter(x, y, color='red', marker='+')
plt.show()
```

![img](https://img-blog.csdnimg.cn/7d2af83e021844b8b477e8ed681157ce.png)



### 3.3 双轴图

在一些应用场景中，有时需要绘制两个 x 轴或两个 y 轴，这样可以更直观地显现图像，从而获取更有效的数据。Matplotlib 提供的 twinx() 和 twiny() 函数，除了可以实现绘制双轴的功能外，还可以使用不同的单位来绘制曲线，比如一个轴绘制对函数，另外一个轴绘制指数函数。 

下面示例绘制了一个具有两个 y 轴的图形，一个显示正弦函数 sin(x)，另一个显示对数函数 log(x)。

```python
import matplotlib.pyplot as plt
import numpy as np
 
# 准备数据
t = np.arange(0.01, 10.0, 0.01)
data1 = np.exp(t)
data2 = np.sin(2 * np.pi * t)
 
# 设置主轴
fig, ax1 = plt.subplots()
 
color = 'tab:red'
ax1.set_xlabel('time (s)')
ax1.set_ylabel('exp', color=color)
ax1.plot(t, data1, color=color)
ax1.tick_params(axis='y', labelcolor=color)
 
# 设置次轴
ax2 = ax1.twinx()
 
color = 'tab:blue'
ax2.set_ylabel('sin', color=color)
ax2.plot(t, data2, color=color)
ax2.tick_params(axis='y', labelcolor=color)
 
fig.tight_layout()
plt.show()
```

![img](https://img-blog.csdnimg.cn/7b394f20476748538f5d60541dcf546e.png)

### 3.4 条形图 

 条形图分两种，一种是水平的，一种是垂直的，见下例子：

```python
import matplotlib.pyplot as plt
import numpy as np
 
np.random.seed(1)
x = np.arange(5)
y = np.random.randn(5)
 
fig, axes = plt.subplots(ncols=2, figsize=plt.figaspect(1./2))
 
vert_bars = axes[0].bar(x, y, color='lightblue', align='center')
horiz_bars = axes[1].barh(x, y, color='lightblue', align='center')
#在水平或者垂直方向上画线
axes[0].axhline(0, color='gray', linewidth=2)
axes[1].axvline(0, color='gray', linewidth=2)
plt.show()
```

![img](https://img-blog.csdnimg.cn/f974b4cf7fa2466eb2a71980aba1f24a.png)

条形图还返回了一个Artists 数组，对应着每个条形，例如上图 Artists 数组的大小为5，我们可以通过这些 Artists 对条形图的样式进行更改，如下例： 



```python
fig, ax = plt.subplots()
vert_bars = ax.bar(x, y, color='lightblue', align='center')
 
# We could have also done this with two separate calls to `ax.bar` and numpy boolean indexing.
for bar, height in zip(vert_bars, y):
    if height < 0:
        bar.set(edgecolor='darkred', color='salmon', linewidth=3)
 
plt.show()
```

![img](https://img-blog.csdnimg.cn/f764d1ee17974ad38bd2b033482a9ac8.png)

### 3.5 直方图

 直方图用于统计数据出现的次数或者频率，有多种参数可以调整，见下例：

```python
import matplotlib.pyplot as plt
import numpy as np
 
np.random.seed(19680801)
 
n_bins = 10
x = np.random.randn(1000, 3)
 
fig, axes = plt.subplots(nrows=2, ncols=2)
ax0, ax1, ax2, ax3 = axes.flatten()
 
colors = ['red', 'tan', 'lime']
ax0.hist(x, n_bins, density=True, histtype='bar', color=colors, label=colors)
ax0.legend(prop={'size': 10})
ax0.set_title('bars with legend')
 
ax1.hist(x, n_bins, density=True, histtype='barstacked')
ax1.set_title('stacked bar')
 
ax2.hist(x,  histtype='barstacked', rwidth=0.9)
 
ax3.hist(x[:, 0], rwidth=0.9)
ax3.set_title('different sample sizes')
 
fig.tight_layout()
plt.show()
```

参数中density控制Y轴是概率还是数量，与返回的第一个的变量对应。histtype控制着直方图的样式，默认是 ‘bar’，对于多个条形时就相邻的方式呈现如子图1， ‘barstacked’ 就是叠在一起，如子图2、3。 rwidth 控制着宽度，这样可以空出一些间隙，比较图2、3. 图4是只有一条数据时。
![img](https://img-blog.csdnimg.cn/260f1fdc61f64205ae96e21ec0920ab0.png)​

### 3.6 饼图 

```python
import matplotlib.pyplot as plt
 
labels = 'Frogs', 'Hogs', 'Dogs', 'Logs'
sizes = [15, 30, 45, 10]
explode = (0, 0.1, 0, 0)  # only "explode" the 2nd slice (i.e. 'Hogs')
 
fig1, (ax1, ax2) = plt.subplots(2)
ax1.pie(sizes, labels=labels, autopct='%1.1f%%', shadow=True)
ax1.axis('equal')
ax2.pie(sizes, autopct='%1.2f%%', shadow=True, startangle=90, explode=explode,
    pctdistance=1.12)
ax2.axis('equal')
ax2.legend(labels=labels, loc='upper right')
 
plt.show()
```

![img](https://img-blog.csdnimg.cn/348bb127e6dc47d6ae91e6db4d79c719.png)

### 3.7 箱形图 

箱型图（也称为盒须图）于 1977 年由美国著名统计学家**约翰·图基**（John Tukey）发明。它能显示出一组数据的最大值、最小值、中位数、及上下四分位数。

在箱型图中，我们从上四分位数到下四分位数绘制一个盒子，然后用一条垂直触须（形象地称为“盒须”）穿过盒子的中间。上垂线延伸至上边缘（最大值），下垂线延伸至下边缘（最小值）。箱型图结构如下所示：

![img](https://img-blog.csdnimg.cn/2311b20338304d9aa4d1bbe1adc31f0d.png)

首先准备创建箱型图所需数据：可以使用`numpy.random.normal()`函数来创建一组基于正态分布的随机数据，该函数有三个参数，分别是正态分布的平均值、标准差以及期望值的数量然后用 data_to_plot 变量指定创建箱型图所需的数据序列，最后用 boxplot() 函数绘制箱型图。

```python
import matplotlib.pyplot as plt
import numpy as np
 
# 利用随机数种子使每次生成的随机数相同
np.random.seed(10)
collectn_1 = np.random.normal(100, 10, 200)
collectn_2 = np.random.normal(80, 30, 200)
collectn_3 = np.random.normal(90, 20, 200)
collectn_4 = np.random.normal(70, 25, 200)
data_to_plot = [collectn_1, collectn_2, collectn_3, collectn_4]
 
fig = plt.figure()
# 创建绘图区域
ax = fig.add_subplot(111)
# 创建箱型图
bp = ax.boxplot(data_to_plot)
plt.show()
```

![img](https://img-blog.csdnimg.cn/8e54f554d3ba49469e9733b138a3ce87.png)

### 3.8 泡泡图

散点图的一种，加入了第三个值 s 可以理解成普通散点，画的是二维，泡泡图体现了Z的大小，如下例：

```python
import matplotlib.pyplot as plt
import numpy as np
 
np.random.seed(19680801)
 
N = 50
x = np.random.rand(N)
y = np.random.rand(N)
colors = np.random.rand(N)
area = (30 * np.random.rand(N))**2  # 0 to 15 point radii
 
plt.scatter(x, y, s=area, c=colors, alpha=0.5)
plt.show()
```

![img](https://img-blog.csdnimg.cn/98995ca3c24143e8bf6a8acaa6de8176.png)

### 3.9 等高线图（轮廓图）

等高线图（也称“水平图”）是一种在二维平面上显示 3D 图像的方法。等高线有时也被称为 “Z 切片”，如果您想要查看因变量 Z 与自变量 X、Y 之间的函数图像变化（即 Z=f(X,Y)），那么采用等高线图最为直观。

```python
import numpy as np
import matplotlib.pyplot as plt
 
"""
np.linspace()在指定的大间隔内[-4.0,4.0]，返回固定间隔100个数据
"""
x = np.linspace(-4.0, 4.0, 100)
y = np.linspace(-4.0, 4.0, 100)
 
"""
np.meshgrid()两个坐标轴上的点在平面上画格,产生一个以向量x为行，向量y为列的矩
"""
X, Y = np.meshgrid(x, y)
 
# 定义Z与X,Y之间的关系,即原方程x²+y²=r²
Z = np.sqrt(X ** 2 + Y ** 2)
 
fig, axes = plt.subplots(1, 2, figsize=(16, 9))
 
axes[0].contour(X, Y, Z, alpha=0.75, cmap=plt.cm.hot)
 
cp = axes[1].contourf(X, Y, Z, cmap=plt.cm.hot)
 
fig.colorbar(cp)
plt.show()
```

![img](https://img-blog.csdnimg.cn/cf6723c75f1543aeb82eac3e2f58b373.png)









