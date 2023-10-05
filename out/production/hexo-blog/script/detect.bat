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

echo To: 1484895345@qq.com > email.txt
echo Subject: Test Email >> email.txt
echo. >> email.txt
echo 我是崔杰翔 >> email.txt
powershell -ExecutionPolicy ByPass -command "Send-MailMessage -To '1484895345@qq.com' -From 'cuijiexiang23@mails.ucas.ac.cn' -Subject 'Test Email' -Body (Get-Content email.txt | Out-String) -SmtpServer 'mail.cstnet.cn'"
del email.txt