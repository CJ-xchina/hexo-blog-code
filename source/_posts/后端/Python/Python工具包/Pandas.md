```
title: Pandas
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
```

<meta name="referrer" content="no-referrer"/>



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