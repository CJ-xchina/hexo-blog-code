---
title: Python常用工具包
date: 2023年9月13日23:10:52
tags: Python
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

# Numpy

## **1 Numpy概述**

### **1.1 概念**

Python本身含有列表和数组，但对于大数据来说，这些结构是有很多不足的。由于列表的元素可以是任何对象，因此列表中所保存的是对象的指针。对于数值运算来说这种 结构比较浪费内存和CPU资源。至于数组对象，它可以直接保存 数值，和C语言的一维数组比较类似。但是由于它不支持多维，在上面的函数也不多，因此也不适合做数值运算。Numpy提供了两种基本的对象：**ndarray(N-dimensional Array Object)** 和 **ufunc(Universal Function Object)**。

### **1.2 功能**

- 创建n维数组(矩阵)
- 对数组进行函数运算，使用函数计算十分快速，节省了大量的时间，且不需要编写循环，十分方便
- 数值积分、线性代数运算、傅里叶变换
- ndarray快速节省空间的多维数组，提供数组化的算术运算和高级的 广播功能。
- NumPy中的核心对象是ndarray
- NumPy里面所有的函数都是围绕ndarray展开的

![img](https://pic3.zhimg.com/80/v2-b78a1d4589cc6d5f4e2d5c31a816ae9e_720w.webp)

### 1.3 Ndarray 对象

NumPy 最重要的一个特点是其 N 维数组对象 ndarray，它是一系列同类型数据的集合，以 0 下标为开始进行集合中元素的索引。

**ndarray 对象是用于存放同类型元素的多维数组，每个元素在内存中都有相同存储大小的区域**。

ndarray 内部由以下内容组成：

- 一个指向数据（内存或内存映射文件中的一块数据）的指针。
- 数据类型或 dtype，描述在数组中的固定大小值的格子。
- 一个表示数组形状（shape）的元组，表示各维度大小的元组。
- 一个跨度元组（stride），其中的整数指的是为了前进到当前维度下一个元素需要"跨过"的字节数。

ndarray 的内部结构:



![img](https://www.runoob.com/wp-content/uploads/2018/10/ndarray.png)

跨度可以是负数，这样会使数组在内存中后向移动，切片中 **obj[::-1]** 或 **obj[:,::-1]** 就是如此。

创建一个 ndarray 只需调用 NumPy 的 array 函数即可：

```
numpy.array(object, dtype = None, copy = True, order = None, subok = False, ndmin = 0)
```

**参数说明：**

| 名称   | 描述                                                      |
| :----- | :-------------------------------------------------------- |
| object | 数组或嵌套的数列                                          |
| dtype  | 数组元素的数据类型，可选                                  |
| copy   | 对象是否需要复制，可选                                    |
| order  | 创建数组的样式，C为行方向，F为列方向，A为任意方向（默认） |
| subok  | 默认返回一个与基类类型一致的数组                          |
| ndmin  | 指定生成数组的最小维度                                    |

举例说明：

```py
import numpy as np 
a = np.array([1,2,3])  
print (a)
# 输出 ：
[1 2 3]
```

```py
# 多于一个维度  
import numpy as np 
a = np.array([[1,  2],  [3,  4]])  
print (a)
# 输出：
[[1  2] 
 [3  4]]
```

```py
# 最小维度  
import numpy as np 
a = np.array([1, 2, 3, 4, 5], ndmin =  2)  
print (a)
# 输出：
[[1 2 3 4 5]]
```

```py
# dtype 参数  
import numpy as np 
a = np.array([1,  2,  3], dtype = complex)  
print (a)
# 输出：
[1.+0.j 2.+0.j 3.+0.j]
```

### **1.4 数据类型**

numpy 支持的数据类型比 Python 内置的类型要多很多，基本上可以和 C 语言的数据类型对应上，其中部分类型对应为 Python 内置的类型。下表列举了常用 NumPy 基本类型。

| 名称       | 描述                                                         |
| :--------- | :----------------------------------------------------------- |
| bool_      | 布尔型数据类型（True 或者 False）                            |
| int_       | 默认的整数类型（类似于 C 语言中的 long，int32 或 int64）     |
| intc       | 与 C 的 int 类型一样，一般是 int32 或 int 64                 |
| intp       | 用于索引的整数类型（类似于 C 的 ssize_t，一般情况下仍然是 int32 或 int64） |
| int8       | 字节（-128 to 127）                                          |
| int16      | 整数（-32768 to 32767）                                      |
| int32      | 整数（-2147483648 to 2147483647）                            |
| int64      | 整数（-9223372036854775808 to 9223372036854775807）          |
| uint8      | 无符号整数（0 to 255）                                       |
| uint16     | 无符号整数（0 to 65535）                                     |
| uint32     | 无符号整数（0 to 4294967295）                                |
| uint64     | 无符号整数（0 to 18446744073709551615）                      |
| float_     | float64 类型的简写                                           |
| float16    | 半精度浮点数，包括：1 个符号位，5 个指数位，10 个尾数位      |
| float32    | 单精度浮点数，包括：1 个符号位，8 个指数位，23 个尾数位      |
| float64    | 双精度浮点数，包括：1 个符号位，11 个指数位，52 个尾数位     |
| complex_   | complex128 类型的简写，即 128 位复数                         |
| complex64  | 复数，表示双 32 位浮点数（实数部分和虚数部分）               |
| complex128 | 复数，表示双 64 位浮点数（实数部分和虚数部分）               |

numpy 的数值类型实际上是 dtype 对象的实例，并对应唯一的字符，包括 np.bool_，np.int32，np.float32，等等。

### 1.5 数据类型对象 (dtype)

数据类型对象（numpy.dtype 类的实例）用来描述与数组对应的内存区域是如何使用，它描述了数据的以下几个方面：：

- **数据的类型**（整数，浮点数或者 Python 对象）
- **数据的大小**（例如， 整数使用多少个字节存储）
- **数据的字节顺序**（小端法或大端法）
- 在结构化类型的情况下，字段的名称、每个字段的数据类型和每个字段所取的内存块的部分
- 如果数据类型是子数组，那么它的形状和数据类型是什么。

字节顺序是通过对数据类型预先设定 **<** 或 **>** 来决定的。 **<** 意味着小端法(最小值存储在最小的地址，即低位组放在最前面)。**>** 意味着大端法(最重要的字节存储在最小的地址，即高位组放在最前面)。

dtype 对象是使用以下语法构造的：

```py
numpy.dtype(object, align, copy)
```

- object - 要转换为的数据类型对象
- align - 如果为 true，填充字段使其类似 C 的结构体。
- copy - 复制 dtype 对象 ，如果为 false，则是对内置数据类型对象的引用

**例1：**

```py
import numpy as np
# 使用标量类型
dt = np.dtype(np.int32)
print(dt)
```

输出结果为：

```py
int32
```

**例2：**

```py
import numpy as np
# int8, int16, int32, int64 四种数据类型可以使用字符串 'i1', 'i2','i4','i8' 代替
dt = np.dtype('i4')
print(dt)
```

输出结果为：

```py
int32
```

**实例 3**

```py
import numpy as np
# 字节顺序标注
dt = np.dtype('<i4')
print(dt)
```

输出结果为：

```py
int32
```

下面实例展示结构化数据类型的使用，类型字段和对应的实际类型将被创建。

**实例 4**

```py
# 首先创建结构化数据类型 
import numpy as np 
dt = np.dtype([('age',np.int8)])  
print(dt)
```

输出结果为：

```py
[('age', 'i1')]
```

**实例 5**

```py
# 将数据类型应用于 ndarray 对象
import numpy as np
dt = np.dtype([('age',np.int8)]) 
a = np.array([(10,),(20,),(30,)], dtype = dt) 
print(a)
```

输出结果为：

```py
[(10,) (20,) (30,)]
```

**实例 6**

```py
# 类型字段名可以用于存取实际的 age 列
import numpy as np
dt = np.dtype([('age',np.int8)]) 
a = np.array([(10,),(20,),(30,)], dtype = dt) 
print(a['age'])
```

输出结果为：

```py
[10 20 30]
```

下面的示例定义一个结构化数据类型 student，包含字符串字段 name，整数字段 age，及浮点字段 marks，并将这个 dtype 应用到 ndarray 对象。

**实例 7**

```py
import numpy as np
student = np.dtype([('name','S20'), ('age', 'i1'), ('marks', 'f4')]) 
print(student)
```

输出结果为：

```py
[('name', 'S20'), ('age', 'i1'), ('marks', 'f4')]
```

**实例 8**

```py
import numpy as np
student = np.dtype([('name','S20'), ('age', 'i1'), ('marks', 'f4')]) 
a = np.array([('abc', 21, 50),('xyz', 18, 75)], dtype = student) 
print(a)
```

输出结果为：

```py
[('abc', 21, 50.0), ('xyz', 18, 75.0)]
```

每个内建类型都有一个唯一定义它的字符代码，如下：

| 字符 | 对应类型              |
| :--- | :-------------------- |
| b    | 布尔型                |
| i    | (有符号) 整型         |
| u    | 无符号整型 integer    |
| f    | 浮点型                |
| c    | 复数浮点型            |
| m    | timedelta（时间间隔） |
| M    | datetime（日期时间）  |
| O    | (Python) 对象         |
| S, a | (byte-)字符串         |
| U    | Unicode               |
| V    | 原始数据 (void)       |

## **2 Numpy数组操作**

### **2.1 Numpy创建数组**

#### **2.1.1 利用列表生成数组**

```py
import numpy as np

lst = [1, 2, 3, 4]
nd1 = np.array(lst)
print(nd1, type(nd1))
#[1 2 3 4] <class 'numpy.ndarray'>
```

#### 2.1.2 利用已有数组生成数组

`numpy.asarray()` 类似 numpy.array，但 numpy.asarray 参数只有三个，比 numpy.array 少两个。

```
numpy.asarray(a, dtype = None, order = None)
```

参数说明：

| 参数  | 描述                                                         |
| :---- | :----------------------------------------------------------- |
| a     | **任意形式的输入参数**，可以是，列表, 列表的元组, 元组, 元组的元组, 元组的列表，多维数组 |
| dtype | 数据类型，可选                                               |
| order | 可选，有"C"和"F"两个选项,分别代表，行优先和列优先，在计算机内存中的存储元素的顺序。 |

> asarray() 与 array()的比较：
>
> `array()`被调用后会创建一个新的NumPy对象，`asarray()`被调用后，如果输入已经是一个 NumPy 数组，`np.asarray` 不会创建副本，而是返回输入数组的引用。

`numpy.fromiter()` 方法从可迭代对象中建立 ndarray 对象，返回一维数组。

```py
numpy.fromiter(iterable, dtype, count=-1)
```

| 参数     | 描述                                   |
| :------- | :------------------------------------- |
| iterable | 可迭代对象                             |
| dtype    | 返回数组的数据类型                     |
| count    | 读取的数据数量，默认为-1，读取所有数据 |

```py
import numpy as np 
 
# 使用 range 函数创建列表对象  
list=range(5)
it=iter(list)
 
# 使用迭代器创建 ndarray 
x=np.fromiter(it, dtype=float)
print(x)
```

输出结果为：

```
[0. 1. 2. 3. 4.]
```

#### **2.1.3 利用random模块生成数组**

下面是random模块的一些常用函数



<img src="https://pic4.zhimg.com/80/v2-90252d46d86d3ac40bd8c34378df8fb7_720w.webp" alt="img" style="zoom:150%;" />

使用如下：

```py
import numpy as np
#0到1标准正态分布
arr1 = np.random.randn(3, 3)
#0到1均匀分布
arr2 = np.random.rand(3, 3)
#均匀分布的随机数（浮点数），前两个参数表示随机数的范围，第三个表示生成随机数的个数
arr3 = np.random.uniform(0, 10, 2)
#均匀分布的随机数（整数），前两个参数表示随机数的范围，第三个表示生成随机数的个数
arr4 = np.random.randint(0, 10, 3)
print(f'arr1 : {arr1}\narr2 : {arr2}\narr3 : {arr3}\narr4 : {arr4}')
out : 
# arr1 : [[-0.31637952 -0.08258995  1.43866984]
#  [-0.11216775  0.43881134  0.11745847]
#  [-1.1770306  -0.97657465  2.2368878 ]]
# arr2 : [[0.16350611 0.4467384  0.9465067 ]
#  [0.1882318  0.40261184 0.93577701]
#  [0.56243911 0.69179631 0.83407725]]
# arr3 : [4.41402883 6.03259052]
# arr4 : [9 7 7]
```

如果想使每次生成的数据相同，可以指定一个随机种子

```text
import numpy as np
np.random.seed(123)
arr = np.random.rand(2, 3)#[[0.69646919 0.28613933 0.22685145] [0.55131477 0.71946897 0.42310646]]
#打乱数组
np.random.shuffle(arr)#[[0.55131477 0.71946897 0.42310646] [0.69646919 0.28613933 0.22685145]]
```

#### **2.1.4 创建特定形状数组**

主要有如下几种：

<img src="https://pic1.zhimg.com/80/v2-3b6eaf72f99c0e3d5bf15597984a5fe4_720w.webp" alt="img" style="zoom:150%;" />



```py
import numpy as np

#未初始化的数组
arr1 = np.empty((2,3))
#数组元素以 0 来填充
arr2 = np.zeros((2, 3))
#数组元素以 1 来填充
arr3 = np.ones((2, 3))
#数组以指定的数来进行填充，这里举例3
arr4 = np.full((2, 3), 3)
#生成单位，对角线上元素为 1，其他为0
arr5 = np.eye(2)
#二维矩阵输出矩阵对角线的元素，一维矩阵形成一个以一维数组为对角线元素的矩阵
arr6 = np.diag(np.array([[1, 2, 3], [4, 5, 6], [7, 8, 9]]))
```

在创建给定长度的等差数列时，要注意的是np.linspace形成的数组一定包括范围的首位两个元素，则步长为(end - start) / (length - 1)。而np.arange是自己指定的步长(默认为1)也就意味着形成的数组不一定包括末尾数

```py
arr7 = np.linspace(0, 1, 4) #out : array([0.        , 0.33333333, 0.66666667, 1.        ])
arr8 = np.arange(0, 9, 2) #out : array([0, 2, 4, 6, 8])
```

#### 2.1.5 从数值范围创建数组

`numpy.arange()`

numpy 包中的使用 arange 函数创建数值范围并返回 ndarray 对象，函数格式如下：

```
numpy.arange(start, stop, step, dtype)
```

根据 start 与 stop 指定的范围以及 step 设定的步长，生成一个 ndarray。

参数说明：

| 参数    | 描述                                                         |
| :------ | :----------------------------------------------------------- |
| `start` | 起始值，默认为`0`                                            |
| `stop`  | 终止值（不包含）                                             |
| `step`  | 步长，默认为`1`                                              |
| `dtype` | 返回`ndarray`的数据类型，如果没有提供，则会使用输入数据的类型。 |

**生成 0 到 4 长度为 5 的数组:**

```py
import numpy as np
 
x = np.arange(5)  
print (x)
```

输出结果如下：

```py
[0  1  2  3  4]
```

**设置返回类型位 float:**

```py
import numpy as np
 
# 设置了 dtype
x = np.arange(5, dtype =  float)  
print (x)
```

输出结果如下：

```py
[0.  1.  2.  3.  4.]
```

**设置了起始值、终止值及步长：**

```py
import numpy as np
x = np.arange(10,20,2)  
print (x)
```

输出结果如下：

```py
[10  12  14  16  18]
```

**`numpy.linspace()`**

numpy.linspace() 函数用于创建一个一维数组，数组是一个等差数列构成的，格式如下：

```py
np.linspace(start, stop, num=50, endpoint=True, retstep=False, dtype=None)
```

参数说明：

| 参数       | 描述                                                         |
| :--------- | :----------------------------------------------------------- |
| `start`    | 序列的起始值                                                 |
| `stop`     | 序列的终止值，如果`endpoint`为`true`，该值包含于数列中       |
| `num`      | 要生成的等步长的样本数量，默认为`50`                         |
| `endpoint` | 该值为 `true` 时，数列中包含`stop`值，反之不包含，默认是True。 |
| `retstep`  | 如果为 True 时，生成的数组中会显示间距，反之不显示。         |
| `dtype`    | `ndarray` 的数据类型                                         |

**以下实例用到三个参数，设置起始点为 1 ，终止点为 10，数列个数为 10：**

```py
import numpy as np
a = np.linspace(1,10,10)
print(a)
```

输出结果为：

```
[ 1.  2.  3.  4.  5.  6.  7.  8.  9. 10.]
```

**设置元素全部是1的等差数列：**

```py
import numpy as np
 
a = np.linspace(10, 20,  5, endpoint =  False)  
print(a)
```

输出结果为：

```py
[10. 12. 14. 16. 18.]
```

如果将 endpoint 设为 true，则会包含 20。

**以下实例设置间距：**

```py
import numpy as np
a =np.linspace(1,10,10,retstep= True)
 
print(a)
# 拓展例子
b =np.linspace(1,10,10).reshape([10,1])
print(b)
```

输出结果为：

```py(array([ 1.,  2.,  3.,  4.,  5.,  6.,  7.,  8.,  9., 10.]), 1.0)
[[ 1.]
 [ 2.]
 [ 3.]
 [ 4.]
 [ 5.]
 [ 6.]
 [ 7.]
 [ 8.]
 [ 9.]
 [10.]]
```

`numpy.logspace（）`

numpy.logspace() 函数用于创建一个于等比数列。格式如下：

```py
np.logspace(start, stop, num=50, endpoint=True, base=10.0, dtype=None)
```

base 参数意思是取对数的时候 log 的下标。

| 参数       | 描述                                                         |
| :--------- | :----------------------------------------------------------- |
| `start`    | 序列的起始值为：base ** start                                |
| `stop`     | 序列的终止值为：base ** stop。如果`endpoint`为`true`，该值包含于数列中 |
| `num`      | 要生成的等步长的样本数量，默认为`50`                         |
| `endpoint` | 该值为 `true` 时，数列中中包含`stop`值，反之不包含，默认是True。 |
| `base`     | 对数 log 的底数。                                            |
| `dtype`    | `ndarray` 的数据类型                                         |

将对数的底数设置为 2 :

```py
import numpy as np 
a = np.logspace(0,9,10,base=2) 
print (a)
```

输出如下：

```py
[  1.   2.   4.   8.  16.  32.  64. 128. 256. 512.]
```

### **2.2 索引和切片**

Numpy可以通过索引或切片来访问和修改，与 Python 中 list 的切片操作一样，设置start, stop 及 step 参数。

#### **2.2.1 元素表示**

Numpy数组的下标表示与list是一样的，对于矩阵来说，要注意中括号里要用逗号将行和列的表示进行分隔。基本的表示方法如下图，左边为表达式，右边为表达式获取的元 素。注意，不同的边界，表示不同的表达式。

![img](https://pic3.zhimg.com/80/v2-3f1b245e110dc1018cbf608b666dd8ea_720w.webp)

例子：
`a = np.array([[1, 2, 3, 4], [5, 6, 7, 8]])`
`a[0]` : 指的是第一行
`a[1, 2]` 或者` a[1][2]` : 全下标定位单个元素，在a中表示7这个元素

#### **2.2.2 切片表示**

若`a = np.arange(10)`，`b = a[2 : 7 : 2]`则表示从索引 2 开始到索引 7 停止，间隔为 2，即b为[2, 4, 6]。此外也可以通过切片操作来对元素进行修改，如：

```py
a = np.array([
     [1, 2, 3], 
     [4, 5, 6], 
     [7, 8, 9]
])
a[0 , 1 : 3] = 100, 101
#a[0 , 1 : 3]表示第一行的第二列和第二列即[2, 3]
'''
array([
[  1, 100, 101], 
[  4,   5,   6], 
[  7,   8,   9]
])'''

```

#### **2.2.3 多维数组的切片**

NumPy的多维数组和一维数组类似。多维数组有多个轴。从内到外分别是第0轴，第1轴，第2轴......切片后的数据与切片前的数据共享原数组的储存空间

![img](https://pic4.zhimg.com/80/v2-b8c75f2864d1598c8db147453a2eb1d7_720w.webp)

整数数组索引是指使用一个数组来访问另一个数组的元素。这个数组中的每个元素都是目标数组中某个维度上的索引值。

以下实例获取数组中 **(0,0)，(1,1)** 和 **(2,0)** 位置处的元素。

```py
import numpy as np 
 
x = np.array([[1,  2],  [3,  4],  [5,  6]]) 
# 想象为：y = x[a:b,c:d]，其中a:b，c:d分别是两个一维数组
y = x[[0,1,2],  [0,1,0]]  
print (y)
```

输出结果为：

```
[1  4  5]
```

当然，切片操作是针对我们想要获取的数据是连续的，如果我们想要获取离散数据就不能使用切片的方法，再者就是我们不能一个一个来进行提取，Numpy有一种很方便的方法可以获得离散数据。即下面

```py
x = np.array([
     [ 0, 1, 2],
     [ 3, 4, 5],
     [ 6, 7, 8],
     [ 9, 10, 11]
]) 
# 可以假想为访问：(0,0),(0,2),(3,0),(3,2)
rows = np.array( [ [0,0],[3,3] ] ) 
cols = np.array( [ [0,2],[0,2] ] ) 
y = x[rows,cols]

'''
out : array([
[ 0,  2], 
[ 9, 11]
])
''' 
```

#### **2.2.4 布尔索引**

顾名思义，通过布尔运算（如：比较运算符）来获取符合指定条件的元素的数组。

```py
x = np.array([[ 0, 1, 2],[ 3, 4, 5],[ 6, 7, 8],[ 9, 10, 11]]) 
print(x[x > 5]) # out : [ 6  7  8  9 10 11]
b = x > 5
b # 打印布尔运算的结果
```



![img](https://pic4.zhimg.com/80/v2-989c2810b2bd306ad2099446d9bccd63_720w.webp)

以下实例演示如何从数组中过滤掉非复数元素。

```py
a = np.array([1, 2 + 6j, 5, 3.5 + 5j])
print(a[np.iscomplex(a)])

b = np.iscomplex(a)
print(b)
```

输出如下：

```py
[2. +6.j 3.5+5.j]
[False  True False  True]
```

#### **2.2.5 元素查找定位**

Numpy库中提供了where函数来查找满足条件元素的索引，表示如下：

- `np.where(condition, x, y)`: 满足条件(condition)，输出x，不满足输出y
- `np.where(condition)`: 输出满足条件 (即非0) 元素的坐标

```py
a = np.array([2,4,6,8,10,3]).reshape(2,3) 
c = np.where(a > 5) # 返回索引 
# out : (array([0, 1, 1], dtype=int64), array([2, 0, 1], dtype=int64)) 即：(0,2) (1,0) (1,1) 坐标均满足
a[c] # 获得元素
```

#### **2.2.6 元素删除**

`np.delete(arr, obj, axis=None)`

- 第一个参数：要处理的矩阵，
- 第二个参数，处理的位置，下标
- 第三个参数，0表示按照行删除，1表示按照列删除，默认为0
- 返回值为删除后的剩余元素构成的矩阵

```py
arr = np.array([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]])
np.delete(arr, [1], 0) # 表示删除第二行
```

### **2.3 Numpy数组的操作 **

[看不懂看这个](https://www.runoob.com/numpy/numpy-array-manipulation.html#numpy_oparr4)

#### **2.3.1 拼接**

下面的图列举了常见的用于数组或向量 合并的方法。

<img src="https://pic4.zhimg.com/80/v2-6e7f38a7176fc1732474a48fab7498f3_720w.webp" alt="img" style="zoom:150%;" />

说明：

- append、concatenate以及stack都有一个axis参数，用于控制数组的合 并方式是按行还是按列。
- 对于append和concatenate，待合并的数组必须有相同的行数或列数
- stack、hstack、dstack，要求待合并的数组必须具有相同的形状

```py
a = np.array([[1, 2], [3, 4]])
b = np.array([[5, 6], [7, 8]])
np.hstack((a,b)) #等效于 np.concatenate((a,b),axis = 1)
# out : array([[1, 2, 5, 6], [3, 4, 7, 8]])

a = np.array([[1, 2], [3, 4]])
b = np.array([[5, 6], [7, 8]])
np.vstack((a,b)) #等价于 np.concatenate((a,b),axis = 0)
# out : array([[1, 2], [3, 4], [5, 6], [7, 8]]
```

#### **2.3.2 分割**

- 水平分割：`np.split(arr,n,axis=1)` 或` np.hsplit(arr,n)`：按列分成n份。返回一个list
- 垂直分割：`np.split(arr,n,axis=0)` 或 `np.vsplit(arr,n)`：按行分成n份，返回一个list

```py
x = np.arange(12).reshape(3, 4)
np.split(x, 3) 
# out : [array([[0, 1, 2, 3]]), array([[4, 5, 6, 7]]), array([[ 8,  9, 10, 11]])]

y = np.arange(9).reshape(1, 9)
np.split(y, 3, axis = 1) 
# out : [array([[0, 1, 2]]), array([[3, 4, 5]]), array([[6, 7, 8]])]
```

#### **2.3.3 维度变换**

在机器学习以及深度学习的任务中，通常需要将处理好的数据以模型能 接收的格式输入给模型，然后由模型通过一系列的运算，最终返回一个处理 结果。然而，由于不同模型所接收的输入格式不一样，往往需要先对其进行 一系列的变形和运算，从而将数据处理成符合模型要求的格式。在矩阵或者 数组的运算中，经常会遇到需要把多个向量或矩阵按某轴方向合并，或展平 (如在卷积或循环神经网络中，在全连接层之前，需要把矩阵展平)的情 况。下面介绍几种常用的数据变形方法。

<img src="https://pic2.zhimg.com/80/v2-5ff9d8dd12ccecb0824b3ebfdfc25fc9_720w.webp" alt="img" style="zoom:150%;" />

*1)* ***`reshape`***
不改变原数组元素，返回一个新的shape维度的数组(维度变换)

```py
x = np.arange(12).reshape(3, 4)
x # out : array([[ 0,  1,  2,  3], [ 4,  5,  6,  7], [ 8,  9, 10, 11]])

# 指定维度时可以只指定行数或列数, 其他用 -1 代替
x.reshape(3, -1) # out : array([[ 0,  1,  2,  3], [ 4,  5,  6,  7], [ 8,  9, 10, 11]])
```

*2)* ***`resize`***

改变向量的维度(修改向量本身)：

```py
arr =np.arange(10) 
print(arr) # out : [0 1 2 3 4 5 6 7 8 9]

arr.resize(2, 5) # 将向量 arr 维度变换为2行5列 
print(arr) # out : [[0 1 2 3 4], [5 6 7 8 9]]
```

*3)* ***`T`***

矩阵转置

```py
arr = np.arange(8).reshape(2, 4)
arr.shape # out : (2, 4)
arr.T.shape # out : (4, 2)
```

*4)*` ravel`

向量展平

```py
arr = np.arange(8).reshape(2, 4)
arr.ravel() # out : array([0, 1, 2, 3, 4, 5, 6, 7])
```

*5)* ***`flatten`***

把矩阵转换为向量，相较于`ravel`不会改变原矩阵

```py
arr = np.arange(8).reshape(2, 4)
arr.flatten() # out : array([0, 1, 2, 3, 4, 5, 6, 7])
```

*6)* ***`squeeze`***

这是一个主要用来降维的函数，把矩阵中含1的维度去掉

```py
arr = np.arange(8).reshape(2, 4, 1)
arr.shape # out : (2, 4, 1)
arr.squeeze().shape # out : (2, 4)
```

*7)* ***`transpose`***

对高维矩阵进行轴对换，这个在深度学习中经常使用，比如把图片中表 示颜色顺序的RGB改为GBR。

```py
arr = np.arange(12).reshape(2, 6, 1)
arr.shape # out : (2, 6, 1)
arr.transpose(1, 2, 0).shape # out : (6, 1, 2)
```

*拓展*

*8)* ***`swapaxes`***

将两个维度调换, 就是把对应的下标换个位置，类似于transpose

```py
arr = np.arange(20).reshape(4, 5)
arr.swapaxes(1, 0)
```

### **2.5 Numpy数值计算**

#### **2.5.1 通用函数对象(ufunc)**

ufunc是universal function的简称，种能对数组每个元素进行运算的函数。NumPy的许多ufunc函数都是用C语言实现的，因此它们的运算速度非常快。下图是在数据批量处过程中较为常用的几个函数

<img src="https://pic4.zhimg.com/80/v2-eb7cf3dc8e4707469268907cbceebc37_720w.webp" alt="img" style="zoom:200%;" />

使用的格式基本如下：np.函数名(数组， 指定计算的维度(默认为0))，如：

```py
a = np.array([
     [6, 3, 7, 4, 6], 
     [9, 2, 6, 7, 4], 
     [3, 7, 7, 2, 5], 
     [4, 1, 7, 5, 1]
])
np.sum(a, axis = 0) # out : array([22, 13, 27, 18, 16])
np.sum(a, axis = 1)# out : array([26, 28, 24, 18]
```

其余函数使用过程均可参考上述求和过程。下面继续介绍一下数组的排序问题。主要使用函数有`np.min`，`np.max`，`np.median`。

```py
arr = np.array([
     [10, 11, 12], 
     [13, 14, 15]
])
np.min(arr, axis = 0) # out : array([10, 11, 12]) 按行求最小值，即列不变，行变
np.min(arr, axis = 1) # out : array([10, 13]) 按列求最小值，即行不变，列变
```

我们可以通过`np.argmin`，`np.argmax`获得相对应的最小值、最大值的下标

```py
arr = np.array([
[10, 14, 12], 
[13, 11, 15]
])
np.argmin(arr, axis = 0) # out : array([0, 1, 0], dtype=int64) 按行求最小值，即列不变，行变
np.argmin(arr, axis = 1) # out : array([0, 1], dtype=int64) 按列求最小值，即行不变，列变
```

使用`np.sort`和`np.argsor`进行排序并排序后的下标

```py
arr = np.array([1, 3, 5, 2, 4])
np.sort(arr) # out : array([1, 2, 3, 4, 5])
np.argsort(arr) # out : array([0, 3, 1, 4, 2], dtype=int64)
```

#### **2.5.2 矩阵运算**

##### 对应元素相乘

对应元素相乘（Element-Wise Product）是两个矩阵中对应元素乘积。 `np.multiply`函数用于数组或矩阵对应元素相乘，输出与相乘数组或矩阵的大 小一致。

```py
a = np.array([[1,0],[0,1]])
b = np.array([[4,1],[2,2]])
np.multiply(a, b) # 等效于a * b，out : array([[4, 0], [0, 2]])
```

计算过程如下图：

![img](https://pic4.zhimg.com/80/v2-42107955f3ca0b847d6014a33f3f9967_720w.webp)

##### 点积运算

点积运算(Dot Product)又称为内积，在Numpy用`np.dot`或者`np.matmul`表示

```py
numpy.dot(a, b, out=None) 
```

**参数说明：**

- **a** : ndarray 数组
- **b** : ndarray 数组
- **out** : ndarray, 可选，用来保存dot()的计算结果

```py
a = np.array([[1,0],[0,1]])
b = np.array([[4,1],[2,2]])
np.dot(a, b) # 等效于np.matmul(a, b) out : array([[4, 1], [2, 2]])
```

计算过程如下图：

![img](https://pic1.zhimg.com/80/v2-2886532cc18f53c1888e98eca32c3e80_720w.webp)

##### 计算行列式

`numpy.linalg.det()` 函数计算输入矩阵的行列式。

```py
arr = np.array([[1,2], [3,4]]) 
np.linalg.det(arr) # out : -2.0000000000000004
```

##### 矩阵求逆

`numpy.linalg.inv() `函数计算矩阵的乘法逆矩阵。

```py
arr = np.array([[1,2], [3,4]]) 
np.linalg.inv(arr) # out : array([[-2. ,  1. ], [ 1.5, -0.5]])
```

##### **特征值和特征向量**

```py
A = np.random.randint(-10,10,(4,4))
C = np.dot(A.T, A)
vals, vecs = np.linalg.eig(C) 
print(f'特征值 : {vals}, 特征向量 : {vecs}')
out : 
特征值 : [395.26566729 358.52489695  44.41465068  52.79478508]
特征向量 : [[ 0.30221599  0.64309202 -0.64757004 -0.27522935]
             [ 0.87819925 -0.03518532  0.18871425  0.43808105]
             [-0.35779498  0.26192443 -0.27010759  0.85464626]
             [ 0.09702746 -0.71874212 -0.68708214  0.04374437]]
```

##### 线性方程解

`numpy.linalg.solve()` 函数给出了矩阵形式的线性方程的解。

考虑以下线性方程：

```
x + y + z = 6

2y + 5z = -4

2x + 5y - z = 27
```

可以使用矩阵表示为：

![img](https://www.runoob.com/wp-content/uploads/2018/10/118142-7ab3daa7f65551e6.jpg)

如果矩阵成为A、X和B，方程变为：

```
AX = B

或

X = A^(-1)B
```

### **2.6 插值运算**

这个过程其实就是我们在数学中已知一个函数，然后给出x值，让你根据这个函数求对应的y值，一般在曲线平滑处理中有较多的使用在Numpy中由numpy.interp(x, xp, fp, left=None, right=None, period=None)表示

- x - 表示将要计算的插值点x坐标
- xp - 表示已有的xp数组
- fp - 表示对应于已有的xp数组的值

```py
import matplotlib.pyplot as plt 
import numpy as np

x = np.linspace(0, 2 * np.pi, 10)
y = np.sin(x)

xvals = np.linspace(0, 2 * np.pi, 10000)
yinterp = np.interp(xvals, x, y)

plt.plot(x, y, 'r-', xvals, yinterp, 'b-')
plt.show()
```



![img](https://pic2.zhimg.com/80/v2-1a3707508752fecf79537d10e9f5d155_720w.webp)



### **2.7 曲线拟合**

我们在数学建模过程中得到我们的数据之后，如果我们想要使用某个函数去描述数据的规律，这个过程其实就在曲线拟合的过程，这里只介绍最简单的一种拟合方式。Numpy中由numpy.polyfit(x, y, deg)表示

- x为待拟合的x坐标
- y为待拟合的y坐标
- deg为拟合自由度，即多项式的最高次幂

```py
import matplotlib.pyplot as plt 
import numpy as np

x = np.array([0.0, 1.0, 2.0, 3.0, 4.0, 5.0])
y = np.array([0.0, 0.8, 0.9, 0.1, -0.8, -1.0])
#得到多项式的系数
z = np.polyfit(x, y, 3)
z2 = np.polyfit(x, y, 5)
#得到多项式函数
f = np.poly1d(z)
f2 = np.poly1d(z2)
#用两个函数进行拟合
xval = np.linspace(0, 10, 50)
yval1 = f(xval)
yval2 = f2(xval)
#作图
plt.plot(xval, yval1, 'r--o', xval, yval2, 'b-o')
plt.legend(['The deg is 3', 'The deg is 5'])
plt.show()

print(f) # out :  0.08704 x^3 - 0.8135 x^2 + 1.693 x - 0.03968
print(f2) # out : -0.008333 x^5 + 0.125 x^4 - 0.575 x^3 + 0.625 x^2 + 0.6333 x - 1.74e-14
```



![img](https://pic2.zhimg.com/80/v2-e90242be6ce6f8784f1ed932b2f53725_720w.webp)



由图能够看出，3和5自由度的函数在前面的函数曲线基本是重合的，但是约在7左右开始朝着相反方向进行变化，因此拟合函数的自由度对效果的影响是非常大的，找到一个合适的自由度至关重要。

## **3 Numpy IO操作**

*1) 保存数组*

保存一个数组到一个二进制的文件中,保存格式是.npy，Numpy中由np.save(file, array)表示。

*2) 读取文件*

arr = numpy.load(file): 读取npy 文件到内存

```py
arr = np.array([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
#保存数据
np.save('test.npy', arr)
#下载数据
np.load('test.npy') # out : array([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
```

*拓展*

保存到文本文件

- np.savetxt(fname, X, fmt=‘%.18e’, delimiter=‘ ‘)
- arr = numpy.loadtxt(fname, delimiter=None)

---

# Pandas

Pandas是使用Python语言开发的用于数据处理和数据分析的第三方库。它擅长处理数字型数据和时间序列数据，当然文本型的数据也能轻松处理。

## 安装

首先安装pandas库。打开“终端”并执行以下命令：

```python
pip install pandas matplotlib

# 如网络慢，可指定国内源快速下载安装
pip install pandas matplotlib -i https://pypi.tuna.tsinghua.edu.cn/simple
```

安装完成后，在终端中启动Jupyter Notebook，给文件命名，如pandas-01。在Jupyter Notebook中导入Pandas，按惯例起别名pd：

```python
# 引入 Pandas库，按惯例起别名pd
import pandas as pd
```

这样，我们就可以使用pd调用Pandas的所有功能了。

## 准备数据集

数据集（Data set或dataset），又称为资料集、数据集合或资料集合，是一种由数据组成的集合，可以简单理解成一个Excel表格。在分析处理数据时，我们要先了解数据集。对所持有数据各字段业务意义的理解是分析数据的前提。

介绍下我们后面会经常用的数据集team.xlsx，可以从网址 [https://www.gairuo.com/file/data/dataset/team.xlsx](https://link.zhihu.com/?target=https%3A//www.gairuo.com/file/data/dataset/team.xlsx) 下载。它的内容见表1。

![img](https://pic3.zhimg.com/v2-1aa9f4ce202dab18dc1d7b185e30bed6_b.webp?consumer=ZHI_MENG)

表1-1 team.xlxs 的部分内容

这是一个学生各季度成绩总表（节选），各列说明如下。

- name：学生的姓名，这列没有重复值，一个学生一行，即一条数据，共100条。
- team：所在的团队、班级，这个数据会重复。
- Q1～Q4：各个季度的成绩，可能会有重复值。

## 读取数据

pandas读取数据通常有下面几种方式：

| 函数                                                         | 说明                               |
| :----------------------------------------------------------- | :--------------------------------- |
| [pd.read_csv(filename)](https://zhuanlan.zhihu.com/p/340441922) | 读取 CSV 文件；（逗号分隔txt文件） |
| `pd.read_excel(filename)`                                    | 读取 Excel 文件；                  |
| `pd.read_sql(query, connection_object)`                      | 从 SQL 数据库读取数据；            |
| `pd.read_json(json_string)`                                  | 从 JSON 字符串中读取数据；         |
| `pd.read_html(url)`                                          | 从 HTML 页面中读取数据。           |

实例：读取本地存储的ex1data1.txt文件：

```py
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
path =  'ex1data1.txt'
data = pd.read_csv(path, header=None, names=['Population', 'Profit'])
data.head()
```

输出结果：

<img src="https://typora-md-bucket.oss-cn-beijing.aliyuncs.com/image-20230914182350808.png" alt="image-20230914182350808" style="zoom:67%;" />

其中：

- 自动增加了第一列，是Pandas为数据增加的索引，从0开始，程序不知道我们真正的业务索引，往往需要后面重新指定，使它有一定的业务意义；
- 由于数据量大，自动隐藏了中间部分，只显示前后5条；

## 查看数据

| 函数            | 说明                                                       |
| :-------------- | :--------------------------------------------------------- |
| `df.head(n)`    | 显示前 n 行数据；                                          |
| `df.tail(n)`    | 显示后 n 行数据；                                          |
| `df.info()`     | 显示数据的信息，包括列名、数据类型、缺失值等；             |
| `df.describe()` | 显示数据的基本统计信息，包括均值、方差、最大值、最小值等； |
| `df.shape`      | 显示数据的行数和列数。                                     |

## 数据清洗

| 函数                               | 说明                     |
| :--------------------------------- | :----------------------- |
| `df.dropna()`                      | 删除包含缺失值的行或列； |
| `df.fillna(value)`                 | 将缺失值替换为指定的值； |
| `df.replace(old_value, new_value)` | 将指定值替换为新值；     |
| `df.duplicated()`                  | 检查是否有重复的数据；   |
| `df.drop_duplicates()`             | 删除重复的数据。         |

## 数据选择和切片

| 函数                                            | 说明                                             |
| :---------------------------------------------- | :----------------------------------------------- |
| `df[column_name]`                               | 选择指定的列；                                   |
| `df[index_from: index_to]`                      | 指定选择[index_from,index_to)行，index为每行下标 |
| `df.loc[row_index, column_name]`                | 通过标签选择数据；                               |
| `df.iloc[row_index, column_index]`              | 通过位置选择数据；                               |
| `df.ix[row_index, column_name]`                 | 通过标签或位置选择数据；                         |
| `df.filter(items=[column_name1, column_name2])` | 选择指定的列；                                   |
| `df.filter(regex='regex')`                      | 选择列名匹配正则表达式的列；                     |
| `df.sample(n)`                                  | 随机选择 n 行数据。                              |

## 数据排序

| 函数                                                         | 说明                 |
| :----------------------------------------------------------- | :------------------- |
| `df.sort_values(column_name)`                                | 按照指定列的值排序； |
| `df.sort_values([column_name1, column_name2], ascending=[True, False])` | 按照多个列的值排序； |
| `df.sort_index()`                                            | 按照索引排序。       |

## 数据合并

| 函数                                 | 说明                             |
| :----------------------------------- | :------------------------------- |
| `pd.concat([df1, df2])`              | 将多个数据框按照行或列进行合并； |
| `pd.merge(df1, df2, on=column_name)` | 按照指定列将两个数据框进行合并。 |

## 数据选择和过滤

| 函数                                   | 说明                                   |
| :------------------------------------- | :------------------------------------- |
| `df.loc[row_indexer, column_indexer]`  | 按标签选择行和列。                     |
| `df.iloc[row_indexer, column_indexer]` | 按位置选择行和列。                     |
| `df[df['column_name'] > value]`        | 选择列中满足条件的行。                 |
| `df.query('column_name > value')`      | 使用字符串表达式选择列中满足条件的行。 |

------

## 数据统计和描述

| 函数            | 说明                                                 |
| :-------------- | :--------------------------------------------------- |
| `df.describe()` | 计算基本统计信息，如均值、标准差、最小值、最大值等。 |
| `df.mean()`     | 计算每列的平均值。                                   |
| `df.median()`   | 计算每列的中位数。                                   |
| `df.mode()`     | 计算每列的众数。                                     |
| `df.count()`    | 计算每列非缺失值的数量。                             |

# Matploblib

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









