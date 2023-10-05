@echo off

set FILE_PATH=temp.txt
set A_PROGRAM=path/to/A.exe
set B_PROGRAM=path/to/B.exe

chcp 65001 > nul

set LOG_FILE=log.txt
for /f "tokens=1-6 delims=/: " %%a in ("%DATE% %TIME%") do (
    set TIMESTAMP=%%b年-%%c月-%%d日-%%a  %%e：%%f
)
echo "branch" not found in the file.
echo [%TIMESTAMP%] 程序出现问题！！！！！！！！！！！ >> %LOG_FILE%
echo FATAL: Something's wrong. Please check the program.
msg * FATAL: Something's wrong. Please check the program.

del temp.txt