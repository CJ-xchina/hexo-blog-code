::chcp 65001 设置编码，防止中文乱码
::最后加入 pause 可显示窗口用于排查问题，可删除
chcp 65001

rem ----延时执行----
@echo off
f:
rem ----延时执行----
ping -n 5 127.0.0. 1> nul

rem ----邮件主题----
set s="Hexo 笔记上传出错"
rem ----邮件内容-----

set body="Hexo upload failed"
rem ----收件邮箱-----
set t=cuijiexiang23@mails.ucas.ac.cn
rem ----发件邮箱-----
set f=13107143299@163.com
rem ----邮箱秘钥-----
set pw=KXQPCRAIVTLEGSMZ
rem ----执行发送-----

blat -body %body% -s %s% -t %t% -charset Gb2312 -server smtp.163.com -f %f% -u %f% -pw %pw% -attach temp.txt
::pause