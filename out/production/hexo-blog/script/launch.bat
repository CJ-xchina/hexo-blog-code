@echo off

chcp 65001 > nul

set LOG_FILE=log.txt
for /f "tokens=1-6 delims=/: " %%a in ("%DATE% %TIME%") do (
    set TIMESTAMP=%%b年-%%c月-%%d日-%%a  %%e：%%f
)
call upload_code.bat
echo [%TIMESTAMP%] 批处理程序开始执行 >> %LOG_FILE%
(hexo algolia && hexo clean && hexo g -d) > temp.txt || call detect.bat

