@echo off
chcp 65001 > nul 2>&1
cd /d D:\MY_FILES\Project\hexo-blog

set max_attempts=3
set attempt=0

echo %date:/=-% %time% - Starting execution

if not exist log.txt (
    echo Creating log.txt...
    echo %date:/=-% %time% - Starting execution > log.txt
) else (
    echo Log file exists. Appending data...
    echo. >> log.txt
    echo %date:/=-% %time% - Starting execution >> log.txt
)

:upload
set /a attempt+=1

echo Attempt %attempt% of %max_attempts%
echo %date:/=-% %time% - Attempt %attempt% of %max_attempts% >> log.txt

hexo algolia && hexo clean && hexo g && hexo d
if errorlevel 1 (
    if %attempt% lss %max_attempts% (
        echo Upload failed. Retrying...
        echo %date:/=-% %time% - Upload failed. Retrying... >> log.txt
        goto upload
    ) else (
        echo Upload failed after %max_attempts% attempts. Exiting...
        echo %date:/=-% %time% - Upload failed after %max_attempts% attempts. Exiting... >> log.txt
        pause
    )
)

echo Upload successful.
echo %date:/=-% %time% - Upload successful >> log.txt

pause