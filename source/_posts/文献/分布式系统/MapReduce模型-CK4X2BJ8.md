---
tags: []
parent: 'MapReduce: simplified data processing on large clusters'
collections:
    - Library
    - 分布式系统
version: 509
libraryID: 1
itemKey: CK4X2BJ8

---
MapReduce模型

# 1 MapReduce模型介绍

**MapReduce** 是一种编程模型和相关实现，用于处理和生成适合各种现实世界任务的大型数据集。<span style="color: rgb(62, 63, 66)"><span style="background-color: rgb(251, 251, 251)">用户可以通过定义map和reduce函数来指定计算过程，而底层的运行时系统会自动将计算并行化到大规模的机器集群上，处理机器故障，并进行网络和磁盘的高效通信。</span></span>

<span style="color: rgb(62, 63, 66)"><span style="background-color: rgb(251, 251, 251)">这个编程模型简单易用，Google内部已经实现了一万多个不同的MapReduce程序，每天平均执行一百万个MapReduce作业，处理每天超过20PB的数据</span></span>

# 2 MapReduce工作原理

## 2.1 工作流程

![\<img alt="" data-attachment-key="F7YYEN8A" data-annotation="%7B%22attachmentURI%22%3A%22http%3A%2F%2Fzotero.org%2Fusers%2F12640518%2Fitems%2FUEA45RNH%22%2C%22annotationKey%22%3A%229QDJAQFC%22%2C%22color%22%3A%22%23ffd400%22%2C%22pageLabel%22%3A%223%22%2C%22position%22%3A%7B%22pageIndex%22%3A2%2C%22rects%22%3A%5B%5B74.423%2C383.885%2C538.846%2C726%5D%5D%7D%2C%22citationItem%22%3A%7B%22uris%22%3A%5B%22http%3A%2F%2Fzotero.org%2Fusers%2F12640518%2Fitems%2FMUH7F2C2%22%5D%2C%22locator%22%3A%223%22%7D%7D" width="774" height="570" src="attachments/F7YYEN8A.png" ztype="zimage">](attachments/F7YYEN8A.png)\
<span class="citation" data-citation="%7B%22citationItems%22%3A%5B%7B%22uris%22%3A%5B%22http%3A%2F%2Fzotero.org%2Fusers%2F12640518%2Fitems%2FMUH7F2C2%22%5D%7D%5D%2C%22properties%22%3A%7B%7D%7D" ztype="zcitation">(<span class="citation-item"><a href="zotero://select/library/items/MUH7F2C2">Dean 和 Ghemawat, 2008</a></span>)</span>

<span style="color: rgb(51, 51, 51)">MapReduce 的工作流：</span>

*   <span style="color: rgb(51, 51, 51)">将输入文件分成 </span>**<span style="color: rgb(51, 51, 51)">M</span>**<span style="color: rgb(51, 51, 51)"> 个小文件(split)，每个文件的大小大概 16M-64M（由用户参数控制），在集群中启动 MapReduce 实例，其中</span>`fork`

    一个 Master 和多个 Worker；\[1]

*   <span style="color: rgb(51, 51, 51)">由 Master 分配任务，将 </span>

    `Map`与`Reduce`任务分配给可用的 Worker\[2]；

*   `Map`Worker 读取文件\[3]，执行用户自定义的 map 函数，输出 中间值key/value 对，缓存在内存中；

*   <span style="color: rgb(51, 51, 51)">内存中的 (key, value) 对通过 </span>

    `partitioning function()`例如`hash(key) mod R`分为**R**个 regions（保证相同key的键值对在一个分区），然后写入磁盘(local disk)\[4]。完成之后，把这些文件的地址回传给 Master，然后 Master 把这些位置传给`Reduce`Worker；

*   `Reduce`Worker 收到数据存储位置信息后，使用 RPC(Remote Procedure Call远程过程调用协议) 从`Map`Worker 所在的磁盘读取这些数据\[5]，根据 key 进行排序，并将同一 key 的所有数据分组聚合在一起（**由于许多不同的 key 值会映射到相同的 Reduce 任务上，因此必须进行排序。如果中间数据太大无法在内存中完成排序，那么就要在外部进行排序**）；

*   `Reduce`Worker 将分组后的值传给用户自定义的 reduce 函数，输出追加到所属分区的输出文件中；

*   <span style="color: rgb(51, 51, 51)">当所有的 Map 任务和 Reduce 任务都完成后，Master 向用户程序返回结果；</span>

<span style="color: rgb(51, 51, 51)">MapReduce对输出文件的处理：</span>

<span style="color: rgb(51, 51, 51)">通常情况下，用户并不需要将 R 个输出文件合并成一个文件；他们通常会将这些文件作为输入传递给另一个 MapReduce 调用，或者从另一个能够处理分割成多个文件的输入的分布式应用程序中使用这些文件。</span>

***

## 2.2 Master 数据结构

1.  <span style="color: rgb(51, 51, 51)">记录每一个任务（Map与reduce）状态（idle,in-progress,or completed)</span>
2.  <span style="color: rgb(51, 51, 51)">记录每一个工作者身份</span>
3.  <span style="color: rgb(51, 51, 51)">记录存储在local disk 中间文件（intermediate file）的大小以及磁盘位置</span>

***

## <span style="color: rgb(51, 51, 51)">2.3 容错能力</span>

### <span style="color: rgb(51, 51, 51)">2.3.1、处理worker错误</span>

*   <span style="color: rgb(51, 51, 51)">master通过周期地向worker发送ping指令来确保worker处于存活状态，对于没有回应ping指令的worker，master会将该worker标记为 </span>

    **<span style="color: rgb(51, 51, 51)">failed</span>**

*   <span style="color: rgb(51, 51, 51)">在failed worker执行中的 Map 或 Reduce 任务会被重置为idle状态，可被其他存活worker接收。</span>

*   <span style="color: rgb(51, 51, 51)">在failed worker上已经执行完成的Map任务会被再次执行，因为其输出结果存储在failed worker本地磁盘中，如果failed worker在local write之前就挂掉，那么该数据无法被读取，因此需要从新执行。而Reduce任务不会被再次执行，因为其输出结果存储在全局文件系统中。</span>

<span style="color: rgb(51, 51, 51)">对于failed worker任务处理总结下来就是：</span>

| <span style="color: rgb(51, 51, 51)"><span style="background-color: var(--th-bg-color)">任务状态状态</span></span> | <span style="color: rgb(51, 51, 51)"><span style="background-color: var(--th-bg-color)">Map任务</span></span> | <span style="color: rgb(51, 51, 51)"><span style="background-color: var(--th-bg-color)">Reduce任务</span></span> |
| ------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------- |
| <span style="color: rgb(51, 51, 51)">执行中</span>                                                              | <span style="color: rgb(51, 51, 51)">设置为idle</span>                                                         | <span style="color: rgb(51, 51, 51)">设置为idle</span>                                                            |
| <span style="color: rgb(51, 51, 51)"><span style="background-color: var(--tr-bg-color)">执行结束</span></span>   | <span style="color: rgb(51, 51, 51)"><span style="background-color: var(--tr-bg-color)">从新执行</span></span>  | <span style="color: rgb(51, 51, 51)"><span style="background-color: var(--tr-bg-color)">不用处理</span></span>     |

<span style="color: rgb(51, 51, 51)">对于worker A 执行的Map任务随后被worker B 执行，那么所有执行Reduce任务的worker都会接到通知：还没有从worker A读取数据的reduce worker 将会从worker B 上读取数据。</span>

#### <span style="color: rgb(51, 51, 51)">4.3.2、出现错误时的语义处理</span>

<span style="color: rgb(51, 51, 51)">用户提供的映射（map）和归约（reduce）操作是其输入值的确定性函数时，分布式实现将生成与整个程序的非故障顺序执行所产生的相同输出。</span>

<span style="color: rgb(51, 51, 51)">为了实现这个特性，我们依赖于映射和归约任务输出的原子提交。每个正在进行的任务将其输出写入私有临时文件。一个归约任务产生一个这样的文件，而一个映射任务产生 R 个这样的文件（每个归约任务一个）。当一个映射任务完成时，工作节点向主节点发送消息，并在消息中包含这些临时文件的名称。如果主节点接收到一个已经完成的映射任务的完成消息，它将忽略该消息。否则，它将记录 R 个文件的名称在主节点的数据结构中。当一个归约任务完成时，归约工作节点将其临时输出文件原子性地重命名为最终输出文件。如果相同的归约任务在多个机器上执行，那么对于相同的最终输出文件将执行多个重命名调用。我们依赖底层文件系统提供的原子重命名操作来保证最终文件系统状态仅包含一个归约任务执行产生的数据。我们绝大部分的映射和归约操作是确定性的，而且在这种情况下，我们的语义等效于顺序执行，这使得程序员很容易推断出程序的行为。、</span>

<span style="color: rgb(51, 51, 51)">当映射和/或归约操作是非确定性的时，我们提供了较弱但仍然合理的语义。在存在非确定性操作的情况下，特定归约任务 R 的输出等价于非确定性程序的顺序执行产生的 R 的输出。然而，不同归约任务 F 的输出可能对应于由非确定性程序的不同顺序执行产生的 R 的输出。</span>

### <span style="color: rgb(51, 51, 51)">4.4 读取位置(locality)</span>

<span style="color: rgb(51, 51, 51)">为了节省带宽资源，MapReduce工作集群中输入数据通常存储在机器的本地磁盘中，在Map任务开始前，Master会考虑输入文件的位置信息，将尝试在包含输入数据的机器上执行Map任务。</span>

<span style="color: rgb(51, 51, 51)">如果上述方法行不通，Master也会考虑在存储输入文件机器附近的机器（例如，在与包含数据的机器处于同一交换机上工作的机器）执行Map任务。</span>

<span style="color: rgb(51, 51, 51)">因此MapReduce大部分的输入数据都是在本地读取的，不占用网络带宽。</span>

### <span style="color: rgb(51, 51, 51)">4.5 任务粒度（Task Granularity）</span>

<span style="color: rgb(51, 51, 51)">之前在工作流中提到，输入文件被分为 M 个切片，而通过划分函数将存储在disk中的中间文件划分为 R 个区域。为了提升动态载入平衡能力以及加快 failed worker 的恢复，M 和 R 的值应当被设置地远大于worker machines数量。</span>

<span style="color: rgb(51, 51, 51)">但 M 和 R 的值越大越好，因为 master 会进行 O(M + R) 次的调度，同时master会在内存中存储 O(M * R) 状态值，因此 M 和 R 的值也会有一个界限（Bound）。</span>

<span style="color: rgb(51, 51, 51)">R 的值通常由worker数量来决定，一个worker承担一个或多个region的reduce操作，产出一个单独的结果文件。用户通常决定的是 M 的值，实践中每一个独立的任务在 16MB ~ 64MB 输入数据时，能够最有效地实现局部性优化。而 R 的数量只需要是worker数量的小几倍就行了。</span>

<span style="color: rgb(51, 51, 51)">例如：M = 200000， R = 5000 ，2000 worker machines 来处理。</span>

Referred in <a href="./MTitle：分布式系统研究-NPNE5ZQY.md" rel="noopener noreferrer nofollow" zhref="zotero://note/u/NPNE5ZQY/?ignore=1&#x26;line=2" ztype="znotelink" class="internal-link">MTitle：分布式系统研究</a>
