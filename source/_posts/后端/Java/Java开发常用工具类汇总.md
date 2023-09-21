---
title: Java开发常用工具类汇总
date: 2023年4月26日11:03:39
tags: Java
categories: 后端
keywords: 
description: 总结一些我在开发中使用到的工具类
top_img: 
comments:
cover: https://w.wallhaven.cc/full/1p/wallhaven-1pd1o9.jpg
toc:
toc_number: https://w.wallhaven.cc/full/1p/wallhaven-1pd1o9.jpg
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

# 网络与文件

## 文件处理FileUtils

```java
package com.training.utils;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;
import com.sun.xml.internal.messaging.saaj.util.ByteOutputStream;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.*;
import java.net.URL;

public class FileUtils {

     /**
     * @param fileUrl 资源地址
     * @Description: 网络资源转file, 用完以后必须删除该临时文件
     * @author: 赵兴炎
     * @date: 2019年7月10日
     * @return: 返回值
     */
     public static File urlToFile(String fileUrl) {
          String path = System.getProperty("user.dir");
          File upload = new File(path, "tmp");
          if (!upload.exists()) {
               upload.mkdirs();
          }
          return urlToFile(fileUrl, upload);
     }

     /**
     * @param fileUrl 资源地址
     * @param upload  临时文件路径
     * @Description: 网络资源转file, 用完以后必须删除该临时文件
     * @author: 赵兴炎
     * @date: 2019年7月10日
     * @return: 返回值
     */
     public static File urlToFile(String fileUrl, File upload) {
          String fileName = fileUrl.substring(fileUrl.lastIndexOf("/"));
          FileOutputStream downloadFile = null;
          InputStream openStream = null;
          File savedFile = null;
          try {
               savedFile = new File(upload.getAbsolutePath() + fileName);
               URL url = new URL(fileUrl);
               java.net.HttpURLConnection connection = (java.net.HttpURLConnection) url.openConnection();
               openStream = connection.getInputStream();
               int index;
               byte[] bytes = new byte[1024];
               downloadFile = new FileOutputStream(savedFile);
               while ((index = openStream.read(bytes)) != -1) {
                    downloadFile.write(bytes, 0, index);
                    downloadFile.flush();
               }
          } catch (Exception e) {
               e.printStackTrace();
          } finally {
               try {
                    if (openStream != null) {
                         openStream.close();
                    }
                    if (downloadFile != null) {
                         downloadFile.close();
                    }
               } catch (Exception e) {
                    e.printStackTrace();
               }

          }
          return savedFile;
     }

     /**
     * MultipartFile 转 File
     *
     * @param file
     * @throws Exception
     */
     public static File multipartFileToFile(MultipartFile file) throws Exception {

          File toFile = null;
          if ("".equals(file) || file.getSize() <= 0) {
               file = null;
          } else {
               InputStream ins = null;
               ins = file.getInputStream();
               toFile = new File(file.getOriginalFilename());
               inputStreamToFile(ins, toFile);
               ins.close();
          }
          return toFile;
     }

     //获取流文件
     private static void inputStreamToFile(InputStream ins, File file) {
          try {
               OutputStream os = new FileOutputStream(file);
               int bytesRead = 0;
               byte[] buffer = new byte[8192];
               while ((bytesRead = ins.read(buffer, 0, 8192)) != -1) {
                    os.write(buffer, 0, bytesRead);
               }
               os.close();
               ins.close();
          } catch (Exception e) {
               e.printStackTrace();
          }
     }

     /**
     * MultipartFile保存文件保存文件
     *
     * @param file     文件
     * @param filePath 文件保存路径（绝对路径)
     * @return 相对路径, 用于访问
     */
     private String saveFile(MultipartFile file, String filePath) {
          File realFile = new File(filePath);
          if (!realFile.getParentFile().exists()) {
               realFile.getParentFile().mkdirs();
          }
          try {
               FileUtils.copyInputStreamToFile(file.getInputStream(), realFile);
          } catch (IOException e) {
               e.printStackTrace();
               throw new MyException(CodeMsgEnum.FAIL_FILE_UPLOAD);
          }
          return path;
     }

     /**
     * file转multiparfile
     *
     * @return
     */
     public static MultipartFile fileToMultipartFile(String filePath) throws Exception {
          try {
               File pdfFile = new File(filePath);
               FileInputStream fileInputStream = new FileInputStream(pdfFile);
               return new MockMultipartFile(pdfFile.getName(), pdfFile.getName(), ContentType.APPLICATION_OCTET_STREAM.toString(), fileInputStream);
          } catch (IOException e) {
               e.printStackTrace();
               throw new MyException("123");
          }
     }


     /**
     * 对图片进行原比例无损压缩,压缩后覆盖原图片
     *
     * @param path
     */
     private static void doWithPhoto(String path) {
          File file = new File(path);
          if (!file.exists()) {
               return;
          }
          BufferedImage image = null;
          FileOutputStream os = null;
          try {
               image = ImageIO.read(file);
               int width = image.getWidth();
               int height = image.getHeight();
               BufferedImage bfImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
               bfImage.getGraphics().drawImage(image.getScaledInstance(width, height, Image.SCALE_SMOOTH), 0, 0, null);
               os = new FileOutputStream(path);
               JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(os);
               encoder.encode(bfImage);
          } catch (IOException e) {
               e.printStackTrace();
          } finally {
               if (os != null) {
                    try {
                         os.close();
                    } catch (IOException e) {
                         e.printStackTrace();
                    }
               }
          }
     }


     public static void main(String[] args) {
          String mg = "http://p2.music.126.net/yw22uDZBZ6T0L9vG-8933Q==/5795525790131601.jpg";
          File urlToFile = urlToFile(mg);
          System.out.println(urlToFile.getAbsolutePath());
          //        urlToFile.delete();
     }

     /**
     * 网络地址文件转换为输入流
     *
     * @param fileUrl
     * @return
     */
     public static InputStream downloadPicture(String fileUrl) {
          String fileName = fileUrl.substring(fileUrl.lastIndexOf("/"));
          InputStream openStream = null;
          ByteOutputStream outputStream = null;
          try {
               URL url = new URL(fileUrl);
               java.net.HttpURLConnection connection = (java.net.HttpURLConnection) url.openConnection();
               openStream = connection.getInputStream();
               return openStream;
          } catch (IOException e) {
               throw new RuntimeException(e);
          }

     }


}
```

## 本地网络信息networkUtils

```java
package com.dce.blockchain.web.util;

import com.dce.blockchain.web.entity.Setting;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLDecoder;
import java.util.List;
import java.util.Map;

/**
 * @program: BlockChain-Java-8090
 * @description:
 * @author: CuiJieXiang_1023
 * @create: 2023-04-26 23:24
 **/
@Slf4j
@Setter
@Component
public class networkUtils {

    private static Setting setting;

    @Autowired
    public void setSetting(Setting setting) {
        networkUtils.setting = setting;
    }

    /**
     * @return java.lang.String
     * @author tang wen jun
     * 获取公网ip
     * @date 2021/12/8
     */
    public static String getIpv4IP() {
        StringBuilder result = new StringBuilder();
        BufferedReader in = null;
        try {
            URL realUrl = new URL("https://www.taobao.com/help/getip.php");
            // 打开和URL之间的连接
            URLConnection connection = realUrl.openConnection();
            // 设置通用的请求属性
            connection.setRequestProperty("accept", "*/*");
            connection.setRequestProperty("connection", "Keep-Alive");
            connection.setRequestProperty("user-agent",
                    "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");
            // 建立实际的连接
            connection.connect();
            // 获取所有响应头字段
            Map<String, List<String>> map = connection.getHeaderFields();
            // 定义 BufferedReader输入流来读取URL的响应
            in = new BufferedReader(new InputStreamReader(
                    connection.getInputStream()));
            String line;
            while ((line = in.readLine()) != null) {
                result.append(line);
            }
        } catch (Exception e) {
            log.error("获取ipv4公网地址异常");
            e.printStackTrace();
        } finally {
            try {
                if (in != null) {
                    in.close();
                }
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
        String str = result.toString().replace("ipCallback({ip:", "");
        String ipStr = str.replace("})", "");

        return ipStr.replace('"', ' ');
    }
    public static String getIpAddr(HttpServletRequest request) {
        if (request == null) {
            return null;
        }

        String ip = null;

        // X-Forwarded-For：Squid 服务代理
        String ipAddresses = request.getHeader("X-Forwarded-For");
        if (ipAddresses == null || ipAddresses.length() == 0 || "unknown".equalsIgnoreCase(ipAddresses)) {
            // Proxy-Client-IP：apache 服务代理
            ipAddresses = request.getHeader("Proxy-Client-IP");
        }
        if (ipAddresses == null || ipAddresses.length() == 0 || "unknown".equalsIgnoreCase(ipAddresses)) {
            // WL-Proxy-Client-IP：weblogic 服务代理
            ipAddresses = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ipAddresses == null || ipAddresses.length() == 0 || "unknown".equalsIgnoreCase(ipAddresses)) {
            // HTTP_CLIENT_IP：有些代理服务器
            ipAddresses = request.getHeader("HTTP_CLIENT_IP");
        }
        if (ipAddresses == null || ipAddresses.length() == 0 || "unknown".equalsIgnoreCase(ipAddresses)) {
            // X-Real-IP：nginx服务代理
            ipAddresses = request.getHeader("X-Real-IP");
        }

        // 有些网络通过多层代理，那么获取到的ip就会有多个，一般都是通过逗号（,）分割开来，并且第一个ip为客户端的真实IP
        if (ipAddresses != null && ipAddresses.length() != 0) {
            ip = ipAddresses.split(",")[0];
        }

        // 还是不能获取到，最后再通过request.getRemoteAddr();获取
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ipAddresses)) {
            ip = request.getRemoteAddr();
        }
        return "0:0:0:0:0:0:0:1".equals(ip) ? "127.0.0.1" : ip;
    }
    /**
     * 解析ip地址
     *
     * 设置访问地址为http://ip.taobao.com/service/getIpInfo.php
     * 设置请求参数为ip=[已经获得的ip地址]
     * 设置解码方式为UTF-8
     *
     *
     * @param content   请求的参数 格式为：ip=192.168.1.101
     * @param encoding 服务器端请求编码。如GBK,UTF-8等
     * @return
     * @throws UnsupportedEncodingException
     */
    public String getAddresses(String content, String encoding) throws UnsupportedEncodingException {
        //设置访问地址
        String urlStr = "http://ip.taobao.com/service/getIpInfo.php";
        // 从http://whois.pconline.com.cn取得IP所在的省市区信息
        String returnStr = this.getResult(urlStr, content, encoding);
        if (returnStr != null) {
            // 处理返回的省市区信息
            // System.out.println(returnStr);
            String[] temp = returnStr.split(",");
            if (temp.length < 3) {
                return "0";// 无效IP，局域网测试
            }

            String country = ""; //国家
            String area = ""; //地区
            String region = ""; //省份
            String city = ""; //市区
            String county = ""; //地区
            String isp = ""; //ISP公司
            for (int i = 0; i < temp.length; i++) {
                switch (i) {
                    case 2:
                        country = (temp[i].split(":"))[1].replaceAll("\"", "");
                        country = URLDecoder.decode(country, encoding);// 国家
                        break;
                    case 3:
                        area = (temp[i].split(":"))[1].replaceAll("\"", "");
                        area = URLDecoder.decode(area, encoding);// 地区
                        break;
                    case 4:
                        region = (temp[i].split(":"))[1].replaceAll("\"", "");
                        region = URLDecoder.decode(region, encoding);// 省份
                        break;
                    case 5:
                        city = (temp[i].split(":"))[1].replaceAll("\"", "");
                        city = URLDecoder.decode(city, encoding);// 市区
                        if ("内网IP".equals(city)) {
                            return "地址为：内网IP";
                        }
                        break;
                    case 6:
                        county = (temp[i].split(":"))[1].replaceAll("\"", "");
                        county = URLDecoder.decode(county, encoding);// 地区
                        break;
                    case 7:
                        isp = (temp[i].split(":"))[1].replaceAll("\"", "");
                        isp = URLDecoder.decode(isp, encoding); // ISP公司
                        break;
                }
            }
            return new StringBuffer("地址为：" + country + ",").append(region + "省,").append(city + "市,").append(county + ",").append("ISP公司：" + isp)
                    .toString();
        }
        return null;
    }

    /**
     * 访问目标地址并获取返回值
     *
     * @param urlStr   请求的地址
     * @param content  请求的参数 格式为：ip=192.168.1.101
     * @param encoding 服务器端请求编码。如GBK,UTF-8等
     * @return
     */
    private String getResult(String urlStr, String content, String encoding) {
        URL url = null;
        HttpURLConnection connection = null;
        try {
            url = new URL(urlStr);
            connection = (HttpURLConnection) url.openConnection();// 新建连接实例
            connection.setConnectTimeout(2000);// 设置连接超时时间，单位毫秒
            connection.setReadTimeout(33000);// 设置读取数据超时时间，单位毫秒
            connection.setDoOutput(true);// 是否打开输出流 true|false
            connection.setDoInput(true);// 是否打开输入流true|false
            connection.setRequestMethod("POST");// 提交方法POST|GET
            connection.setUseCaches(false);// 是否缓存true|false
            connection.connect();// 打开连接端口
            DataOutputStream out = new DataOutputStream(connection.getOutputStream());// 打开输出流往对端服务器写数据
            out.writeBytes(content);// 写数据,也就是提交你的表单 name=xxx&pwd=xxx
            out.flush();// 刷新
            out.close();// 关闭输出流
            BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream(), encoding));
            // 往对端写完数据对端服务器返回数据
            // ,以BufferedReader流来读取
            StringBuffer buffer = new StringBuffer();
            String line = "";
            while ((line = reader.readLine()) != null) {
                buffer.append(line);
            }
            reader.close();
            return buffer.toString();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (connection != null) {
                connection.disconnect();// 关闭连接
            }
        }
        return null;
    }
}
```

## RedisUtils

```java
package com.training.utils;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

import com.training.vo.MusicVo;
import io.lettuce.core.RedisURI;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.BoundListOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.data.redis.core.ZSetOperations;
import org.springframework.data.redis.core.convert.RedisTypeMapper;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;

import javax.crypto.MacSpi;

@Component
public class RedisUtil {
     @Autowired
     private RedisTemplate<String, Object> redisTemplate;
     private StringRedisTemplate stringRedisTemplate;

     public RedisUtil(RedisTemplate<String, Object> redisTemplate, StringRedisTemplate stringRedisTemplate) {
          this.redisTemplate = redisTemplate;
          this.stringRedisTemplate = stringRedisTemplate;
     }

     @Value("${redis_prefix.token}")
     public static String tokenPrefix;

     /*
     * 歌曲存入 Redis 键 ： musicPrefix:MusicId:
     * */
     public static final String musicPrefix = "MUSICS";

     /**
     * 歌曲歌单存入 Redis 键：musicPrefix:ListId:
     */
     public static final String musicListPrefix = "MUSIC_LISTS";
     /**
     * 榜单存入 Redis 键名称 ： hotChartPrefix:分类名称
     */
     public static final String HotChartPrefix = "CategoryChart";

     /*
     * 总榜存入 Redis 键名称 ：hotChartPrefix:TotalHotChartPrefix
     * */
     public static final String TotalHotChartPrefix = "TotalChart";

     /**
     * 指定缓存失效时间
     *
     * @param key  键
     * @param time 时间(秒)
     * @return 返回
     */
     public boolean expire(String key, long time) {
          try {
               if (time > 0) {
                    redisTemplate.expire(key, time, TimeUnit.SECONDS);
               }
               return true;
          } catch (Exception e) {
               e.printStackTrace();
               return false;
          }
     }

     /**
     * 根据key 获取过期时间
     *
     * @param key 键 不能为null
     * @return 时间(秒) 返回0代表为永久有效
     */
     public long getExpire(String key) {
          return redisTemplate.getExpire(key, TimeUnit.SECONDS);
     }

     /**
     * 判断key是否存在
     *
     * @param key 键
     * @return true 存在 false不存在
     */
     public boolean hasKey(String key) {
          try {
               return Boolean.TRUE.equals(redisTemplate.hasKey(key));
          } catch (Exception e) {
               e.printStackTrace();
               return false;
          }
     }


     /**
     * 获取前缀匹配的所有 key
     *
     * @param key
     * @return
     */
     public List<Object> getPrefixKeyValue(String prefix) {
          List<Object> values = null;
          // 获取所有的key
          Set<String> keys = redisTemplate.keys(prefix);
          if (null != keys) {
               // 批量获取数据
               values = redisTemplate.opsForValue().multiGet(keys);
          }
          return values;
     }

     /**
     * 删除缓存
     *
     * @param key 可以传一个值 或多个
     */
     @SuppressWarnings("unchecked")
     public void del(String... key) {
          if (key != null && key.length > 0) {
               if (key.length == 1) {
                    redisTemplate.delete(key[0]);
               } else {
                    redisTemplate.delete(CollectionUtils.arrayToList(key));
               }
          }
     }

     //============================String=============================//

     /**
     * 普通缓存获取
     *
     * @param key 键
     * @return 值
     */
     public Object get(String key) {
          return key == null ? null : redisTemplate.opsForValue().get(key);
     }

     /**
     * 普通缓存放入
     *
     * @param key   键
     * @param value 值
     * @return true成功  false失败
     */
     public boolean set(String key, Object value) {
          try {
               redisTemplate.opsForValue().set(key, value);
               return true;
          } catch (Exception e) {
               e.printStackTrace();
               return false;
          }
     }

     /**
     * 普通缓存放入并设置时间
     *
     * @param key   键
     * @param value 值
     * @param time  时间(秒) time要大于0 如果time小于等于0 将设置无限期
     * @return true成功 false 失败
     */
     public boolean set(String key, Object value, long time) {
          try {
               if (time > 0) {
                    redisTemplate.opsForValue().set(key, value, time, TimeUnit.SECONDS);
               } else {
                    set(key, value);
               }
               return true;
          } catch (Exception e) {
               e.printStackTrace();
               return false;
          }
     }

     /**
     * 递增
     *
     * @param key   键
     * @param delta 要增加几(大于0)
     * @return
     */
     public long incr(String key, long delta) {
          if (delta < 0) {
               throw new RuntimeException("递增因子必须大于0");
          }
          return redisTemplate.opsForValue().increment(key, delta);
     }

     /**
     * 递减
     *
     * @param key   键
     * @param delta 要减少几(小于0)
     * @return
     */
     public long decr(String key, long delta) {
          if (delta < 0) {
               throw new RuntimeException("递减因子必须大于0");
          }
          return redisTemplate.opsForValue().increment(key, -delta);
     }

     //================================Map=================================//

     /**
     * HashGet
     *
     * @param key  HashMap数据键 不能为null
     * @param item HashKey 项 不能为null
     * @return 值
     */
     public Object hget(String key, String item) {
          return redisTemplate.opsForHash().get(key, item);
     }

     /**
     * 获取hashKey对应的所有键值
     *
     * @param key 键
     * @return 对应的多个键值
     */
     public Map<Object, Object> hmget(String key) {
          return redisTemplate.opsForHash().entries(key);
     }

     /**
     * HashSet
     *
     * @param key 键
     * @param map 对应多个键值
     * @return true 成功 false 失败
     */
     public boolean hmset(String key, Map<String, Object> map) {
          try {
               redisTemplate.opsForHash().putAll(key, map);
               return true;
          } catch (Exception e) {
               e.printStackTrace();
               return false;
          }
     }

     /**
     * HashSet 并设置时间
     *
     * @param key  键
     * @param map  对应多个键值
     * @param time 时间(秒)
     * @return true成功 false失败
     */
     public boolean hmset(String key, Map<String, Object> map, long time) {
          try {
               redisTemplate.opsForHash().putAll(key, map);
               if (time > 0) {
                    expire(key, time);
               }
               return true;
          } catch (Exception e) {
               e.printStackTrace();
               return false;
          }
     }

     /**
     * 向一张hash表中放入数据,如果不存在将创建
     *
     * @param key   键
     * @param item  项
     * @param value 值
     * @return true 成功 false失败
     */
     public boolean hset(String key, String item, Object value) {
          try {
               redisTemplate.opsForHash().put(key, item, value);
               return true;
          } catch (Exception e) {
               e.printStackTrace();
               return false;
          }
     }

     /**
     * 向一张hash表中放入数据,如果不存在将创建，并设置其过期时间 time
     *
     * @param key   键
     * @param item  项
     * @param value 值
     * @param time  时间(秒)  注意:如果已存在的 hash 表有时间,这里将会替换原有的时间
     * @return true 成功 false失败
     */
     public boolean hset(String key, String item, Object value, long time) {
          try {
               redisTemplate.opsForHash().put(key, item, value);
               if (time > 0) {
                    expire(key, time);
               }
               return true;
          } catch (Exception e) {
               e.printStackTrace();
               return false;
          }
     }

     /**
     * 删除hash表中的值
     *
     * @param key  键 不能为null
     * @param item 项 可以使多个 不能为null
     */
     public void hdel(String key, Object... item) {
          redisTemplate.opsForHash().delete(key, item);
     }

     /**
     * 判断hash表中是否有该项的值
     *
     * @param key  键 不能为null
     * @param item 项 不能为null
     * @return true 存在 false不存在
     */
     public boolean hHasKey(String key, String item) {
          return redisTemplate.opsForHash().hasKey(key, item);
     }

     /**
     * hash递增 如果不存在,就会创建一个 并把新增后的值返回
     *
     * @param key  键
     * @param item 项
     * @param by   要增加几(大于0)
     * @return
     */
     public double hincr(String key, String item, double by) {
          return redisTemplate.opsForHash().increment(key, item, by);
     }

     /**
     * hash递减
     *
     * @param key  键
     * @param item 项
     * @param by   要减少记(小于0)
     * @return
     */
     public double hdecr(String key, String item, double by) {
          return redisTemplate.opsForHash().increment(key, item, -by);
     }

     //============================set=============================

     /**
     * 根据key获取Set中的所有值
     *
     * @param key 键
     * @return
     */
     public Set<Object> sGet(String key) {
          try {
               return redisTemplate.opsForSet().members(key);
          } catch (Exception e) {
               e.printStackTrace();
               return null;
          }
     }

     /**
     * 根据value从一个set中查询,是否存在
     *
     * @param key   键
     * @param value 值
     * @return true 存在 false不存在
     */
     public boolean sExistKey(String key, Object value) {
          try {
               return redisTemplate.opsForSet().isMember(key, value);
          } catch (Exception e) {
               e.printStackTrace();
               return false;
          }
     }

     /**
     * 将数据放入set缓存
     *
     * @param key    键
     * @param values 值 可以是多个
     * @return 成功个数
     */
     public long sSet(String key, Object... values) {
          try {
               return redisTemplate.opsForSet().add(key, values);
          } catch (Exception e) {
               e.printStackTrace();
               return 0;
          }
     }

     /**
     * 将set数据放入缓存
     *
     * @param key    键
     * @param time   时间(秒) 设置 HashSet 过期时间
     * @param values 值 可以是多个
     * @return 成功个数
     */
     public long sSetAndTime(String key, long time, Object... values) {
          try {
               Long count = redisTemplate.opsForSet().add(key, values);
               if (time > 0) {
                    expire(key, time);
               }
               return count;
          } catch (Exception e) {
               e.printStackTrace();
               return 0;
          }
     }

     /**
     * 获取set缓存的长度
     *
     * @param key 键
     * @return
     */
     public long sGetSetSize(String key) {
          try {
               return redisTemplate.opsForSet().size(key);
          } catch (Exception e) {
               e.printStackTrace();
               return 0;
          }
     }

     /**
     * 移除值为value的
     *
     * @param key    键
     * @param values 值 可以是多个
     * @return 移除的个数
     */
     public long setRemove(String key, Object... values) {
          try {
               return redisTemplate.opsForSet().remove(key, values);
          } catch (Exception e) {
               e.printStackTrace();
               return 0;
          }
     }
     //===============================list=================================

     /**
     * 获取list缓存的内容
     *
     * @param key   键
     * @param start 开始
     * @param end   结束  0 到 -1代表所有值
     * @return 键对应的 List
     */
     public List<Object> lGet(String key, long start, long end) {
          try {
               return redisTemplate.opsForList().range(key, start, end);
          } catch (Exception e) {
               e.printStackTrace();
               return null;
          }
     }

     /**
     * 获取list缓存的长度
     *
     * @param key 键
     * @return 返回的长度
     */
     public long lGetListSize(String key) {
          try {
               return redisTemplate.opsForList().size(key);
          } catch (Exception e) {
               e.printStackTrace();
               return 0;
          }
     }

     /**
     * 通过索引 获取list中的值
     *
     * @param key   键
     * @param index 索引  index>=0时， 0 表头，1 第二个元素，依次类推；index<0时，-1，表尾，-2倒数第二个元素，依次类推
     * @return
     */
     public Object lGetIndex(String key, long index) {
          try {
               return redisTemplate.opsForList().index(key, index);
          } catch (Exception e) {
               e.printStackTrace();
               return null;
          }
     }

     /**
     * 将list放入缓存
     *
     * @param key   键
     * @param value 值
     * @return
     */
     public boolean lSet(String key, Object value) {
          try {
               redisTemplate.opsForList().rightPush(key, value);
               return true;
          } catch (Exception e) {
               e.printStackTrace();
               return false;
          }
     }

     /**
     * 将list放入缓存
     *
     * @param key   键
     * @param value 值
     * @param time  时间(秒)
     * @return
     */
     public boolean lSet(String key, Object value, long time) {
          try {
               redisTemplate.opsForList().rightPush(key, value);
               if (time > 0) {
                    expire(key, time);
               }
               return true;
          } catch (Exception e) {
               e.printStackTrace();
               return false;
          }
     }

     /**
     * 将list放入缓存
     *
     * @param key   键
     * @param value 值
     * @return
     */
     public boolean lSet(String key, List<Object> value) {
          try {
               redisTemplate.opsForList().rightPushAll(key, value);
               return true;
          } catch (Exception e) {
               e.printStackTrace();
               return false;
          }
     }

     /**
     * 将list放入缓存
     *
     * @param key   键
     * @param value 值
     * @param time  时间(秒)
     * @return
     */
     public boolean lSet(String key, List<Object> value, long time) {
          try {
               redisTemplate.opsForList().rightPushAll(key, value);
               if (time > 0) {
                    expire(key, time);
               }
               return true;
          } catch (Exception e) {
               e.printStackTrace();
               return false;
          }
     }

     /**
     * 根据索引修改list中的某条数据
     *
     * @param key   键
     * @param index 索引
     * @param value 值
     * @return
     */
     public boolean lUpdateIndex(String key, long index, Object value) {
          try {
               redisTemplate.opsForList().set(key, index, value);
               return true;
          } catch (Exception e) {
               e.printStackTrace();
               return false;
          }
     }

     /**
     * 移除N个值为 value
     *
     * @param key   键
     * @param count 移除多少个
     * @param value 值
     * @return 移除的个数
     */
     public long lRemove(String key, long count, Object value) {
          try {
               return redisTemplate.opsForList().remove(key, count, value);
          } catch (Exception e) {
               e.printStackTrace();
               return 0;
          }
     }

     /**
     * 模糊查询获取key值
     *
     * @param pattern
     * @return
     */
     public Set keys(String pattern) {
          return redisTemplate.keys(pattern);
     }

     /**
     * 使用Redis的消息队列
     *
     * @param channel
     * @param message 消息内容
     */
     public void convertAndSend(String channel, Object message) {
          redisTemplate.convertAndSend(channel, message);
     }


     /**
     * 根据起始结束序号遍历Redis中的list
     *
     * @param listKey
     * @param start   起始序号
     * @param end     结束序号
     * @return
     */
     public List<Object> rangeList(String listKey, long start, long end) {
          //绑定操作
          BoundListOperations<String, Object> boundValueOperations = redisTemplate.boundListOps(listKey);
          //查询数据
          return boundValueOperations.range(start, end);
     }

     /**
     * 弹出右边的值 --- 并且移除这个值
     *
     * @param listKey
     */
     public Object rifhtPop(String listKey) {
          //绑定操作
          BoundListOperations<String, Object> boundValueOperations = redisTemplate.boundListOps(listKey);
          return boundValueOperations.rightPop();
     }

     /**----------------zSet相关操作------------------*/
     /**
     * 添加元素,有序集合是按照元素的score值由小到大排列
     *
     * @param key
     * @param value
     * @param score
     * @return
     */
     public Boolean zAdd(String key, String value, double score) {
          return stringRedisTemplate.opsForZSet().add(key, value, score);
     }

     public Long zAdd(String key, Set<ZSetOperations.TypedTuple<String>> values) {
          return stringRedisTemplate.opsForZSet().add(key, values);
     }

     public Long zRemove(String key, Object... values) {
          return redisTemplate.opsForZSet().remove(key, values);
     }

     /**
     * 增加元素的score值，并返回增加后的值
     *
     * @return
     */
     public Double zIncrementScore(String key, String value, double delta) {
          return stringRedisTemplate.opsForZSet().incrementScore(key, value, delta);
     }

     /**
     * 返回元素在集合的排名,有序集合是按照元素的score值由小到大排列
     *
     * @param key
     * @param value
     * @return
     */
     public Long zRank(String key, Object value) {
          return stringRedisTemplate.opsForZSet().rank(key, value);
     }

     /**
     * 返回元素在集合的排名,按元素的score值由大到小排列
     *
     * @param key
     * @param value
     * @return
     */
     public Long zReverseRank(String key, Object value) {
          return stringRedisTemplate.opsForZSet().reverseRank(key, value);
     }

     /**
     * 分页查询 zset 数据，zset的数据score需要是从1开始递增
     *
     * @param key
     * @param pageNum
     * @param pageSize
     * @return
     */
     public Set zSetGetReverseByPage(String key, int pageNum, int pageSize) {
          try {
               if (Boolean.TRUE.equals(redisTemplate.hasKey(key))) {
                    int start = (pageNum - 1) * pageSize;
                    int end = pageNum * pageSize - 1;
                    Long size = redisTemplate.opsForZSet().size(key);
                    if (end > size) {
                         end = -1;
                    }
                    return redisTemplate.opsForZSet().reverseRange(key, start, end);
               } else {
                    return null;
               }
          } catch (Exception e) {
               e.printStackTrace();
               return null;
          }
     }

     /**
     * 获取集合的元素, 从小到大排序
     *
     * @param key
     * @param start
     * @param end
     * @return
     */
     public Set<String> zRange(String key, long start, long end) {
          return stringRedisTemplate.opsForZSet().range(key, start, end);
     }

     /**
     * 获取集合元素, 并且把score值也获取
     */
     public Set<ZSetOperations.TypedTuple<String>> zRangeWithScores(String key, long start, long end) {
          return stringRedisTemplate.opsForZSet().rangeWithScores(key, start, end);
     }

     /**
     * 根据Score值查询集合元素
     *
     * @param key
     * @param min
     * @param max
     * @return
     */
     public Set<String> zRangeByScore(String key, double min, double max) {
          return stringRedisTemplate.opsForZSet().rangeByScore(key, min, max);
     }

     /**
     * 根据Score值查询集合元素, 从小到大排序
     *
     * @param key
     * @param min
     * @param max
     * @return
     */
     public Set<ZSetOperations.TypedTuple<String>> zRangeByScoreWithScores(String key, double min, double max) {
          return stringRedisTemplate.opsForZSet().rangeByScoreWithScores(key, min, max);
     }

     public Set<ZSetOperations.TypedTuple<String>> zRangeByScoreWithScores(String key, double min, double max, long start, long end) {
          return stringRedisTemplate.opsForZSet().rangeByScoreWithScores(key, min, max, start, end);
     }

     /**
     * 获取集合的元素, 从大到小排序
     *
     * @param key
     * @param start
     * @param end
     * @return
     */
     public Set<String> zReverseRange(String key, long start, long end) {
          return stringRedisTemplate.opsForZSet().reverseRange(key, start, end);
     }

     /**
     * 获取集合的元素, 从大到小排序, 并返回score值
     *
     * @param key
     * @param start
     * @param end
     * @return
     */
     public Set<ZSetOperations.TypedTuple<String>> zReverseRangeWithScores(String key, long start, long end) {
          return stringRedisTemplate.opsForZSet().reverseRangeWithScores(key, start, end);
     }

     /**
     * 将某一首音乐添加到对应的排行榜中
     *
     * @param music
     */
     public void insertHotChart(MusicVo music) {
          List<String> hotChartNames = getHotChartNames(music.getLabels());
          hotChartNames.forEach(item -> {
               this.zAdd(item, String.valueOf(music.getMusicId()), music.getPlayAmount());
          });
     }

     /**
     * 将某一首音乐从redis排行榜中移除
     *
     * @param music
     */
     public void removeHotChart(MusicVo music) {
          List<String> hotChartNames = getHotChartNames(music.getLabels());
          hotChartNames.forEach(item -> {
               this.zRemove(item, music.getMusicId());
          });
     }

     private List<String> getHotChartNames(List<String> labels) {
          if (labels == null) {
               labels = new ArrayList<>();
          }
          List<String> collect = labels.stream().map(item -> {
               return RedisUtil.HotChartPrefix + ":" + item;
          })
               .collect(Collectors.toList());
          collect.add(RedisUtil.HotChartPrefix + ":" + RedisUtil.TotalHotChartPrefix);
          return collect;
     }
}
```

# 区块链开发

## 公钥与私钥KeyUtils

```java
package com.dce.blockchain.web.util;

import com.dce.blockchain.web.entity.Wallet;
import com.dce.blockchain.web.exception.BlockChainException;
import com.dce.blockchain.web.exception.MyExceptionType;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.util.Base64Utils;

import java.io.*;
import java.math.BigInteger;
import java.security.*;
import java.security.interfaces.RSAPrivateCrtKey;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.RSAPublicKeySpec;

@Component
@Slf4j
public class KeyUtils {

    private static final int KEY_SIZE = 2048;
    private static final String ALGORITHM = "RSA";

    /**
     * 生成区块链公钥与私钥（使用RSA算法）
     *
     * @return 包含公钥和私钥的KeyPair对象
     * @throws NoSuchAlgorithmException
     */
    public static KeyPair generateKeyPair() throws NoSuchAlgorithmException {
        KeyPairGenerator keyPairGenerator = KeyPairGenerator.getInstance(ALGORITHM);
        keyPairGenerator.initialize(KEY_SIZE);
        return keyPairGenerator.generateKeyPair();
    }

    /**
     * 将私钥保存为文件
     *
     * @param privateKey 私钥
     * @param filePath   保存私钥的文件路径
     * @throws IOException
     */
    public static void savePrivateKeyToFile(Wallet wallet, String filePath) throws IOException {
        PrivateKey privateKey = wallet.getPrivateKey();
        String address = wallet.getWalletAddress();
        filePath += ("/" + address + ".key");
        try (FileOutputStream fos = new FileOutputStream(filePath); ObjectOutputStream oos = new ObjectOutputStream(fos)) {
            oos.writeObject(privateKey);
        } catch (IOException exception) {
            log.error("私钥文件保存失败，失败原因：保存地址有误");
            throw new BlockChainException(MyExceptionType.FILE_SAVE_ERROR);
        }
    }

    /**
     * 将文件读取为私钥
     *
     * @param filePath 包含私钥的文件路径
     * @return 私钥
     * @throws IOException
     * @throws ClassNotFoundException
     */
    public static PrivateKey getPrivateKeyFromFile(File file) throws IOException, ClassNotFoundException {
        FileInputStream fis = new FileInputStream(file);
        ObjectInputStream ois = new ObjectInputStream(fis);
        return (PrivateKey) ois.readObject();
    }


    /**
     * 传入私钥，根据传入的私钥计算公钥
     *
     * @param privateKey 私钥
     * @return 公钥
     * @throws NoSuchAlgorithmException
     * @throws InvalidKeySpecException
     */
    public static PublicKey getPublicKeyFromPrivateKey(PrivateKey privateKey) throws NoSuchAlgorithmException, InvalidKeySpecException {
        RSAPrivateCrtKey privateCrtKey = (RSAPrivateCrtKey) privateKey;
        RSAPublicKeySpec publicKeySpec = new RSAPublicKeySpec(privateCrtKey.getModulus(), BigInteger.valueOf(65537));
        KeyFactory keyFactory = KeyFactory.getInstance(ALGORITHM);
        return keyFactory.generatePublic(publicKeySpec);
    }


    /**
     * 将私钥转换为字符串
     *
     * @param privateKey 私钥
     * @return 私钥的Base64编码字符串
     */
    public static String privateKeyToString(PrivateKey privateKey) {
        return Base64Utils.encodeToString(privateKey.getEncoded());
    }

    /**
     * 用私钥字符串生成私钥
     *
     * @param privateKeyString 私钥的Base64编码字符串
     * @return 私钥
     * @throws NoSuchAlgorithmException
     * @throws InvalidKeySpecException
     */
    public static PrivateKey stringToPrivateKey(String privateKeyString) throws NoSuchAlgorithmException, InvalidKeySpecException {
        byte[] privateKeyBytes = Base64Utils.decodeFromString(privateKeyString);
        PKCS8EncodedKeySpec pkcs8EncodedKeySpec = new PKCS8EncodedKeySpec(privateKeyBytes);
        KeyFactory keyFactory = KeyFactory.getInstance(ALGORITHM);
        return keyFactory.generatePrivate(pkcs8EncodedKeySpec);
    }


    public static void main(String[] args) throws NoSuchAlgorithmException, IOException, ClassNotFoundException, InvalidKeySpecException {
        KeyPair keyPair = generateKeyPair();
        PublicKey publicKey = keyPair.getPublic();
        PrivateKey privateKey = keyPair.getPrivate();
        String path = "D:\\ApowerREC";
        Wallet wallet = new Wallet(keyPair.getPrivate(), keyPair.getPublic());

        savePrivateKeyToFile(wallet, path);
        path += "\\" + wallet.getWalletAddress() + ".key";
        File file = new File(path);


        PrivateKey fromFileKey = getPrivateKeyFromFile(file);
        if (fromFileKey.equals(privateKey)) {
            System.out.println("文件功能正常");
        }

        String s = privateKeyToString(privateKey);
        System.out.println(s);
        System.out.println(s.length());

        PrivateKey privateKeyString = stringToPrivateKey(s);
        if (privateKeyString.equals(privateKey)) {
            System.out.println("转换功能正常");
        }

        PublicKey publicKey1 = getPublicKeyFromPrivateKey(privateKey);
        if (publicKey1.equals(publicKey1)) {
            System.out.println("私钥生成公钥功能正常");
        }
    }
}
```