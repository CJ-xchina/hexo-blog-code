@echo off
setlocal enabledelayedexpansion

set "str="

rem 输出数据到控制台
echo line 1
echo line 2
echo line 3

rem 读取输出并累加到str变量
for /F "delims=" %%i in ('echo line 1^&echo line 2^&echo line 3') do (
  set "str=!str!%%i"
  rem 在str的末尾添加换行符
  echo.>>tempfile.tmp
)

rem 将tempfile.tmp中的内容追加到str变量
for /F "delims=" %%j in (tempfile.tmp) do (
  set "str=!str!%%j"
)

rem 删除临时文件
del tempfile.tmp

rem 输出带有换行符的str变量
echo !str!
