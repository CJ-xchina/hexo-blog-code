------



title: NumPy
date: 2023年9月13日23:10:52
tags:
\- Python
\- Python工具包
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

------



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



```plain
numpy.array(object, dtype = None, copy = True, order = None, subok = False, ndmin = 0)
```



**参数说明：**

| 名称   | 描述                                                      |
| ------ | --------------------------------------------------------- |
| object | 数组或嵌套的数列                                          |
| dtype  | 数组元素的数据类型，可选                                  |
| copy   | 对象是否需要复制，可选                                    |
| order  | 创建数组的样式，C为行方向，F为列方向，A为任意方向（默认） |
| subok  | 默认返回一个与基类类型一致的数组                          |
| ndmin  | 指定生成数组的最小维度                                    |



举例说明：



```python
import numpy as np 
a = np.array([1,2,3])  
print (a)
# 输出 ：
[1 2 3]
```



```python
# 多于一个维度  
import numpy as np 
a = np.array([[1,  2],  [3,  4]])  
print (a)
# 输出：
[[1  2] 
 [3  4]]
```



```python
# 最小维度  
import numpy as np 
a = np.array([1, 2, 3, 4, 5], ndmin =  2)  
print (a)
# 输出：
[[1 2 3 4 5]]
```



```python
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
| ---------- | ------------------------------------------------------------ |
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



```python
numpy.dtype(object, align, copy)
```



- object - 要转换为的数据类型对象
- align - 如果为 true，填充字段使其类似 C 的结构体。
- copy - 复制 dtype 对象 ，如果为 false，则是对内置数据类型对象的引用



**例1：**



```python
import numpy as np
# 使用标量类型
dt = np.dtype(np.int32)
print(dt)
```



输出结果为：



```python
int32
```



**例2：**



```python
import numpy as np
# int8, int16, int32, int64 四种数据类型可以使用字符串 'i1', 'i2','i4','i8' 代替
dt = np.dtype('i4')
print(dt)
```



输出结果为：



```python
int32
```



**实例 3**



```python
import numpy as np
# 字节顺序标注
dt = np.dtype('<i4')
print(dt)
```



输出结果为：



```python
int32
```



下面实例展示结构化数据类型的使用，类型字段和对应的实际类型将被创建。



**实例 4**



```python
# 首先创建结构化数据类型 
import numpy as np 
dt = np.dtype([('age',np.int8)])  
print(dt)
```



输出结果为：



```python
[('age', 'i1')]
```



**实例 5**



```python
# 将数据类型应用于 ndarray 对象
import numpy as np
dt = np.dtype([('age',np.int8)]) 
a = np.array([(10,),(20,),(30,)], dtype = dt) 
print(a)
```



输出结果为：



```python
[(10,) (20,) (30,)]
```



**实例 6**



```python
# 类型字段名可以用于存取实际的 age 列
import numpy as np
dt = np.dtype([('age',np.int8)]) 
a = np.array([(10,),(20,),(30,)], dtype = dt) 
print(a['age'])
```



输出结果为：



```python
[10 20 30]
```



下面的示例定义一个结构化数据类型 student，包含字符串字段 name，整数字段 age，及浮点字段 marks，并将这个 dtype 应用到 ndarray 对象。



**实例 7**



```python
import numpy as np
student = np.dtype([('name','S20'), ('age', 'i1'), ('marks', 'f4')]) 
print(student)
```



输出结果为：



```python
[('name', 'S20'), ('age', 'i1'), ('marks', 'f4')]
```



**实例 8**



```python
import numpy as np
student = np.dtype([('name','S20'), ('age', 'i1'), ('marks', 'f4')]) 
a = np.array([('abc', 21, 50),('xyz', 18, 75)], dtype = student) 
print(a)
```



输出结果为：



```python
[('abc', 21, 50.0), ('xyz', 18, 75.0)]
```



每个内建类型都有一个唯一定义它的字符代码，如下：

| 字符 | 对应类型              |
| ---- | --------------------- |
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



```python
import numpy as np

lst = [1, 2, 3, 4]
nd1 = np.array(lst)
print(nd1, type(nd1))
#[1 2 3 4] <class 'numpy.ndarray'>
```



注意区分`np.array([1,2])` 和 `np.array([[1,2]])` ：

 

前一个矩阵的形状是 (2, ) 代表的是存储两个元素的一维矩阵；后一个矩阵形状是(1,3) 代表是有一行三列的二维矩阵。虽然两个矩阵存储数据相同，但是维度不同，如果滥用可能会出现错误，例如：

 

 

如果需要一维向二维数组的转化，可以使用

```python
import numpy as np

a = np.array([1, 2, 3])
b = np.array([[1, 2, 3]])

c = np.array([[1],[2],[3]])


e = np.dot(b, c)
# 报错，维度不同的矩阵无法相乘
d = np.dot(a, c)
print(d)
print(e)
```



#### 2.1.2 利用已有数组生成数组



`numpy.asarray()` 类似 numpy.array，但 numpy.asarray 参数只有三个，比 numpy.array 少两个。



```plain
numpy.asarray(a, dtype = None, order = None)
```



参数说明：

| 参数  | 描述                                                         |
| ----- | ------------------------------------------------------------ |
| a     | **任意形式的输入参数**，可以是，列表, 列表的元组, 元组, 元组的元组, 元组的列表，多维数组 |
| dtype | 数据类型，可选                                               |
| order | 可选，有"C"和"F"两个选项,分别代表，行优先和列优先，在计算机内存中的存储元素的顺序。 |



asarray() 与 array()的比较：

 

`array()`被调用后会创建一个新的NumPy对象，`asarray()`被调用后，如果输入已经是一个 NumPy 数组，`np.asarray` 不会创建副本，而是返回输入数组的引用。



`numpy.fromiter()` 方法从可迭代对象中建立 ndarray 对象，返回一维数组。



```python
numpy.fromiter(iterable, dtype, count=-1)
```

| 参数     | 描述                                   |
| -------- | -------------------------------------- |
| iterable | 可迭代对象                             |
| dtype    | 返回数组的数据类型                     |
| count    | 读取的数据数量，默认为-1，读取所有数据 |



```python
import numpy as np 
 
# 使用 range 函数创建列表对象  
list=range(5)
it=iter(list)
 
# 使用迭代器创建 ndarray 
x=np.fromiter(it, dtype=float)
print(x)
```



输出结果为：



```plain
[0. 1. 2. 3. 4.]
```



#### **2.1.3 利用random模块生成数组**



下面是random模块的一些常用函数



![img](https://pic4.zhimg.com/80/v2-90252d46d86d3ac40bd8c34378df8fb7_720w.webp)



使用如下：



```python
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



```latex
import numpy as np
np.random.seed(123)
arr = np.random.rand(2, 3)#[[0.69646919 0.28613933 0.22685145] [0.55131477 0.71946897 0.42310646]]
#打乱数组
np.random.shuffle(arr)#[[0.55131477 0.71946897 0.42310646] [0.69646919 0.28613933 0.22685145]]
```



#### **2.1.4 创建特定形状数组**



主要有如下几种：

| 函数                   | 描述                                                         |
| ---------------------- | ------------------------------------------------------------ |
| `np.zeros((3,4))`      | 创建3×4的元素全为0的数组，括号内数字数量代表创建数组的维度，例如：`np.zeros((1,2,3))`创建三维数组，但是有一个前提，括号数量必须是两对及以上！ |
| `np.ones((3,4))`       | 创建3×4的元素全为1的数组                                     |
| `np.empty((2,3))`      | 创建2×3的空数组，空数据中的值并不为0，而是未初始化的垃圾值   |
| `np.zeros_like(ndarr)` | 以ndar相同维度创建元素全为0数组                              |
| `np.ones_like(ndarr)`  | 以ndar相同维度创建元素全为1数组                              |
| `np.empty_like(ndarr)` | 以ndar相同维度创建空数组                                     |
| `np.eye(5)`            | np.eye(5)该两数用于创建一个5×5的矩阵，对角线为1，其余均为0   |
| `np.full((3,5),666)`   | 创建3×5的元素全为666的数组，666为指定值                      |



![img](https://pic1.zhimg.com/80/v2-3b6eaf72f99c0e3d5bf15597984a5fe4_720w.webp)



```python
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



```python
arr7 = np.linspace(0, 1, 4) #out : array([0.        , 0.33333333, 0.66666667, 1.        ])
arr8 = np.arange(0, 9, 2) #out : array([0, 2, 4, 6, 8])
```



#### 2.1.5 从数值范围创建数组



```
numpy.arange()
```



numpy 包中的使用 arange 函数创建数值范围并返回 ndarray 对象，函数格式如下：



```plain
numpy.arange(start, stop, step, dtype)
```



根据 start 与 stop 指定的范围以及 step 设定的步长，生成一个 ndarray。



参数说明：

| 参数    | 描述                                                         |
| ------- | ------------------------------------------------------------ |
| `start` | 起始值，默认为`0`                                            |
| `stop`  | 终止值（不包含）                                             |
| `step`  | 步长，默认为`1`                                              |
| `dtype` | 返回`ndarray`的数据类型，如果没有提供，则会使用输入数据的类型。 |



**生成 0 到 4 长度为 5 的数组:**



```python
import numpy as np

x = np.arange(5)  
print (x)
```



输出结果如下：



```python
[0  1  2  3  4]
```



**设置返回类型位 float:**



```python
import numpy as np
 
# 设置了 dtype
x = np.arange(5, dtype =  float)  
print (x)
```



输出结果如下：



```python
[0.  1.  2.  3.  4.]
```



**设置了起始值、终止值及步长：**



```python
import numpy as np
x = np.arange(10,20,2)  
print (x)
```



输出结果如下：



```python
[10  12  14  16  18]
```



```
**numpy.linspace()**
```



numpy.linspace() 函数用于创建一个一维数组，数组是一个等差数列构成的，格式如下：



```python
np.linspace(start, stop, num=50, endpoint=True, retstep=False, dtype=None)
```



参数说明：

| 参数       | 描述                                                         |
| ---------- | ------------------------------------------------------------ |
| `start`    | 序列的起始值                                                 |
| `stop`     | 序列的终止值，如果`endpoint`为`true`，该值包含于数列中       |
| `num`      | 要生成的等步长的样本数量，默认为`50`                         |
| `endpoint` | 该值为 `true` 时，数列中包含`stop`值，反之不包含，默认是True。 |
| `retstep`  | 如果为 True 时，生成的数组中会显示间距，反之不显示。         |
| `dtype`    | `ndarray` 的数据类型                                         |



**以下实例用到三个参数，设置起始点为 1 ，终止点为 10，数列个数为 10：**



```python
import numpy as np
a = np.linspace(1,10,10)
print(a)
```



输出结果为：



```plain
[ 1.  2.  3.  4.  5.  6.  7.  8.  9. 10.]
```



**设置元素全部是1的等差数列：**



```python
import numpy as np
 
a = np.linspace(10, 20,  5, endpoint =  False)  
print(a)
```



输出结果为：



```python
[10. 12. 14. 16. 18.]
```



如果将 endpoint 设为 true，则会包含 20。



**以下实例设置间距：**



```python
import numpy as np
a =np.linspace(1,10,10,retstep= True)
 
print(a)
# 拓展例子
b =np.linspace(1,10,10).reshape([10,1])
print(b)
```



输出结果为：



```python
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



```
numpy.logspace（）
```



numpy.logspace() 函数用于创建一个于等比数列。格式如下：



```python
np.logspace(start, stop, num=50, endpoint=True, base=10.0, dtype=None)
```



base 参数意思是取对数的时候 log 的下标。

| 参数       | 描述                                                         |
| ---------- | ------------------------------------------------------------ |
| `start`    | 序列的起始值为：base ** start                                |
| `stop`     | 序列的终止值为：base ** stop。如果`endpoint`为`true`，该值包含于数列中 |
| `num`      | 要生成的等步长的样本数量，默认为`50`                         |
| `endpoint` | 该值为 `true` 时，数列中中包含`stop`值，反之不包含，默认是True。 |
| `base`     | 对数 log 的底数。                                            |
| `dtype`    | `ndarray` 的数据类型                                         |



将对数的底数设置为 2 :



```python
import numpy as np 
a = np.logspace(0,9,10,base=2) 
print (a)
```



输出如下：



```python
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
`a[1, 2]` 或者`a[1][2]` : 全下标定位单个元素，在a中表示7这个元素



#### **2.2.2 切片表示**



若`a = np.arange(10)`，`b = a[2 : 7 : 2]`则表示从索引 2 开始到索引 7 停止，间隔为 2，即b为[2, 4, 6]。此外也可以通过切片操作来对元素进行修改，如：



```python
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



```python
import numpy as np 
 
x = np.array([[1,  2],  [3,  4],  [5,  6]]) 
# 想象为：y = x[a:b,c:d]，其中a:b，c:d分别是两个一维数组
y = x[[0,1,2],  [0,1,0]]  
print (y)
```



输出结果为：



```plain
[1  4  5]
```



当然，切片操作是针对我们想要获取的数据是连续的，如果我们想要获取离散数据就不能使用切片的方法，再者就是我们不能一个一个来进行提取，Numpy有一种很方便的方法可以获得离散数据。即下面



```python
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



```python
x = np.array([[ 0, 1, 2],[ 3, 4, 5],[ 6, 7, 8],[ 9, 10, 11]]) 
print(x[x > 5]) # out : [ 6  7  8  9 10 11]
b = x > 5
b # 打印布尔运算的结果
```



![img](https://pic4.zhimg.com/80/v2-989c2810b2bd306ad2099446d9bccd63_720w.webp)



以下实例演示如何从数组中过滤掉非复数元素。



```python
a = np.array([1, 2 + 6j, 5, 3.5 + 5j])
print(a[np.iscomplex(a)])

b = np.iscomplex(a)
print(b)
```



输出如下：



```python
[2. +6.j 3.5+5.j]
[False  True False  True]
```



#### **2.2.5 元素查找定位**



Numpy库中提供了where函数来查找满足条件元素的索引，表示如下：



- `np.where(condition, x, y)`: 满足条件(condition)，输出x，不满足输出y
- `np.where(condition)`: 输出满足条件 (即非0) 元素的坐标



```python
a = np.array([2,4,6,8,10,3]).reshape(2,3) 
c = np.where(a > 5) # 返回索引 
# out : (array([0, 1, 1], dtype=int64), array([2, 0, 1], dtype=int64)) 即：(0,2) (1,0) (1,1) 坐标均满足
a[c] # 获得元素
```



#### **2.2.6 元素删除**



```
np.delete(arr, obj, axis=None)
```



- 第一个参数：要处理的矩阵，
- 第二个参数，处理的位置，下标
- 第三个参数，0表示按照行删除，1表示按照列删除，默认为0
- 返回值为删除后的剩余元素构成的矩阵



```python
arr = np.array([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]])
np.delete(arr, [1], 0) # 表示删除第二行
```



### **2.3 Numpy数组的操作** 



[看不懂看这个](https://www.runoob.com/numpy/numpy-array-manipulation.html#numpy_oparr4)



#### **2.3.1 拼接**



下面的图列举了常见的用于数组或向量 合并的方法。



![img](https://pic4.zhimg.com/80/v2-6e7f38a7176fc1732474a48fab7498f3_720w.webp)



说明：



- append、concatenate以及stack都有一个axis参数，用于控制数组的合 并方式是按行还是按列。
- 对于append和concatenate，待合并的数组必须有相同的行数或列数
- stack、hstack、dstack，要求待合并的数组必须具有相同的形状



```python
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



- 水平分割：`np.split(arr,n,axis=1)` 或`np.hsplit(arr,n)`：按列分成n份。返回一个list
- 垂直分割：`np.split(arr,n,axis=0)` 或 `np.vsplit(arr,n)`：按行分成n份，返回一个list



```python
x = np.arange(12).reshape(3, 4)
np.split(x, 3) 
# out : [array([[0, 1, 2, 3]]), array([[4, 5, 6, 7]]), array([[ 8,  9, 10, 11]])]

y = np.arange(9).reshape(1, 9)
np.split(y, 3, axis = 1) 
# out : [array([[0, 1, 2]]), array([[3, 4, 5]]), array([[6, 7, 8]])]
```



#### **2.3.3 维度变换**



在机器学习以及深度学习的任务中，通常需要将处理好的数据以模型能 接收的格式输入给模型，然后由模型通过一系列的运算，最终返回一个处理 结果。然而，由于不同模型所接收的输入格式不一样，往往需要先对其进行 一系列的变形和运算，从而将数据处理成符合模型要求的格式。在矩阵或者 数组的运算中，经常会遇到需要把多个向量或矩阵按某轴方向合并，或展平 (如在卷积或循环神经网络中，在全连接层之前，需要把矩阵展平)的情 况。下面介绍几种常用的数据变形方法。



![img](https://pic2.zhimg.com/80/v2-5ff9d8dd12ccecb0824b3ebfdfc25fc9_720w.webp)



*1)* `***reshape***`
不改变原数组元素，返回一个新的shape维度的数组(维度变换)。`reshape` 通常的用法是：`arr.reshape(n1,n2,n3,....,nw)` ，其功能是将![img](https://www.yuque.com/api/services/graph/generate_redirect/latex?arr)向量转换为![img](https://www.yuque.com/api/services/graph/generate_redirect/latex?w) 维度，且维度从高到低拥有的元素数量是：![img](https://www.yuque.com/api/services/graph/generate_redirect/latex?n1%2Cn2%2Cn3%2C...%2Cnw)



```python
x = np.arange(12).reshape(3, 4)
x # out : array([[ 0,  1,  2,  3], [ 4,  5,  6,  7], [ 8,  9, 10, 11]])

# 指定维度时可以只指定行数或列数, 其他用 -1 代替
x.reshape(3, -1) # out : array([[ 0,  1,  2,  3], [ 4,  5,  6,  7], [ 8,  9, 10, 11]])
```



*2)* `***resize***`



改变向量的维度(修改向量本身)：



```python
arr =np.arange(10) 
print(arr) # out : [0 1 2 3 4 5 6 7 8 9]

arr.resize(2, 5) # 将向量 arr 维度变换为2行5列 
print(arr) # out : [[0 1 2 3 4], [5 6 7 8 9]]
```



*3)* `***T***`



矩阵转置



```python
arr = np.arange(8).reshape(2, 4)
arr.shape # out : (2, 4)
arr.T.shape # out : (4, 2)
```



*4)*`ravel`



向量展平



```python
arr = np.arange(8).reshape(2, 4)
arr.ravel() # out : array([0, 1, 2, 3, 4, 5, 6, 7])
```



*5)* `***flatten***`



把矩阵转换为向量，相较于`ravel`不会改变原矩阵



```python
arr = np.arange(8).reshape(2, 4)
arr.flatten() # out : array([0, 1, 2, 3, 4, 5, 6, 7])
```



*6)* `***squeeze***`



这是一个主要用来降维的函数，把矩阵中含1的维度去掉



```python
arr = np.arange(8).reshape(2, 4, 1)
arr.shape # out : (2, 4, 1)
arr.squeeze().shape # out : (2, 4)
```



*7)* `***transpose***`



对高维矩阵进行轴对换，这个在深度学习中经常使用，比如把图片中表 示颜色顺序的RGB改为GBR。



```python
arr = np.arange(12).reshape(2, 6, 1)
arr.shape # out : (2, 6, 1)
arr.transpose(1, 2, 0).shape # out : (6, 1, 2)
```



*拓展*



*8)* `***swapaxes***`



将两个维度调换, 就是把对应的下标换个位置，类似于transpose



```python
arr = np.arange(20).reshape(4, 5)
arr.swapaxes(1, 0)
```



### **2.5 Numpy数值计算**



#### **2.5.1 通用函数对象(ufunc)**



ufunc是universal function的简称，种能对数组每个元素进行运算的函数。NumPy的许多ufunc函数都是用C语言实现的，因此它们的运算速度非常快。下图是在数据批量处过程中较为常用的几个函数

| 计算函数                                            | 说明                             |
| --------------------------------------------------- | -------------------------------- |
| `ndarray.mean( axis=0 )`                            | 求平均值                         |
| `ndarray.sum( axis= 0)`                             | 求和                             |
| `ndarray.cumsum( axis=0)``ndarray.cumprod( axis=0)` | 累加 累乘                        |
| `ndarray.std()``ndarray.var()`                      | 方差标准差                       |
| `ndarray.max()``ndarray.min()`                      | 最大值最小值                     |
| `ndarray.argmax()``ndarray.argmin()`                | 最大值索引最小值索引             |
| `ndarray.any()``ndarray.all()`                      | 是否至少有一个True是否全部为True |
| `ndarray.dot( ndarray)`                             | 计算矩阵内积                     |



使用的格式基本如下：np.函数名(数组， 指定计算的维度(默认为0))，如：



```python
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



```python
arr = np.array([
     [10, 11, 12], 
     [13, 14, 15]
])
np.min(arr, axis = 0) # out : array([10, 11, 12]) 按行求最小值，即列不变，行变
np.min(arr, axis = 1) # out : array([10, 13]) 按列求最小值，即行不变，列变
```



我们可以通过`np.argmin`，`np.argmax`获得相对应的最小值、最大值的下标



```python
arr = np.array([
[10, 14, 12], 
[13, 11, 15]
])
np.argmin(arr, axis = 0) # out : array([0, 1, 0], dtype=int64) 按行求最小值，即列不变，行变
np.argmin(arr, axis = 1) # out : array([0, 1], dtype=int64) 按列求最小值，即行不变，列变
```



使用`np.sort`和`np.argsor`进行排序并排序后的下标



```python
arr = np.array([1, 3, 5, 2, 4])
np.sort(arr) # out : array([1, 2, 3, 4, 5])
np.argsort(arr) # out : array([0, 3, 1, 4, 2], dtype=int64)
```



#### **2.5.2 矩阵运算**



##### 对应元素相乘



对应元素相乘（Element-Wise Product）是两个矩阵中对应元素乘积。 `np.multiply`函数用于数组或矩阵对应元素相乘，输出与相乘数组或矩阵的大 小一致。



```python
a = np.array([[1,0],[0,1]])
b = np.array([[4,1],[2,2]])
np.multiply(a, b) # 等效于a * b，out : array([[4, 0], [0, 2]])
```



计算过程如下图：



![img](https://pic4.zhimg.com/80/v2-42107955f3ca0b847d6014a33f3f9967_720w.webp)



##### 点积运算



点积运算(Dot Product)又称为内积，在Numpy用`np.dot`或者`np.matmul`表示，或者是使用`@`符号来表示矩阵乘法



```python
numpy.dot(a, b, out=None) 
# equals to
c = a @ b
```



**参数说明：**



- **a** : ndarray 数组
- **b** : ndarray 数组
- **out** : ndarray, 可选，用来保存dot()的计算结果



```python
a = np.array([[1,0],[0,1]])
b = np.array([[4,1],[2,2]])
np.dot(a, b) # 等效于np.matmul(a, b) out : array([[4, 1], [2, 2]])
c = a @ b
```



计算过程如下图：



![img](https://pic1.zhimg.com/80/v2-2886532cc18f53c1888e98eca32c3e80_720w.webp)



##### 计算行列式



`numpy.linalg.det()` 函数计算输入矩阵的行列式。



```python
arr = np.array([[1,2], [3,4]]) 
np.linalg.det(arr) # out : -2.0000000000000004
```



##### 矩阵求逆



`numpy.linalg.inv()`函数计算矩阵的乘法逆矩阵。



```python
arr = np.array([[1,2], [3,4]]) 
np.linalg.inv(arr) # out : array([[-2. ,  1. ], [ 1.5, -0.5]])
```



##### **特征值和特征向量**



```python
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



```plain
x + y + z = 6

2y + 5z = -4

2x + 5y - z = 27
```



可以使用矩阵表示为：



![img](https://www.runoob.com/wp-content/uploads/2018/10/118142-7ab3daa7f65551e6.jpg)



如果矩阵成为A、X和B，方程变为：



```plain
AX = B

或

X = A^(-1)B
```



### **2.6 插值运算**



这个过程其实就是我们在数学中已知一个函数，然后给出x值，让你根据这个函数求对应的y值，一般在曲线平滑处理中有较多的使用在Numpy中由numpy.interp(x, xp, fp, left=None, right=None, period=None)表示



- x - 表示将要计算的插值点x坐标
- xp - 表示已有的xp数组
- fp - 表示对应于已有的xp数组的值



```python
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



```python
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



```python
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

------

## 4 NumPy 广播(Broadcast)

广播(Broadcast)是 numpy 对不同形状(shape)的数组进行数值计算的方式， 对数组的算术运算通常在相应的元素上进行。

如果两个数组 a 和 b 形状相同，即满足 **a.shape == b.shape**，那么 a*b 的结果就是 a 与 b 数组对应位相乘。这要求维数相同，且各维度的长度相同。

```python
importnumpyasnpa = np.array([1,2,3,4])
b = np.array([10,20,30,40])
c = a * b
print(c)
```

输出结果为：

[ 10  40  90 160]

当运算中的 2 个数组的形状不同时，numpy 将自动触发广播机制。如：

```python
import numpy as np 
 
a = np.array([[ 0, 0, 0],
           [10,10,10],
           [20,20,20],
           [30,30,30]])
b = np.array([0,1,2])
print(a + b)
```

输出结果为：

```python
[[ 0  1  2] 
 [10 11 12] 
 [20 21 22]  
 [30 31 32]]
```

下面的图片展示了数组 b 如何通过广播来与数组 a 兼容。

![img](https://cdn.nlark.com/yuque/0/2023/gif/22608736/1695715064396-904be194-12d8-4017-af5a-0ec096ee7385.gif)

4x3 的二维数组与长为 3 的一维数组相加，等效于把数组 b 在二维上重复 4 次再运算，b数组并没有变化，而是在内部的计算中通过重复使用相同的数据避免数据的显式复制，这种操作成为**虚拟复制**

```python
import numpy as np 
 
a = np.array([[ 0, 0, 0],
           [10,10,10],
           [20,20,20],
           [30,30,30]]) 
b = np.array([1,2,3])
bb = np.tile(b, (4, 1))  # 重复 b 的各个维度,横向复制 4 次，纵向复制 1 次
print(a + bb)
```

输出结果为：

```py
[[ 1  2  3]
 [11 12 13]
 [21 22 23]
 [31 32 33]]
```

**广播的规则:**

- 让所有输入数组都向其中形状最长的数组看齐，形状中不足的部分都通过在前面加 1 补齐。
- 输出数组的形状是输入数组形状的各个维度上的最大值。
- 如果输入数组的某个维度和输出数组的对应维度的长度相同或者其长度为 1 时，这个数组能够用来计算，否则出错。
- 当输入数组的某个维度的长度为 1 时，沿着此维度运算时都用此维度上的第一组值。

**简单理解：**对两个数组，分别比较他们的每一个维度（若其中一个数组没有当前维度则忽略），满足：

- 数组拥有相同形状。
- 当前维度的值相等。
- 当前维度的值有一个是 1。

若条件不满足，抛出 **"ValueError: frames are not aligned"** 异常。