---
title: C++程序开发
date: 2023-03-18 00:00:00
tags: C++
categories: 后端
keywords:
description: 考研复试准备时C++笔记
top_img:
comments:
cover: https://w.wallhaven.cc/full/1p/wallhaven-1ppld1.jpg
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
# 变量与类型

### 1 变量的默认初始化

#### C++内置类型

在C++中，如果在定义变量时没有显式地进行初始化，那么它们就会被默认初始化。默认初始化的方式取决于变量的类型和定义位置。对于内置类型的变量（如`int`、`float`、`double`等），它们的默认值是未定义的，也就是说<font color='red'>**它们的初始值是随机**</font>的。这是因为默认情况下，这些变量是在栈上分配的，它们的初始值是不确定的。

#### 包装类型（string）

对于`string`这种自定义类型，其默认初始化会**调用默认构造函数来完成，即创建一个空字符串**。如果在定义`string`类型的变量时没有进行显式初始化，则该变量会被默认初始化为一个空字符串。



#  关键字

## 1 sizeof

### 1.1 简单使用

**sizeof** 是一个关键字，它是一个编译时运算符，用于判断变量或数据类型的**字节大小**。

sizeof 运算符可用于获取类、结构、共用体和其他用户自定义数据类型的大小。

使用 sizeof 的语法如下：

```c++
sizeof (data type)
```

其中，data type 是要计算大小的数据类型，包括类、结构、共用体和其他用户自定义数据类型。

请尝试下面的实例，理解 C++ 中 sizeof 的用法。复制并黏贴下面的 C++ 程序到 test.cpp 文件中，编译并运行程序。

```c
#include <iostream>
using namespace std;
 
int main()
{
   cout << "Size of char : " << sizeof(char) << endl;
   cout << "Size of int : " << sizeof(int) << endl;
   cout << "Size of short int : " << sizeof(short int) << endl;
   cout << "Size of long int : " << sizeof(long int) << endl;
   cout << "Size of float : " << sizeof(float) << endl;
   cout << "Size of double : " << sizeof(double) << endl;
   cout << "Size of wchar_t : " << sizeof(wchar_t) << endl;
   return 0;
}
```

当上面的代码被编译和执行时，它会产生下列结果，结果会根据使用的机器而不同：

```c++
Size of char : 1
Size of int : 4
Size of short int : 2
Size of long int : 4
Size of float : 4
Size of double : 8
Size of wchar_t : 4
```

### 1.2 sizeof计算数组长度

 在确定一个数组大小的时候我们一般用sizeof

```c++
int arr1[] = {1 , 2, 4 ,5};
int arr1_len = sizeof arr1/sizeof(int);
std::cout<< "arr1 len: " << arr1_len << std::endl; // 输出4
```

---

## 2 malloc

### 2.1 malloc函数

malloc的全称是memory allocation，中文叫动态内存分配。
**用于申请一块连续的指定大小的内存块区域以void\*类型返回分配的内存区域地址，当无法知道内存具体位置的时候，想要绑定真正的内存空间，就需要用到动态的分配内存，且分配的大小就是程序要求的大小。**

malloc() 在**<font color='red'>堆区</font>**分配一块指定大小的内存空间，用来存放数据。这块内存空间在函数执行完成后不会被初始化，它们的值是未知的。如果希望在分配内存的同时进行初始化，请使用 calloc() 函数。

malloc函数原型：

```c++
extern void *malloc(unsigned int num_bytes);  // 意为分配长度为num_bytes字节的内存块
```

malloc函数头文件：

```c++
#include<malloc.h>
```

malloc函数返回值：

如果分配成功则返回指向被分配内存的指针，否则返回空指针NULL。

malloc函数使用注意事项：

malloc函数的返回的是无类型指针，在使用时一定要强制转换为所需要的类型。
**（敲黑板）重点：在使用malloc开辟空间时，使用完成一定要释放空间，如果不释放会造内存泄漏。**
**在使用malloc函数开辟的空间中，不要进行指针的移动，因为一旦移动之后可能出现申请的空间和释放空间大小的不匹配**

### 2.2 malloc函数与动态数组

关于malloc所开辟空间类型：malloc只开辟空间，不进行类型检查，只是在使用的时候进行类型的强转

指针自身 = (指针类型）malloc（sizeof（指针类型） * 数据数量）

```c
	int *p = NULL;
	int n = 10;
	p = (int *)malloc(sizeof(int)*n);
	
	// 操作数组
	p[0] = 10;
	cout << p[0];
```

在使用malloc函数之前我们一定要**计算字节数**，malloc开辟的是用户所需求的字节数大小的空间。

### 2.3 malloc函数与二维动态数组

方法一：利用二级指针申请一个二维数组。

```cpp
#include<stdio.h>  
#include<stdlib.h>  
  
  
int main()  
{  
    int **a;  //用二级指针动态申请二维数组  
    int i,j;  
    int m,n;  
    printf("请输入行数\n");  
    scanf("%d",&m);  
    printf("请输入列数\n");  
    scanf("%d",&n);  
    a=(int**)malloc(sizeof(int*)*m);  
    for(i=0;i<m;i++)  
    a[i]=(int*)malloc(sizeof(int)*n);  
    for(i=0;i<m;i++)  
    {
        for(j=0;j<n;j++)  
        {
            printf("%p\n",&a[i][j]);     //输出每个元素地址，每行的列与列之间的地址时连续的，行与行之间的地址不连续
        }
    }
    for(i=0;i<m;i++)  
    free(a[i]);
 
    free(a);  
    return 0;  
} 
```

**方法二：用数组指针形式申请一个二维数组。**

```cpp
#include<stdio.h>  
#include<stdlib.h>  
  
  
int main()  
{  
    int i,j;  
    //申请一个3行2列的整型数组  
    int (*a)[2]=(int(*)[2])malloc(sizeof(int)*3*2);  
    for(i=0;i<3;i++)  
    {
        for(j=0;j<2;j++)  
        {  
            printf("%p\n",&a[i][j]);  //输出数组每个元素地址，每个元素的地址是连续的
        }
    }
 
 
    free(a);
    return 0;  
}  
```

方法三：用一个单独的一维数组来模拟二维数组。

```cpp
#include <stdio.h>
#include <stdlib.h>
 
 
int main()
{
    int nrows,ncolumns;
    int *Array;
    int i,j;
    printf("please input nrows&ncolumns:\n");
    scanf("%d%d",&nrows,&ncolumns);
    Array=(int *)malloc(nrows*ncolumns*sizeof(int));   //申请内存空间
    for(i=0;i<nrows;i++)
    {
        for(j=0;j<ncolumns;j++)
        {
            Array[i*ncolumns+j]=1;
            printf("%d ",Array[i*ncolumns+j]);   //用Array[i*ncolumns+j] 访问第i,j个成员
        }
        printf("\n");
    }
    free(Array);
    return 0;
}
 
 
```

## 3 define 与 typedef

### 3.1 define

`#DEFINE`关键字在C/C++中用作宏处理，基本的用法为：

```c++
#DEFINE MAX_SIZE 256
```

在代码的预处理阶段，编译器会把所有的宏定义符号替换成被定义的数据，例如以下代码：

```c++
#include <iostream>
using namespace std;
// 注意不用加分号!
#define M (a + b)
#define MUL(x,y) x*y

int main()
{
	int a = 2;
	int b = 2;
	cout << M * M;  //16
     cout << MUL(a,b); //4
	return 0;
}
```

### 3.2 typedef

## 4 memset

### 4.1 memset使用

memset函数定义于<string.h>头文件中。
函数原型：

```cpp
void *memset(void *s,int c,unsigned long n);
```

函数功能：为指针变量s所指的前n个**字节**的内存单元填充给定的int型数值c，它可以为任何数据进行初始化。**换句话说，就是将数值c以单个字节逐个拷贝的方式放到指针变量s所指的内存中去。** 注意：只将数值c的最低一个字节填充到内存。

示例：
（1）当c=-1时

```cpp
#include <iostream>
#include <string.h>
using namespace std;

int main()
{
    int dp[3];
    memset(dp,-1,sizeof(dp));

    for(int i=0;i<3;i++)
        cout << dp[i] << " ";

    return 0;
}
```

> 因为-1在计算机中存储为：1111 1111，故dp数组中每一个int值为“1111 1111 1111 1111 1111 1111 1111 1111”，是十进制下的-1。
> 输出结果：-1 -1 -1

（2）当c=0时

```cpp
#include <iostream>
#include <string.h>
using namespace std;

int main()
{
    int dp[3];
    memset(dp,0,sizeof(dp));

    for(int i=0;i<3;i++)
        cout << dp[i] << " ";

    return 0;
}
```

> 因为0在计算机中存储为：0000 0000，故dp数组中每一个int值为“0000 0000 0000 0000 0000 0000 0000 0000”，是十进制下的0。
> 输出结果：0 0 0

（3）当c=1时

```cpp
#include <iostream>
#include <string.h>
using namespace std;

int main()
{
    int dp[3];
    memset(dp,1,sizeof(dp));

    for(int i=0;i<3;i++)
        cout << dp[i] << " ";

    return 0;
}
```

> 因为1在计算机中存储为：0000 0001，故dp数组中每一个int值为“0000 0001 0000 0001 0000 0001 0000 0001”，是十进制下的16843009。
> 输出结果：16843009 16843009 16843009

（4）当c=268时

```cpp
#include <iostream>
#include <string.h>
using namespace std;

int main()
{
    int dp[3];
    memset(dp,268,sizeof(dp));

    for(int i=0;i<3;i++)
        cout << dp[i] << " ";

    return 0;
}
```

> 因为-1在计算机中存储为： 0001 0000 1100，故dp数组中每一个int值为“0000 1100 0000 1100 0000 1100 0000 1100”，是十进制下的202116108。
> 输出结果：202116108 202116108 202116108

### 4.2 memset与动态数组初始化

```c++
bool* used = (bool*)malloc(sizeof(bool) * (n + 1));
memset(used, 0, sizeof(used));
```

上述代码初始化 used 数组会失败，原因是 sizeof(used) 返回的是 used 指针的大小，不能返回指针所指数组的长度大小

## 5 union

> 在C++中，union是一种用户自定义数据类型，用于存储不同类型的数据。union中的所有成员共享同一段内存空间，即它们在内存中占用的是同一个位置。union的大小等于最大成员的大小。
>
> union有以下特点和用途：
>
> 1. 节省内存：由于union中的所有成员共享同一段内存空间，因此可以节省内存，特别是当需要存储的数据类型不确定时。
> 2. 用于存储不同类型的数据：可以使用union来存储不同类型的数据，例如可以用联合体来实现一个变量同时存储整数、浮点数等不同类型的数据。
> 3. 用于类型转换：由于union中的成员共享同一段内存空间，因此可以使用联合体来进行类型转换，即通过一个成员访问另一个成员的数据。

以下是一个简单的使用union的例子：

```c++
#include <iostream>
using namespace std;

union MyUnion {
    int a;
    float b;
};

int main() {
    MyUnion u;
    u.a = 42;
    cout << "a = " << u.a << endl; // 输出 42
    u.b = 3.14;
    cout << "b = " << u.b << endl; // 输出 3.14
    cout << "a = " << u.a << endl; // 输出不确定的值，因为b和a共享同一段内存空间
    return 0;
}
```

需要注意的是，由于union的成员共享同一段内存空间，因此对一个成员的修改可能会影响到其他成员的值，因此在使用union时需要特别小心。

#  知识点

## 1 堆和栈

堆和栈主要有以下几点不同：

### **申请方式**

栈：**申请栈空间时不需要指明大小**。例如声明在函数中一个局部变量`int b`; 系统自动在栈中为b开辟空间。

堆：**申请堆空间时需要指明大小**。例如，C中的[malloc函数](https://so.csdn.net/so/search?q=malloc函数&spm=1001.2101.3001.7020)`p1 = (char *)malloc(10)`。C++中的new运算符`p2 = new char[10]`。<font color='red'>但是p1、p2本身是在栈中的</font>。

### **分配方式**

栈：**栈是向低地址扩展的数据结构，是一块连续的内存的区域**。只要栈的剩余空间大于所申请空间，系统将为程序提供内存，否则将报异常提示栈溢出。

堆：**堆是向高地址扩展的数据结构，是不连续的内存区域**。操作系统有一个记录空闲内存地址的链表，当系统收到malloc申请时，会遍历该链表，寻找第一个空间大于所申请空间的堆结点，然后将该结点从空闲结点链表中删除，并将该结点的空间分配给程序，另外，对于大多数系统，会在这块内存空间中的首地址处记录本次分配的大小，这样，代码中的delete语句才能正确的释放本内存空间。另外，由于找到的堆结点的大小不一定正好等于申请的大小，系统会自动的将多余的那部分重新放入空闲链表中。

### **空间大小**

栈：linux下默认的栈空间大小是8M或10M。

堆：堆的大小受限于计算机系统中有效的虚拟内存（虚拟内存中还有一部分空间要留给内核）。针对 Linux 操作系统而言，**最高的1G 字节**(从虚拟地址 0xC0000000 到 0xFFFFFFFF)由内核使用，称为内核空间。而**较低的 3G 字节**(从虚拟地址 0x00000000 到 0xBFFFFFFF)由各个进程使用，称为用户空间。

### **存储内容**

栈：**存放局部变量、函数参数**。存放在栈中的数据只在当前函数及下一层函数中有效，一旦函数返回了，这些数据也就自动释放了。

堆：堆中的具体内容可以通过程序员安排。

## 2 new/delete和malloc/free

### 2.1 区别

1. new从自由存储区上分配内存，malloc从堆上分配内存。自由存储区是C++基于new操作符的一个抽象概念，凡是通过new操作符进行内存申请，该内存即为自由存储区。而堆是操作系统中的术语，是操作系统所维护的一块特殊内存，用于程序的内存动态分配。自由存储区是否能够是堆取决于operator new 的实现细节。自由存储区不仅可以是堆，还可以是静态存储区，这都看operator new在哪里为对象分配内存。
2. new 可以调用对象的构造函数，对应的 delete 调用相应的析构函数；malloc 仅仅分配内存，free 仅仅回收内存，并不执行构造和析构函数。在new一个对象的时候，底层首先调用 operator new() 函数为对象分配内存空间，然后调用对象的构造函数。delete会调用对象的析构函数，然后调用free回收内存。
3. 使用new操作符申请内存分配时无须指定内存块的大小，编译器会根据类型信息自行计算；使用malloc则需要显式地指出所需内存的尺寸。
4. new、delete 返回的是某种数据类型指针；malloc、free 返回的是 void 指针。
5. new、delete 是操作符；malloc、free 是函数。
6. malloc分配失败返回NULL；new要求在内存分配失败时要求返回NULL或抛出std::bad_alloc异常。

### 2.2 malloc的内存可以用delete释放吗？

可以，但是一般不这么用。malloc/free是c语言中的函数，c++为了兼容c保留下来这一对函数。简单来说，new 可以理解为，先执行malloc来申请内存，后调用构造函数来初始化对象；delete是先执行析构函数，后使用free来释放内存。delete[] 用于释放数组元素的分配。

## 3 运算符重载

### 示例 1：一元运算符重载

一元运算符即只对一个操作数进行操作的运算符，例如：`!obj`、`-obj`、`++obj` 、`obj++` 或 `obj--` 等等。

下面示例将对负号（`-`）进行重载：

```cpp
#include <iostream>
using namespace std;

class Distance
{
private:
    int feet;    // 0 到无穷
    int inches;  // 0 到 12
public:
    // 构造函数
    Distance() {
        feet = 0;
        inches = 0;
    }
    Distance(int f, int i) {
        feet = f;
        inches = i;
    }
    
    // 显示距离
    void displayDistance() {
        cout << "F: " << feet << ", I: " << inches << endl;
    }
    
    // 重载负运算符 ( - )
    Distance operator- () {
        feet = -feet;
        inches = -inches;
        return Distance(feet, inches);
    }
};

int main(void)
{
    Distance d1(1, 10), d2(-5, 110);
    
    -d1;                     // 取相反数
    d1.displayDistance();    // 距离 D1
    
    -d2;                     // 取相反数
    d2.displayDistance();    // 距离 D2
    
    return 0;
}
```

编译并运行以上示例，输出结果如下：

```bash
F: -1, I: -10
F: 5, I: -110
12
```

------

### 示例 2：二元运算符重载

二元运算符即需要两个参数的运算符，例如：加运算符（`+`）、减运算符（`-`）、乘运算符（`*`）、除运算符（`/`）。

下面示例将重载加运算符（`+`）：

```cpp
class Box
{
    double length;  // 长度
    double width;   // 宽度
    double height;  // 高度

public:
    Box() {
        length = 0.0;
        width = 0.0;
        height = 0.0;
    }

    Box(double a, double b, double c)
    {
        length = a;
        width = b;
        height = c;
    }

    double getVolume(void)
    {
        return length * width * height;
    }

    // 重载 + 运算符，用于把两个 Box 对象相加
    Box operator+(const Box& b)
    {
        Box box;
        box.length = this->length + b.length;
        box.width = this->width + b.width;
        box.height = this->height + b.height;
        return box;
    }
     
    // 友元重载法：
    //friend Box operator+(const Box& box1, const Box& box2) {
    //    Box box;
    //    box.height = box1.height + box2.height;
    //    box.length = box1.length + box2.length;
    //    box.width = box1.width + box2.width;
    //    return box;
    //}
};

int main(void)
{
    Box b1(5.0, 4.0, 3.0);
    Box b2(6.0, 5.0, 4.0);
    Box b3;

    cout << "Volume of b1 : " << b1.getVolume() << endl;
    cout << "Volume of b2 : " << b2.getVolume() << endl;

    // 把两个对象相加，得到 Box3
    b3 = b1 + b2;

    // Box3 的体积
    cout << "Volume of b3 : " << b3.getVolume() << endl;

    return 0;
}
```

使用 `g++ main.cpp && ./a.out` 命令编译运行以上示例，输出结果如下：

```bash
Volume of b1 : 60
Volume of b2 : 120
Volume of b3 : 693
123
```

------

### 示例 3：[关系运算符](https://so.csdn.net/so/search?q=关系运算符&spm=1001.2101.3001.7020)重载

C++ 允许重载任何一个关系运算符（例如 < 、 > 、 <= 、 >= 、 == 等），重载后的关系运算符可用于比较类的对象。许多 C++ 内置的数据类型也都支持各种关系运算符。

下面示例将重载小于符（<）：

```cpp
class Rect
{
private:
    double width;
    double height;

public:
    Rect(double a, double b)
    {
        width = a;
        height = b;
    }

    double area() {
        return width * height;
    }

    // 重载小于运算符 ( < ), 按照面积比大小
    bool operator<(Rect& that)
    {
        return this->area() < that.area();
    }
     
    // 友元方式
    //friend bool operator<(Rect& r1,  Rect& r2) {
    //    return r1.area() < r2.area();
    //}
};

int main()
{
    Rect r1(3.0, 5.0), r2(3.5, 4.5);

    cout << "Area of r1 = " << r1.area() << endl;
    cout << "Area of r2 = " << r2.area() << endl;

    if (r1 < r2)
        cout << "r1 is less than r2" << endl;
    else
        cout << "r1 is large than r2" << endl;

    return 0;
}
```

编译运行以上代码，输出结果如下：

```bash
Area of r1 = 15
Area of r2 = 15.75
r1 is less than r2
123
```

------

### 示例 4：输入/输出运算符重载

C++ 使用**流提取运算符**（`>>`）和**流插入运算符**（`<<`）来输入和输出内置的数据类型，同时也允许重载 `>>` 和 `<<` 来操作对象等用户自定义的数据类型。

可以把运算符重载函数声明为类的友元函数，这样就可以不用创建对象而直接调用函数。

```cpp
#include <iostream>
using namespace std;

class Rect
{
public:
    double width;
    double height;

    Rect() {
        width = 0;
        height = 0;
    }

    Rect(double a, double b )
    {
        width  = a;
        height = b;
    }

    double area() {
        return width * height;
    }

    friend std::ostream &operator<<(std::ostream &output, Rect &r)
    { 
        output << "width: " << r.width << ", ";
        output << "height: " << r.height << ", ";
        output << "area: " << r.area();

        return output;
    }

    friend std::istream &operator>>(std::istream &input, Rect &r)
    {
        input >> r.width >> r.height;
        return input;            
    }
};

int main()
{
    Rect r1(3.0, 4.0), r2(6.0, 8.0), r3;
    
    cout << "Enter the value of object: \n";
    cin >> r3;
    cout << "r1: " << r1 << endl;
    cout << "r2: " << r2 << endl;
    cout << "r3: " << r3 << endl;
    
    return 0;
}
```

编译和运行以上示例，输出结果如下：

```bash
Enter the value of object: 
2 3
r1: width: 3, height: 4, area: 12
r2: width: 6, height: 8, area: 48
r3: width: 2, height: 3, area: 6
12345
```

------

### 示例 5：++ 和 – 运算符重载

递增运算符（`++`）和递减运算符（`--`）是 C++ 语言中两个重要的一元运算符，包括前缀和后缀两种用法。

下面示例将演示如何重载前缀自增（`++obj`）和后缀自减运算符（`obj--`）：

```cpp
class Rect
{
private:
    double width;
    double height;

public:
    Rect(double a, double b)
    {
        width = a;
        height = b;
    }

    double area() {
        return width * height;
    }

    // 重载小于运算符 ( < ), 按照面积比大小
    bool operator<(Rect& that)
    {
        return this->area() < that.area();
    }
    // 友元方式
    //friend bool operator<(Rect& r1,  Rect& r2) {
    //    return r1.area() < r2.area();
    //}
};

int main()
{
    Rect r1(3.0, 5.0), r2(3.5, 4.5);

    cout << "Area of r1 = " << r1.area() << endl;
    cout << "Area of r2 = " << r2.area() << endl;

    if (r1 < r2)
        cout << "r1 is less than r2" << endl;
    else
        cout << "r1 is large than r2" << endl;

    return 0;
}
```

编译运行以上示例，输出结果如下：

```bash
12 : 58
12 : 59
13 : 0
0 : 45
0 : 45
0 : 46
123456
```

------

### 示例 6：赋值运算符重载

C++ 允许重载赋值运算符（`=`），用于创建一个对象，比如拷贝构造函数。

下面示例重载 `Rect` 中的赋值运算符，并在每次拷贝的时候就把长度和宽度数值各加 1。

```cpp
#include <iostream>
using namespace std;

class Rect
{
private:
    double width;
    double height;

public:
    Rect() {
        width = 0;
        height = 0;
    }

    Rect(double a, double b) {
        width = a;
        height = b;
    }

    void display() {
        cout << " width: " << width;
        cout << " height: " << height;
    }

    void operator= (const Rect &r)
    {
        width = r.width + 1;
        height = r.height + 1;
    }
};

int main()
{
    Rect r1(3.0, 4.0), r2;
    
    r2 = r1;

    cout << "r1: ";
    r1.display();
    cout << endl;

    cout << "r2: ";
    r2.display();
    cout << endl;

    return 0;
}
123456789101112131415161718192021222324252627282930313233343536373839404142434445464748
```

编译和运行以上示例，输出结果如下：

```bash
r1:  width: 3 height: 4
r2:  width: 4 height: 5
12
```

------

### 示例 7：函数调用运算符重载

C++ 允许重载函数调用运算符（即 `()` 符号）。重载 `()` 的目的不是为了创造一种新的调用函数的方式，而是创建一个可以传递任意个参数的运算符函数。其实就是创建一个可调用的对象。

下面示例将演示重载函数调用运算符的妙用：

```cpp
#include <iostream>
using namespace std;

class Rect
{
private:
    int width;
    int height;

public:
    Rect() {
        width  = 0;
        height = 0;
    }

    Rect(int a ,int b) {
        width  = a;
        height = b;
    }

    void operator()() {
        cout << "Area of myself is:" << width * height << endl;
    }
};

int main()
{
    Rect r1(3, 4), r2(6, 8);

    cout << "r1: "; 
    r1();

    cout << "r2: ";
    r2();
    
    return 0;
}
```

编译和运行以上示例，输出结果如下：

```bash
r1: Area of myself is:12
r2: Area of myself is:48
12
```

------

### 示例 8：下标运算符重载

下标操作符（`[]`）通常用于访问数组元素。C++ 允许重载下标运算符用于增强操作 C++ 数组的功能，重载下标运算符最重要的作用就是设置一个哨兵，防止数组访问越界。

下面示例演示重载下标运算符：

```cpp
#include <iostream>
using namespace std;

const int SIZE = 10;

class Fibo
{
private:
    // 偷懒，防止把 SIZE 设置的过小
    int arr[SIZE + 3];

public:
    Fibo() {
        arr[0] = 0;
        arr[1] = 1;

        for(int i=2; i<SIZE; i++) {
            arr[i] = arr[i-2] + arr[i-1];
        }
    }

    int& operator[](unsigned int i) {
        if (i >= SIZE) {
            std::cout << "(索引超过最大值) ";
            return arr[0]; // 返回第一个元素
        }
        return arr[i];
    }
};

int main()
{
    Fibo fb;
    
    for (int i=0; i<SIZE+1; i++) {
        cout << fb[i] << " ";
    }
    cout << endl;
    
    return 0;
}
```

编译和运行以上示例，输出结果如下：

```bash
0 1 1 2 3 5 8 13 21 34 (索引超过最大值) 0
1
```

------

### 示例 9：类成员访问运算符重载

C++ 允许重载类成员访问运算符（`->`），用于为一个类赋予 “指针” 行为。重载 `->` 运算符时需要注意以下几点：

- 运算符 `->` 必须是一个成员函数；
- 如果使用了 `->` 运算符，返回类型必须是指针或者是类的对象；
- 运算符 `->` 通常与指针引用运算符 `*` 结合使用，用于实现智能指针的功能；
- 这些指针是行为与正常指针相似的对象，唯一不同的是，通过指针访问对象时，它们会执行其它的任务（比如，当指针销毁时，或者当指针指向另一个对象时，会自动删除对象）。

间接引用运算符 `->` 可被定义为一个一元后缀运算符，比如：

```cpp
class Ptr{
   //...
   X * operator->();
};
1234
```

类 `Ptr` 的对象可用于访问类 `X` 的成员，使用方式与指针的用法十分相似，如下：

```cpp
void f(Ptr p )
{
    p->m = 10 ; // (p.operator->())->m = 10
}
```

语句 `p->m` 被解释为 `(p.operator->())->m`。通过下面示例加深理解：

```cpp
#include <iostream>
#include <vector>

using namespace std;

// 假设一个实际的类
class Obj
{
    static int i, j;

public:
    void f() const { cout << i++ << endl; }
    void g() const { cout << j++ << endl; }
};

// 静态成员定义
int Obj::i = 10;
int Obj::j = 12;

// 为上面的类实现一个容器
class ObjContainer
{
    std::vector<Obj*> a;

public:
    void add(Obj* obj) {
        a.push_back(obj);  // 调用向量的标准方法
    }

    friend class SmartPointer;
};

// 实现智能指针，用于访问类 Obj 的成员
class SmartPointer {
    ObjContainer oc;
    int index;

public:
    SmartPointer(ObjContainer& objc)
    {
        oc = objc;
        index = 0;
    }
    // 前缀版本
    // 返回值表示列表结束
    bool operator++() 
    {
        if(index >= oc.a.size())
            return false;
        
        if(oc.a[++index] == 0)
            return false;
        
        return true;
    }
    // 后缀版本
    bool operator++(int)
    {
        return operator++();
    }

    // 重载运算符 ->
    Obj* operator->() const 
    {
        if(!oc.a[index]) {
            std::cout << "Zero value";
            return (Obj*)0;
        }

        return oc.a[index];
    }
};

int main() 
{
    const int sz = 6;

    Obj o[sz];
    ObjContainer oc;

    for(int i=0; i<sz; i++) {
        oc.add(&o[i]);
    }

    SmartPointer sp(oc); 

    do {
        sp->f(); 
        sp->g();
    } while(sp++);

    return 0;
}
```

编译和运行以上示例，输出结果如下：

```bash
10
12
11
13
12
14
13
15
14
16
15
17
123456789101112
```

------

### 示例 10：逻辑非运算符重载

逻辑非（`!`）运算符是一元运算符，它总是出现在所操作对象的左边，如 `!obj`。逻辑非运算符运算符返回的类型为 `bool` 类型，当对象为真值时，返回假；当对象为假值时，返回真。

下面示例演示如何重载 `!` 运算符：

```cpp
#include <iostream>
using namespace std;

class Rect
{
private:
    int width;
    int height;

public:
    Rect() {
        width = 0;
        height = 0;
    }

    Rect( int a, int b ) {
        width = a;
        height = b;
    }

    int area () {
        return width * height;
    }

    // 当 width 或者 height 有一个小于 0 则返回 true
    bool operator!() {
        if ( width <= 0 || height <= 0 ) {
            return true;
        }
        return false;
    }
};

int main()
{
    Rect r1(3, 4), r2(-3, 4);

    if (!r1) cout << "r1 is not a rectangle" << endl;
    else cout << "r1 is a rectangle" << endl;

    if (!r2) cout << "r2 is not a rectangle" << endl;
    else cout << "r2 is a rectangle" << endl;
    
    return 0;
}
```

使用 `g++ main.cpp && ./a.out` 命令编译和运行以上示例，输出结果如下：

```bash
r1 is a rectangle
r2 is not a rectangle
```

#  函数

## 1 传递参数

### 1.1 普通类型

#### 传值参数

简介：在值传递机制中，作为实参的表达式的值被复制到由对应的形参名所标识的对象中，成为形参的初值。完成参数值传递之后，函数体中的语句对形参的访问、修改都是在这个标识对象上操作的，与实参对象无关。

1）第一种格式，是在一开始就声明函数体，并赋予形参整形变量x,y，并在函数体里面对形参进行所需的运算，最后才写主函数，主函数中设置好实参a,b的值，再调用函数count将实参传回去计算。

> 代码如下（示例）：

```cpp
#include<iostream>
using namespace std;
void count(int x,int y)
{
	x=x*2;
	y=y*y;
	cout<<"x="<<x<<'\t';
	cout<<"y="<<y<<endl;
}
int main()
{
	int a=3,b=4;
	count(a,b);
	cout<<"a="<<a<<'\t';
	cout<<"y="<<b<<endl;
}
```

------

2）第二种格式，是先写主函数，再写函数体。注意：这个时候会出现报错。为什么会报错？因为主函数找不到你所调用的函数在哪里。解决办法是：在主函数之前声明该函数即可。

> 代码如下（示例）：

```cpp
#include<iostream>
using namespace std;
void count(int x,int y);//函数声明
int main()
{
	int a=3,b=4;
	count(a,b);
	cout<<"a="<<a<<'\t';
	cout<<"y="<<b<<endl;
}
void count(int x,int y)
{
	x=x*2;
	y=y*y;
	cout<<"x="<<x<<'\t';
	cout<<"y="<<y<<endl;
}
```

![在这里插入图片描述](https://img-blog.csdnimg.cn/421be3c885054595ba486cc226dbe114.png)

------

#### 指针参数

简介：当函数定义中的形参被说明为指针类型时，称为指针参数。形参指针对应的实参是地址表达式。调用函数时，实参把对象的地址赋给形参名标识的指针变量，被调用的函数可以在函数体内通过形参指针来间接访问实参地址所指的对象。这种参数传递方式称为指针传递或地址调用。

1）下面的例子中，x和y分别获取了a和b的地址，然后再通过swap函数进行交换。

> 代码如下（示例）：

```cpp
#include<iostream>
using namespace std;
void swap(int *x,int *y)
{
	int temp=*x;
	*x=*y;
	*y=temp;
}
int main()
{
	int a=3,b=8;
	cout<<"before swaping.....\n";
	cout<<"a="<<a<<",b="<<b<<endl;
	swap(&a,&b);
	cout<<"after swaping.....\n";
	cout<<"a="<<a<<",b="<<b<<endl;
}
```

![在这里插入图片描述](https://img-blog.csdnimg.cn/af60849f15f746eea75b2a53a3eab812.png)

2）如果我们不要指针那还会不会实现上面的交换功能呢？

> 代码如下（示例）：

```cpp
#include<iostream>
using namespace std;
void swap(int x,int y)
{
	int temp;
	temp=x;
	x=y;
	y=temp;
}
int main()
{
	int a=3,b=8;
	cout<<"before swaping.....\n";
	cout<<"a="<<a<<",b="<<b<<endl;
	swap(a,b);
	cout<<"after swaping.....\n";
	cout<<"a="<<a<<",b="<<b<<endl;
}
 
```

![在这里插入图片描述](https://img-blog.csdnimg.cn/dafb6b1295224ef3a272ae4402c84f27.png)

显然它没有实现，为什么？因为它的本质是按值传递的，就是x和y获得了a,b的值，但是调用函数的时候a还是原来的值，b也是原来的值。这里形参x与实参的a其实是两个不同的存储空间，所以对于形参存储单元的操作，当然不会关联实参产生变化。并且我们的swap函数返回值类型是void，即ab交换后的值并没有被传递回来，所以在main函数中，ab的值仍然没有变。

------

#### 引用参数

简介：形参被定义为引用类型时被称为引用参数。引用参数对应的实参应该是对象名。函数被调用时，形参不需要开辟新的储存空间，形参名作为引用（别名）绑定于实参标识的对象上，执行函数体时，对形参的操作就是对实参对象的操作，直至函数执行结束，撤销引用绑定。

> 代码如下（示例）：

```cpp
#include<iostream>
using namespace std;
void swap(int &,int &);
int main()
{
	int a=3,b=8;
	cout<<"before swaping.....\n";
	cout<<"a="<<a<<",b="<<b<<endl;
	swap(a,b);
	cout<<"after swaping.....\n";
	cout<<"a="<<a<<",b="<<b<<endl;
}
void swap(int &x,int &y)
{
	int temp=x;
	x=y;
	y=temp;
}
 
```

这里类似像取别名了，就是 int &x=a; int &y=b。

------

#### const参数

我们在设计函数时首先要考虑的就是函数用来干什么后，我们就可以考虑函数的具体实现了，<font color='red'>为了防止在实现函数的时候不能修改参数，我们可以使用const关键词修饰参数</font>。

```cpp
#include <iostream>
using namespace std;
 
char bl(const string& str)
{
	//把下面一行设为注释就可以运行
	str[str.length() - 1] = 's';
	return str[str.length() - 1];
}
 
int main()
{
	string str = "hello";
	cout << "字符串最后一个字符为：" << bl(str) << endl;
	return 0;

}
```

在本例中由于函数修改了字符串中的字符，违反了const语句，编译器就会报错。

### 1.2 一维数组类型

```c++
void changearr(int a[],int n)
{
     cout<<sizeof(a)<<endl;     // 输出4
}
int main()
{
     int a[10] = {2,78,100,88,12,55,45,0,1,2};
     cout<<sizeof(a)<<endl;     // 输出40
     changearr(a,10);
     return 0;
}
```

在C++中，数组名就是指向数组首元素地址的指针，数组索引就是距离数组首元素地址的偏移量。

数组永远不会按值传递，它传递的是数组首元素的指针，即第0个元素的指针。

所以，数组做参数时，有以下两点需要明白的：

1. 在被调用函数内对参数数组的改变将被应用到数组实参上而不是本地拷贝上。

2. 数组长度不是参数类型的一部分，函数不知道传递给它的数组的实际长度，编译器也不知道，当编译器

  对实参类型进行参数类型检查时，并不会检查数组的长度。

以下三个函数声明是等价的：

```c++
void change_arr(int a[]);
void change_arr(int* a);
void change_arr(int a[10]);	// 虽然标注是a[10],但是传入数组真实长度不会被检查,也就是说可能越界！

// 如果想让编译器检查数组的长度，你可以将数组参数声明为数组的引用：
void change_arr(int (&a)[10]);
```

### 4.1.3 二维数组类型

```c++
#include <iostream>
using namespace std;

/*传二维数组*/

//第1种方式：传数组,第二维必须标明
/*void display(int arr[][4])*/
void display1(int arr[][4],const int irows)
{
    for (int i=0;i<irows;++i)
    {
        for(int j=0;j<4;++j)
        {
            cout<<arr[i][j]<<" ";     //可以采用parr[i][j]
        }
        cout<<endl;
    }
    cout<<endl;
}

//第2种方式：一重指针，传数组指针,第二维必须标明
/*void display(int (*parr)[4])*/
void display2(int (*parr)[4],const int irows)
{
    for (int i=0;i<irows;++i)
    {
        for(int j=0;j<4;++j)
        {
            cout<<parr[i][j]<<" ";    //可以采用parr[i][j]
        }
        cout<<endl;
    }
    cout<<endl;
}
//注意：parr[i]等价于*(parr+i)，一维数组和二维数组都适用

//第3种方式：传指针,不管是几维数组都把他看成是指针
/*void display3(int *arr)*/
void display3(int *arr,const int irows,const int icols)
{
    for(int i=0;i<irows;++i)
    {
        for(int j=0;j<icols;++j)
        {
            cout<<*(arr+i*icols+j)<<" ";   //注意:(arr+i*icols+j),不是(arr+i*irows+j)
        }
        cout<<endl;
    }
    cout<<endl;
}

/***************************************************************************/
/*
//第2种方式：一重指针，传数组指针void display(int (*parr)[4])
//缺陷：需要指出第二维大小
typedef int parr[4];
void display(parr *p)
{
    int *q=*p;        //q指向arr的首元素
    cout<<*q<<endl;   //输出0
}

typedef int (*parr1)[4];
void display1(parr1 p)
{
    cout<<(*p)[1]<<endl;  //输出1
    cout<<*p[1]<<endl;    //输出4,[]运算符优先级高
}
//第3种方式：
void display2(int **p)
{
    cout<<*p<<endl;           //输出0
    cout<<*((int*)p+1+1)<<endl; //输出2
}
*/

int main()
{
    int arr[][4]={0,1,2,3,4,5,6,7,8,9,10,11};
    int irows=3;
    int icols=4;
    display1(arr,irows);
    display2(arr,irows);

    //注意(int*)强制转换.个人理解：相当于将a拉成了一维数组处理。
    display3((int*)arr,irows,icols);
    return 0;
}

```



## 4.2 返回参数

### 4.2.1 返回数组指针

> 背景知识：
>
> int arr[10]; //arr是一个含有10个整数的[数组](https://so.csdn.net/so/search?q=数组&spm=1001.2101.3001.7020)
> int \*p1[10]; //p1是一个含有10个指针的数组
> int (\*p2)[10] = &arr; //p2是一个数组指针，指向含有10个整数的数组。

返回方式：定义类型别名

```c++
#include <iostream>
using namespace std;

// arrT <==> int[10]
typedef int arrT[10]; 

arrT* getP() {
    return new arrT[10];
}

int main() {
    int(*p)[10] = getP();
    cout << p[0]; // 这是一个未初始化的随机值
    return 0;
}
```

# 5 错题

## 5.1 找错

```c++
// 错误1：没有包含头文件，无法使用 strcpy 

int copystringandcount(char *str)
{
     int count=0;
     char *buffer;
     buffer=new char[MAX_PATH_LENGTH];
     strcpy(buffer,str);
     // 错误2：buffer 应该修改为 *buffer，这样遍历到终止符'\0'时就会停止
     for(;buffer;buffer++)
          // 错误3：buffer 应该改为 *buffer
          if(buffer=='\\')count++;
     // 错误4：buffer动态分配空间，需要在函数返回前释放，使用 delete[] buffer ，使用数组分配
     return count;
}
```



类似例题：

> 找出下面代码中的错误：
>
> ```c++
> *mystrcat(char *dest, const char *src)
> {
>         char *temp = dest;
>         while(*dest) dest++;
>         while(*dest++ = *src++);
>         return temp;
> }
> 
> int main()
> {
>         char str1[100] = "hello";
>         char str2[100] = "world";
>         mystrcat(str1, str2);
>         cout << str1 << endl;
>         return 0;
> }
> ```
>
> 代码的错误在于，`mystrcat()` 函数中没有对目标字符串 `dest` 的空间进行检查，可能会导致越界访问或者内存泄漏的问题。具体来说，当目标字符串的空间不够时，`mystrcat()` 函数会不断地将源字符串的字符复制到目标字符串中，直到遇到空字符 '\0' 为止，这个过程中可能会超出目标字符串的空间。
>
> 修正的方法是，在 `mystrcat()` 函数中先判断目标字符串的空间是否够用，如果不够用则扩大目标字符串的空间。

