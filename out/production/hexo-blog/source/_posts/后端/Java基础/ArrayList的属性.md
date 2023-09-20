---
title: ArrayList的属性
date: 2023-03-18 00:00:00
tags: Java基础
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
### 1、ArrayList的属性

```java
public class ArrayList<E> extends AbstractList<E>
        implements List<E>, RandomAccess, Cloneable, java.io.Serializable
{
    @java.io.Serial
    // 序列化Id
    private static final long serialVersionUID = 8683452581122892189L;
	// 默认初始容量
    private static final int DEFAULT_CAPACITY = 10;
	// 空数组
    private static final Object[] EMPTY_ELEMENTDATA = {};
	// 空数组，如果使用默认构造函数创建，则对象内容默认值为该值
    private static final Object[] DEFAULTCAPACITY_EMPTY_ELEMENTDATA = {};
	// 当前数据对象存放地方，当前对象不参与序列化，一个数组引用
    transient Object[] elementData; // non-private to simplify nested class access
	// 当前数组的长度，size=ArrayList中元素的个数
    private int size;
    // ArrayList的最大容量值
    private static final int MAX_ARRAY_SIZE = Integer.MAX_VALUE - 8;
```

`size`存放的是ArrayList容器中**实际存储的元素个数（不包括扩容后还没有存放数据的空间）**

`elementData`引用指向一个Object[]，**其所指数组的长度是ArrayList容器的最大长度(真正容量)**

ArrayList从AbstractList中继承了`modCount`属性，代表了ArrayLIst被修改的次数

`EMPTY_ELEMENTDATA`与`DEFAULTCAPACITY_EMPTY_ELEMENTDATA` 用于区分构造方法。不同的构造方法将elementData指向不同的数组，同时注意：**这两个数组永远是空数组，扩容总是在原数组的基础上创建新的数组**

### 2、ArrayList构造函数

**无参构造函数**

如果不传入参数，则使用默认无参构建方法创建ArrayList对象，如下：

```java
public ArrayList() {
		this.elementData = DEFAULTCAPACITY_EMPTY_ELEMENTDATA;
}
```

注意：当创建一个ArrayList时，elementData的长度为0，size为0，在第一次进行扩容操作时，elementData 将会被扩容成为默认长度：10

**带int类型的构造函数**

如果传入参数，则代表指定ArrayList的初始数组长度，传入参数如果是大于等于0，则使用用户的参数初始化，如果用户传入的参数小于0，则抛出异常，构造方法如下：

```java
    public ArrayList(int initialCapacity) {
        if (initialCapacity > 0) {
            // 新建一个指定初始容量
            this.elementData = new Object[initialCapacity];
        } else if (initialCapacity == 0) {
            this.elementData = EMPTY_ELEMENTDATA;
        } else {
            throw new IllegalArgumentException("Illegal Capacity: "+initialCapacity);
        }
    }
```

------

**带Collection对象的构造函数**

1）将collection对象转换成数组，然后将数组的地址的赋给elementData。
2）更新size的值，同时判断size的大小，如果是size等于0，直接将空对象**EMPTY_ELEMENTDATA**的地址赋给elementData
3）如果size的值大于0，则执行Arrays.copy方法，把collection对象的内容（深拷贝）copy到elementData中。

**注意：这里需要判断一下`c.getClass() == ArrayList.class` 因为其他继承Collection类重写的toArray()返回的数组不一定是Object[]类型，因此需要Arrays.copyOf 复制一下确保返回一个Object[]** 

```java
public ArrayList(Collection<? extends E> c) {
    // 转换为数组
    Object[] a = c.toArray();
    if ((size = a.length) != 0) {
        if (c.getClass() == ArrayList.class) {
            elementData = a;
        } else {
            elementData = Arrays.copyOf(a, size, Object[].class);
        }
    } else {
        // replace with empty array.
        elementData = EMPTY_ELEMENTDATA;
    }
}
```

### 3、ArrayList的容量扩展

```java
//ArrayList扩容函数，底层用Arrays.copyOf实现
//minCapacity 需要的最小容量值
private void grow(int minCapacity) {
    // overflow-conscious code
    int oldCapacity = elementData.length;//原来容量
    int newCapacity = oldCapacity + (oldCapacity >> 1);//新的容量，扩展规则为原来的1.5倍倍
    if (newCapacity - minCapacity < 0)
        newCapacity = minCapacity;
    if (newCapacity - MAX_ARRAY_SIZE > 0)//新的容量已经超过了最大容量
        newCapacity = hugeCapacity(minCapacity);
    // minCapacity is usually close to size, so this is a win:
    elementData = Arrays.copyOf(elementData, newCapacity);
}

//返回一个ArrayList的最大容量
private static int hugeCapacity(int minCapacity) {
    if (minCapacity < 0) // overflow
        throw new OutOfMemoryError();
    return (minCapacity > MAX_ARRAY_SIZE) ?
        Integer.MAX_VALUE :
        MAX_ARRAY_SIZE;
}
```

扩容的策略：<font color='red'>**新的容量为旧的容量的1.5倍,称其为预定扩容值**</font>

如果扩容后的新容量还不够(newCapacity - minCapacity < 0)，则直接将容量设置为传入的参数`minCapacity`（也就是所需的容量）

如果大于规定的最大容量，则调用hugeCapacity获取最大容量值，**扩容之后的容量为 minCapacity 与预定扩容值的最大值。**

### 4、ArrayList方法实现

#### **add方法**

add方法有两种形式，一种是在List尾端添加元素`add(E e)`，另一种是在List指定位置添加元素`add(int index,E element)`

```java
public boolean add(E e) {
    ensureCapacityInternal(size + 1);  // Increments modCount!!
    elementData[size++] = e;
    return true;
}
public void add(int index, E element) {
    rangeCheckForAdd(index);
    ensureCapacityInternal(size + 1);  // Increments modCount!!
    System.arraycopy(elementData, index, elementData, index + 1,size - index);
    elementData[index] = element;
    size++;
}
```

可以看到两个方法都调用了``ensureCapacityInternal(size + 1)``方法，把数组长度加1以确保能存下下一个数据，扩容之后将调用`System.arraycopy`将index包括和其之后的所有元素后移一位，之后便修改index位的值为element

```java
//保证容器大小允许添加数据
private void ensureCapacityInternal(int minCapacity) {
     ensureExplicitCapacity(calculateCapacity(elementData, minCapacity));
}
```

```java
//计算需要扩容到多大
private static int calculateCapacity(Object[] elementData, int minCapacity) {
    if (elementData == DEFAULTCAPACITY_EMPTY_ELEMENTDATA) {//如果是无参构造器创建的对象
        return Math.max(DEFAULT_CAPACITY, minCapacity);
    }
    return minCapacity;
}
```

可以看到`calculateCapcity()`中会判断当前数组是否为`DEFAULTCAPACITY_EMPTY_ELEMENTDATA`，之前就强调了无参构造时才会返回这个数组。所以，若创建ArrayList时调用的是无参构造，此方法会返回**DEFAULT_CAPACITY**（值为10）和minCapacity的最大值。因此一个默认构造器的ArrayList第一次调用`add()`后容量必定会被扩充到10.

```java
private void ensureExplicitCapacity(int minCapacity) {
    modCount++;//被修改的次数++
    // overflow-conscious code1
    if (minCapacity - elementData.length > 0)
        // 调用扩容函数
        grow(minCapacity);
}
```

ensureExplicitCapacity 会根据传入的minCapacity判断是否调用扩容函数grow

#### get方法

```java
public E get(int index) {
    Objects.checkIndex(index, size);//检查范围，抛出异常
    return elementData(index);
}
```

#### set方法

```java
public E set(int index, E element) {
    rangeCheck(index);//范围检查

    E oldValue = elementData(index);
    elementData[index] = element;
    return oldValue;
}
```

#### indexOf方法

```java
public int indexOf(Object o) {
    if (o == null) {
        for (int i = 0; i < size; i++)
            if (elementData[i]==null)
                return i;
    } else {
        for (int i = 0; i < size; i++)
            if (o.equals(elementData[i]))
                return i;
    }
    return -1;
}
```

作用：判断一个对象o第一次在ArrayList中出现的索引位置，如果没有出现则返回-1

#### contains方法

```java
public boolean contains(Object o) {
    // 直接通过返回indexOf的索引判断是否有该对象
    return indexOf(o) >= 0;
}
```

#### remove方法

ArrayList中定义了两种remove方法，一种是根据索引号删除，另一种找到第一次匹配的元素删除

```java
// 依据索引号删除的remove函数
public E remove(int index) {
    Objects.checkIndex(index, size);
    final Object[] es = elementData;

    @SuppressWarnings("unchecked") E oldValue = (E) es[index];
    fastRemove(es, index);

    return oldValue;
}
```

```java
// 根据传入的对象删除第一个匹配的索引
public boolean remove(Object o) {
    final Object[] es = elementData;
    final int size = this.size;
    int i = 0;
    found: {
        if (o == null) {
            for (; i < size; i++)
                if (es[i] == null)
                    break found;
        } else {
            for (; i < size; i++)
                if (o.equals(es[i]))
                    break found;
        }
        return false;
    }
    fastRemove(es, i);
    return true;
}
```

这两种删除方式都是调用了`fastRemove()`，该函数能够通过`System.arrayCopy()`实现快速的数组移动。因此ArrayList无论哪种方法删除一个元素的时间复杂度均是$O(N)$ ，需要移动删除索引之后的所有元素

```java
// 调用的fastRemove方法
private void fastRemove(Object[] es, int i) {
    modCount++;
    final int newSize;
    if ((newSize = size - 1) > i)
        System.arraycopy(es, i + 1, es, i, newSize - i);
    es[size = newSize] = null;
}
```

可以看到`fastRemove`方法将最后一个元素置为`null`，目的就是让垃圾回收程序快速回收。

#### clear方法

```java
public void clear() {
    modCount++;
    // clear to let GC do its work
    for (int i = 0; i < size; i++)
        elementData[i] = null;
    size = 0;
}
```

------

#### subList方法

```java
public List<E> subList(int fromIndex, int toIndex) {
    subListRangeCheck(fromIndex, toIndex, size);
    return new SubList(this, 0, fromIndex, toIndex);
}
```

subList方法返回了一个SubList对象

```java
private class SubList extends AbstractList<E>
```

subList对象继承于AbstractList。很多人看到subList返回了List就以为是返回了ArrayList，其实并不是，其实返回的是一个视图对象。

视图对象可以看做是原ArrayList的一个[fromIndex,toIndex)集合的映射，**视图对象可以像ArrayList一样正常读取，但是如果想要通过视图对象修改ArrayList就有以下几种情况**

1. 修改原集合元素的值，会影响子集合
2. 修改原集合的结构，会引起`ConcurrentModificationException`异常
3. 修改子集合元素的值，会影响原集合
4. 修改子集合的结构，会影响原集合

**尽量减少SubList方法的使用**

#### **trimToSize方法**

1）修改次数加1
2）将elementData中空余的空间（包括null值）去除
```java
    public void trimToSize() {
        modCount++;
        if (size < elementData.length) {
            elementData = (size == 0)
              ? EMPTY_ELEMENTDATA
              : Arrays.copyOf(elementData, size);
        }
   	}
```
第一次学习jdk的源代码，如果有错误欢迎大家指正  