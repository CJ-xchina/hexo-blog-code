```
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
```

<meta name="referrer" content="no-referrer"/>

## 一、安装依赖库

在开始之前，我们需要先安装 Selenium 和 BeautifulSoup 这两个库。可以使用以下命令来安装它们：

```shell
pip install selenium
```

## 二. 声明浏览器对象

- Selenium 支持非常多的浏览器，如 Chrome、Firefox、Edge 等，还有 Android、BlackBerry 等手机端的浏览器。另外，也支持无界面浏览器 PhantomJS。

### 初始化

```python
from selenium import webdriver


browser = webdriver.Chrome()
browser = webdriver.Firefox()
browser = webdriver.Edge()
browser = webdriver.PhantomJS()
browser = webdriver.Safari()

```

**这样就完成了浏览器对象的初始化并将其赋值为 browser 对象。接下来，我们要做的就是调用 browser 对象，让其执行各个动作以模拟浏览器操作。**

## 三. 基本使用

```python
from selenium import webdriver
import time
from selenium.webdriver.common.by import By
# 打开指定（chrome）浏览器
browser = webdriver.Chrome()
# 指定加载页面
browser.get("http://www.baidu.com/")
# 通过name属性选择文本框元素，并设置内容
browser.find_element(By.NAME,'wd').send_keys("selenium")
# 通过通过ID属性获取“百度一下”按钮，并执行点击操作
browser.find_element(By.ID,"su").click()
# 提取页面
print(browser.page_source.encode('utf-8'))
# 提取cookie
print(browser.get_cookies())
# 获取当前页面截屏
print(browser.get_screenshot_as_file('123.png'))
# 提取当前请求地址
print(browser.current_url)
# 设置五秒后执行下一步
time.sleep(5)
# 关闭浏览器
browser.quit()
```

## 四. 初始化配置

```python
from selenium import webdriver
options = webdriver.ChromeOptions()

# 禁止图片
prefs = {"profile.managed_default_content_settings.images": 2}
options.add_experimental_option("prefs", prefs)

# 无头模式 在后台运行
# options.add_argument("-headless")

# 通过设置user-agent
user_ag='MQQBrowser/26 Mozilla/5.0 (Linux; U; Android 2.3.7; zh-cn; MB200 Build/GRJ22;CyanogenMod-7) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1'
options.add_argument('user-agent=%s'% user_ag)


#隐藏"Chrome正在受到自动软件的控制"
options.add_experimental_option('useAutomationExtension', False) # 去掉开发者警告
options.add_experimental_option('excludeSwitches', ['enable-automation'])

# 拓展使用
extension_path = r'E:\BaiduNetdiskDownload\Chrome插件\iguge_2011\igg_2.0.11.crx'
options.add_extension(extension_path)

#设置代理
# options.add_argument("--proxy-server=http://58.20.184.187:9091")

# 初始化配置
browser = webdriver.Chrome(chrome_options=options)

#将浏览器最大化显示
browser.maximize_window()
# 设置宽高
browser.set_window_size(480, 800)

# 通过js新打开一个窗口
browser.execute_script('window.open("http://httpbin.org/ip");')
```

## 五. 查找节点

- Selenium 可以驱动浏览器完成各种操作，比如填充表单、模拟点击等。比如，我们想要完成向某个输入框输入文字的操作或者抓取数据，而 Selenium 提供了一系列查找节点的方法，我们可以用这些方法来获取想要的节点，以便下一步执行一些动作或者提取信息。
- 新版selenium提供了2种方法
  - find_element()系列：用于定位单个的页面元素。
  - find_elements()系列：用于定位一组页面元素，获取到的是一组列表。

### 5.1 单个节点

**代码实现**

```python
from selenium import webdriver
from selenium.webdriver.common.keys import Keys  # 模拟键盘操作
from selenium.webdriver.common.by import By
# 启动并打开指定页面
browser = webdriver.Chrome()
browser.get("http://www.baidu.com")
# 通过name属性选择文本框元素，并设置内容
s = browser.find_element(By.NAME,'wd')
s.send_keys('衣服')
s.send_keys(Keys.ENTER)   # 回车 确定的意思
```

**各种节点提取演示**

```python
browser.get("http://www.baidu.com")
# ID选择器定位
input_text = browser.find_element(By.ID, "kw")
input_text.send_keys("selenium")
# CSS 选择器定位
s =browser.find_element(By.CSS_SELECTOR,'input.s_ipt')
s.send_keys('衣服')
# xpath 选择器定位
s = browser.find_element(By.XPATH,'//input[@id="kw"]')
s.send_keys('衣服')
```

### 5.2 多个节点

- 如果要查找所有满足条件的节点，需要用 find_elements() 这样的方法。注意，在这个方法的名称中，element 多了一个 s，注意区分。

**代码实现**

```python
from selenium import webdriver

browser = webdriver.Chrome()
browser.get('https://www.icswb.com/channel-list-channel-161.html')
lis = browser.find_elements(By.CSS_SELECTOR,'#NewsListContainer li')
print(lis)
```

**补充解释：**
可以看到，得到的内容变成了列表类型，列表中的每个节点都是 WebElement 类型。

下面是常用的查找方法：

```py
# selenium提供了8种网页元素定位的方式
# 根据ID定位，加s是寻找多节点,其他方式类似,多节点的话，需要使用for循环来遍历每一个节点
find_element_by_id()
find_elements_by_id()
# 根据class定位
find_elements_by_class_name()
# 根据标签名定位
find_elements_by_tag_name()
# 根据CSS选择器定位
find_element_by_css_selector()
# 根据name定位
find_elements_by_name()
# 根据XPath定位
find_element_by_xpath()
# 根据链接文本定位
find_element_by_link_text()
# 根据部分链接文本定位
find_element_by_partial_link_text()
```

获取元素后可查看元素属性：

```py
# get_attribute  获取属性值
# text  获取文本值
# id  获取节点id
# location  获取节点在页面中的相对位置
# tag_name  获取标签名称
# size  获取节点大小(宽和高)
```

## 六. 节点交互

- Selenium 可以驱动浏览器来执行一些操作，也就是说可以让浏览器模拟执行一些动作。比较常见的用法有：输入文字时用 send_keys 方法，清空文字时用 clear 方法，点击按钮时用 click 方法。

**代码实现**

```python
from selenium import webdriver
import time
browser = webdriver.Chrome()
browser.get('https://www.baidu.com')
input = browser.find_element(By.ID,'kw')
input.send_keys('iPhone')
time.sleep(1)
input.clear()
input.send_keys('iPad')
button = browser.find_element(By.ID,'su')
button.click()
```

**通过上面的方法，我们就完成了一些常见节点的动作操作，更多的操作可以参见官方文档的交互动作介绍：http://selenium-python.readthedocs.io/api.html#module-selenium.webdriver.remote.webelement。**

## 七. 切换[IFrame](https://so.csdn.net/so/search?q=IFrame&spm=1001.2101.3001.7020)

网页中有一种节点叫作 iframe，也就是子 Frame，相当于页面的子页面，它的结构和外部网页的结构完全一致。

**Selenium 打开页面后，它默认是在父级 Frame 里面操作，而此时如果页面中还有子 Frame，它是不能获取到子 Frame 里面的节点的。这时就需要使用 switch_to.frame() 方法来切换 Frame**。

```python
browser.get('https://www.douban.com/')
login_iframe = browser.find_element(By.XPATH,'//div[@class="login"]/iframe')
browser.switch_to.frame(login_iframe)
browser.find_element(By.CLASS_NAME,'account-tab-account').click()
browser.find_element(By.ID,'username').send_keys('123123123')
```

**注意**：对于iframe 网页 一定要切换进去才能够定位

如果需要退回到最初的父Iframe，则需要使用`driver.switch_to.default_content()`

## 八. 动作链

- drag_and_drop()方法
- 在上面的实例中，一些交互动作都是针对某个节点执行的。比如，对于输入框，我们就调用它的输入文字和清空文字方法；对于按钮，就调用它的点击方法。其实，还有另外一些操作，它们没有特定的执行对象，比如鼠标拖曳、键盘按键等，这些动作用另一种方式来执行，那就是动作链。
- 比如，现在实现一个节点的拖曳操作，将某个节点从一处拖曳到另外一处

**代码实现**

```python
from selenium import webdriver
from selenium.webdriver import ActionChains

browser = webdriver.Chrome()
url = 'http://www.runoob.com/try/try.php?filename=jqueryui-api-droppable'
browser.get(url)
log = browser.find_element(By.XPATH, '//div[@id="iframewrapper"]/iframe')
browser.switch_to.frame(log)
source = browser.find_element(By.CSS_SELECTOR,'#draggable')
target = browser.find_element(By.CSS_SELECTOR,'#droppable')
actions = ActionChains(browser)
actions.drag_and_drop(source, target)
actions.perform()
12345678910111213
```

- drag_and_drop()方法涉及到参数传递，一个是要拖拽元素的起点，一个是要拖拽元素的终点
- 首先，打开网页中的一个拖曳实例，然后依次选中要拖曳的节点和拖曳到的目标节点，接着声明 [ActionChains](https://so.csdn.net/so/search?q=ActionChains&spm=1001.2101.3001.7020) 对象并将其赋值为 actions 变量，然后通过调用 actions 变量的 drag_and_drop() 方法，再调用 perform() 方法执行动作，此时就完成了拖曳操作

## 九. 页面滚动

**代码实现**

```python
# 浏览器滚动到底部 10000位置
document.documentElement.scrollTop=10000
# 滚动到顶部
document.documentElement.scrollTop=0

# 移动到页面最底部  
browser.execute_script("window.scrollTo(0, document.body.scrollHeight)")
 
# 移动到指定的坐标(相对当前的坐标移动)
driver.execute_script("window.scrollBy(0, 700)")
# 结合上面的scrollBy语句，相当于移动到700+800=1600像素位置  
driver.execute_script("window.scrollBy(0, 800)")
 
# 移动到窗口绝对位置坐标，如下移动到纵坐标1600像素位置  
driver.execute_script("window.scrollTo(0, 1600)")
# 结合上面的scrollTo语句，仍然移动到纵坐标1200像素位置  
driver.execute_script("window.scrollTo(0, 1200)")
1234567891011121314151617
```

### 9.1 页面滚动案例

- 对于某些操作，Selenium API 并没有提供。比如，下拉进度条，它可以直接模拟运行 JavaScript，此时使用 execute_script() 方法即可实现

**代码实现**

```python
# document.body.scrollHeight 获取页面高度

from selenium import webdriver

browser = webdriver.Chrome()
browser.get('https://36kr.com/')
# scrollTo  不叠加 200 200    scrollBy 叠加  200 300  500操作
# 慢慢的下拉
for i in range(1,9):
    time.sleep(random.randint(100, 300) / 1000)
    browser.execute_script('window.scrollTo(0,{})'.format(i * 700)) # scrollTo 不叠加 700 1400 2100
1234567891011
```

- 这里就利用 execute_script() 方法将进度条下拉到最底部
  所以说有了这个方法，基本上 API 没有提供的所有功能都可以用执行 JavaScript 的方式来实现了。

## 十. 获取节点信息

### 获取标签属性

- 我们可以使用 get_attribute() 方法来获取节点的属性，但是其前提是先选中这个节点

**代码实现**

```python
from selenium import webdriver
url = 'https://pic.netbian.com/4kmeinv/index.html'
browser.get(url)
src = browser.find_elements(By.XPATH,'//ul[@class="clearfix"]/li/a/img')
for i in src:
    url = i.get_attribute('src')
    print(url)
1234567
```

通过 get_attribute() 方法，然后传入想要获取的属性名，就可以得到它的值

## 十一. 延时等待

- 在 Selenium 中，get() 方法会在网页框架加载结束后结束执行，此时如果获取 page_source，可能并不是浏览器完全加载完成的页面，如果某些页面有额外的 Ajax 请求，我们在网页源代码中也不一定能成功获取到。所以，这里需要延时等待一定时间，确保节点已经加载出来

**使用方法**
指定要查找的节点，然后指定一个最长等待时间。如果在规定时间内加载出来了这个节点，就返回查找的节点；如果到了规定时间依然没有加载出该节点，则抛出超时异常。

**代码实现**

```python
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

browser = webdriver.Chrome()
browser.get('https://www.baidu.com/')
wait = WebDriverWait(browser, 10)
input = wait.until(EC.presence_of_element_located((By.ID, 'kw')))
button = wait.until(EC.element_to_be_clickable((By.ID, 'su')))
print(input, button)
```

**补充解释**
这样可以做到的效果就是，在 10 秒内如果 ID 为 q 的节点（即搜索框）成功加载出来，就返回该节点；如果超过 10 秒还没有加载出来，就抛出异常。

对于按钮，可以更改一下等待条件，比如改为 element_to_be_clickable，也就是可点击，所以查找按钮时查找 CSS 选择器为.btn-search 的按钮，如果 10 秒内它是可点击的，也就是成功加载出来了，就返回这个按钮节点；如果超过 10 秒还不可点击，也就是没有加载出来，就抛出异常。

- 等待条件及其含义

| 等待条件                                     | 含义                                                |
| -------------------------------------------- | --------------------------------------------------- |
| title_is                                     | 标题是某内容                                        |
| title_contains                               | 标题包含某内容                                      |
| presence_of_element_located                  | 节点加载出，传入定位元组，如 (By.ID, ‘p’)           |
| visibility_of_element_located                | 节点可见，传入定位元组                              |
| visibility_of                                | 可见，传入节点对象                                  |
| presence_of_all_elements_located             | 所有节点加载出                                      |
| text_to_be_present_in_element                | 某个节点文本包含某文字                              |
| text_to_be_present_in_element_value          | 某个节点值包含某文字                                |
| frame_to_be_available_and_switch_to_it frame | 加载并切换                                          |
| invisibility_of_element_located              | 节点不可见                                          |
| element_to_be_clickable                      | 节点可点击                                          |
| staleness_of                                 | 判断一个节点是否仍在 DOM，可判断页面是否已经刷新    |
| element_to_be_selected                       | 节点可选择，传节点对象                              |
| element_located_to_be_selected               | 节点可选择，传入定位元组                            |
| element_selection_state_to_be                | 传入节点对象以及状态，相等返回 True，否则返回 False |
| element_located_selection_state_to_be        | 传入定位元组以及状态，相等返回 True，否则返回 False |
| alert_is_present                             | 是否出现 Alert                                      |

## 十二. 选项卡管理

- 在访问网页的时候，会开启一个个选项卡。在 Selenium 中，我们也可以对选项卡进行操作

**代码实现**

```python
import time
from selenium import webdriver

browser = webdriver.Chrome()
browser.get('https://www.baidu.com')
browser.execute_script('window.open()')
print(browser.window_handles)
browser.switch_to.window(browser.window_handles[1])

browser.get('https://www.baidu.com')
time.sleep(1)
browser.switch_to.window(browser.window_handles[0])
browser.get('https://pic.netbian.com')
```

**补充解释**
控制台输出如下：

```
['CDwindow-4f58e3a7-7167-4587-bedf-9cd8c867f435'
, 'CDwindow-6e05f076-6d77-453a-a36c-32baacc447df']
```

- 首先访问了百度，然后调用了 execute_script() 方法，这里传入 window.open() 这个 JavaScript 语句新开启一个选项卡。接下来，我们想切换到该选项卡。这里调用 window_handles 属性获取当前开启的所有选项卡，返回的是选项卡的代号列表。要想切换选项卡，只需要调用 switch_to_window() 方法即可，其中参数是选项卡的代号。这里我们将第二个选项卡代号传入，即跳转到第二个选项卡，接下来在第二个选项卡下打开一个新页面，然后切换回第一个选项卡重新调用 switch_to_window() 方法，再执行其他操作即可。

## 十三. 异常处理

- 在使用 Selenium 的过程中，难免会遇到一些异常，例如超时、节点未找到等错误，一旦出现此类错误，程序便不会继续运行。这里我们可以使用 try except 语句来捕获各种异常。

**代码实现**

```python
from selenium import webdriver
from selenium.common.exceptions import TimeoutException, NoSuchElementException
browser = webdriver.Chrome()
try:
    browser.get('https://www.baidu.com')
except TimeoutException:
    print('Time Out')
try:
    browser.find_element(By.ID,'hello')
except NoSuchElementException:
    print('No Element')
finally:
    browser.close()
```

**补充解释**
这里我们使用 try except 来捕获各类异常。比如，我们对 find_element_by_id() 查找节点的方法捕获 NoSuchElementException 异常，这样一旦出现这样的错误，就进行异常处理，程序也不会中断了。

控制台的输出如下：

```python
No Element
```

## 十四. 绕过检测

```python
# 无处理
browser.get('https://bot.sannysoft.com/')

# 设置屏蔽
options = webdriver.ChromeOptions()
options.add_argument('--disable-blink-features=AutomationControlled')
browsers = webdriver.Chrome(chrome_options=options)
browsers.get('https://bot.sannysoft.com/')
```

## 十五. selenium实例

- 采集某品会商品

```python
from selenium import webdriver
import time
import random
from pymongo import MongoClient
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC


class WeiPin():

    def __init__(self):
        self.client = MongoClient(host='127.0.0.1', port=27017)
        self.col = self.client['spiders']['weipinhui']
        options = webdriver.ChromeOptions()
        options.add_experimental_option('useAutomationExtension', False)  # 去掉开发者警告
        options.add_experimental_option('excludeSwitches', ['enable-automation'])
        # 不加载图片
        prefs = {"profile.managed_default_content_settings.images": 2}
        options.add_experimental_option("prefs", prefs)
        self.browser = webdriver.Chrome(options=options)
        self.browser.maximize_window()

    def base(self):
        self.browser.get('https://www.vip.com/')
        wait = WebDriverWait(self.browser, 10)
        input = wait.until(EC.element_to_be_clickable((By.XPATH, '//input[@class="c-search-input  J-search-input"]')))
        button = wait.until(
            EC.element_to_be_clickable((By.XPATH, '//a[@class="c-search-button  J-search-button  J_fake_a"]')))
        input.send_keys('口红')
        time.sleep(random.randint(3000, 3400) / 1000)
        button.click()
        time.sleep(random.randint(1000, 1400) / 1000)

    def spider(self):
        self.drop_down()
        # print(self.browser.page_source)
        node_list = self.browser.find_elements(By.XPATH,
                                               '//section[@id="J_searchCatList"]/div[@class="c-goods-item  J-goods-item c-goods-item--auto-width"]')
        # print(node_list)
        for node in node_list:
            price = node.find_element(By.XPATH,
                                      './/div[@class="c-goods-item__sale-price J-goods-item__sale-price"]').text
            title = node.find_element(By.XPATH, './/div[2]/div[2]').text
            try:
                discount = node.find_element(By.XPATH,
                                             './/div[@class="c-goods-item__main-price     J-goods-item__main-price"]/div[@class="c-goods-item__discount  J-goods-item__discount"]').text
            except Exception as e:
                print('数据为空')
                discount = '空'
            try:
                market_price = node.find_element(By.XPATH,
                                                 './/div[@class="c-goods-item__market-price  J-goods-item__market-price"]').text
            except Exception as e:
                print('数据为空')
                market_price = '空'

            item = {
                'title': title,
                'price': price,
                'discount': discount,
                'market_price': market_price
            }
            print(item)
            self.save_mongo(item)
        self.page_next()

    def save_mongo(self, item):
        if isinstance(item, dict):
            self.col.insert_one(item)

    def page_next(self):
        try:
            next_button = self.browser.find_element(By.XPATH, '//*[@id="J_nextPage_link"]')
            if next_button:
                next_button.click()
                self.spider()
            else:
                self.browser.close()

        except Exception as e:
            self.browser.close()

    def drop_down(self):
        for x in range(1, 10):
            js = f"document.documentElement.scrollTop = {x * 1000}"
            self.browser.execute_script(js)
            time.sleep(random.randint(500, 800) / 1000)


if __name__ == '__main__':
    weipin = WeiPin()
    weipin.base()
    weipin.spider()
```

