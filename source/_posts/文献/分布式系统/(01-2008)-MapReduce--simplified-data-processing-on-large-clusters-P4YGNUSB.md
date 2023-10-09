---
tags: []
parent: 'MapReduce: simplified data processing on large clusters'
collections:
    - Library
    - 分布式系统
version: 395
libraryID: 1
itemKey: P4YGNUSB

---
# <span style="color: #E65100"><span style="background-color: #fff8e1">(01/2008) MapReduce: simplified data processing on large clusters</span></span>

|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **期刊: <span style="color: #FF0000">Communications of the ACM</span>**（发表日期: **01/2008**） **作者:** Jeffrey Dean; Sanjay Ghemawat                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| **DOI : **[10.1145/1327452.1327492](https://doi.org/10.1145/1327452.1327492)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| **摘要: ***MapReduce is a programming model and an associated implementation for processing and generating large datasets that is amenable to a broad variety of real-world tasks. Users specify the computation in terms of a map and a reduce function, and the underlying runtime system automatically parallelizes the computation across large-scale clusters of machines, handles machine failures, and schedules inter-machine communication to make efficient use of the network and disks. Programmers find the system easy to use: more than ten thousand distinct MapReduce programs have been implemented internally at Google over the past four years, and an average of one hundred thousand MapReduce jobs are executed on Google's clusters every day, processing a total of more than twenty petabytes of data per day.* |
| **期刊分区: **undefined                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| **原文PDF链接: **[Dean 和 Ghemawat - 2008 - MapReduce simplified data processing on large clu.pdf](zotero://open-pdf/0_UEA45RNH)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| **笔记创建日期: **2023/10/8 下午11:56:29                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |

## 💡创新点

在对于如何处理大规模原式数据上，提出了使用

> Tips: 本文提出了什么<u>新的科学问题</u>，提出了什么<u>新的研究思路</u>，或提出了什么<u>新的研究工具</u>？

## 📚前言及文献综述

### 研究必要

在开发 MapReduce 之前，作者和 Google 的许多其他人面临着计算处理大量原始数据（例如爬行文档、Web 请求日志等），以计算各种派生数据，例如例如倒排索引、Web 文档图形结构的各种表示、每个主机抓取的页面数量的摘要以及给定日期中最频繁查询的集合。大多数此类计算在概念上都很简单。

然而，输入数据通常很大，计算必须分布在数百或数千台机器上才能在合理的时间内完成。如何并行计算、分布数据和处理故障等问题，用大量复杂的代码来处理这些问题，掩盖了原来的简单计算。为了应对这种复杂性，我们设计了一种新的抽象，它允许我们表达我们试图执行的简单计算，但隐藏了库中并行化、容错、数据分布和负载平衡的混乱细节。

## 研究可行性

我们的抽象受到 Lisp 和许多其他函数式语言中存在的映射和归约原语的启发。意识到大多数计算涉及对输入中的每个逻辑记录应用映射（Map）操作，以计算一组中间键/值对，然后对共享相同键的所有值按顺序应用归约（Reduce）操作适当地组合派生数据。我们使用具有用户指定的映射和归约操作的功能模型，使我们能够轻松并行化大型计算，并使用重新执行作为容错的主要机制。

## 🧩解决思路

MapReduce 库的用户将计算表示为两个函数：map 和reduce。 Map 由用户编写，接受一个输入对并生成一组中间键/值对。 MapReduce 库将与同一中间键 I 关联的所有中间值组合在一起，并将它们传递给reduce 函数。 reduce 函数也由用户编写，接受中间键 I 和该键的一组值。它将这些值合并在一起以形成可能更小的值集。这使我们能够处理太大而无法容纳在内存中的值列表。

## 🔬方法

## 📜结论

MapReduce 编程模型的成功归因于几个原因：

1.  模型易于使用，即使对于没有并行和分布式系统经验的程序员来说也是如此，因为它隐藏了并行化、容错、局部优化和负载平衡的细节。
2.  MapReduce 计算通用性。例如，MapReduce 用于为 Google 的生产网络搜索服务生成数据，用于排序、数据挖掘、机器学习和许多其他系统。
3.  MapReduce 可以扩展到包含数千台机器的大型机器集群。该实现有效地利用了这些机器资源，因此适合用于解决 Google 遇到的许多大型计算问题。

通过限制编程模型，我们可以轻松实现并行化和分布式计算，并使此类计算具有容错能力。其次，网络带宽是一种稀缺资源。因此，我们系统中的许多优化旨在减少通过网络发送的数据量：局部性优化允许我们从本地磁盘读取数据，并将中间数据的单个副本写入本地磁盘可以节省网络带宽。第三，冗余执行可用于减少缓慢机器的影响，并处理机器故障和数据丢失。

## 🤔思考

> Tips: 本文有什么<u>优缺点</u>？你是否对某些内容产生了<u>疑问</u>？\
> 你是否认为某些研究方式可以改进，<u>如何改进</u>？

###

Referred in <a href="./分布式系统研究-XP8WPB77.md" rel="noopener noreferrer nofollow" zhref="zotero://note/u/XP8WPB77/?ignore=1&#x26;line=-1" ztype="znotelink" class="internal-link">分布式系统研究</a>

Referred in <a href="./分布式系统研究-XP8WPB77.md" rel="noopener noreferrer nofollow" zhref="zotero://note/u/XP8WPB77/?ignore=1&#x26;line=-1" ztype="znotelink" class="internal-link">分布式系统研究</a>

Referred in <a href="./MTitle：分布式系统研究-NPNE5ZQY.md" rel="noopener noreferrer nofollow" zhref="zotero://note/u/NPNE5ZQY/?ignore=1&#x26;line=1" ztype="znotelink" class="internal-link">M：分布式系统研究</a>

Referred in <a href="./MTitle：分布式系统研究-NPNE5ZQY.md" rel="noopener noreferrer nofollow" zhref="zotero://note/u/NPNE5ZQY/?ignore=1&#x26;line=-1" ztype="znotelink" class="internal-link">MTitle：分布式系统研究</a>

Referred in <a href="./MTitle：分布式系统研究-NPNE5ZQY.md" rel="noopener noreferrer nofollow" zhref="zotero://note/u/NPNE5ZQY/?ignore=1&#x26;line=-1" ztype="znotelink" class="internal-link">MTitle：分布式系统研究</a>

Referred in <a href="./MTitle：分布式系统研究-NPNE5ZQY.md" rel="noopener noreferrer nofollow" zhref="zotero://note/u/NPNE5ZQY/?ignore=1&#x26;line=6" ztype="znotelink" class="internal-link">MTitle：分布式系统研究</a>
