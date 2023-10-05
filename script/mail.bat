@echo off
:::::::::::::: 参数设置::::::::::::::
set from=1484895345@qq.com
set user=cuijiexiang
set pass=cuijiexiang0723
set to=cuijiexiang23@mails.ucas.ac.cn
set subj=测试
set mail=body.txt
set attach=*.jpg
set server=smtp.qq.com
set debug=-debug -log blat.log -timestamp
::::::::::::::::: 运行blat :::::::::::::::::
blat %mail% -to %to% -base64 -charset Gb2312 -subject %subj% -attach %attach% -server %server% -f %from% -u %user% -pw %pass% ％ｄｅｂｅｇ％（此处的％ｄｅｂｅｇ％因为博客显示异常，使用了全角）
—