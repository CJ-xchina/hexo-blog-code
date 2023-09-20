@echo off
chcp 65001 > nul 2>&1
cd /d D:\MY_FILES\Project\hexo-blog

echo %date:/=-% %time% - Starting execution

if not exist log.txt (
  echo Creating log.txt...
  echo %date:/=-% %time% - Starting execution > log.txt
) else (
  echo Log file exists. Appending data...
  echo. >> log.txt
  echo %date:/=-% %time% - Starting execution >> log.txt
)

hexo algolia && hexo clean && hexo g -d > temp.txt
findstr /C:"To github.com:CJ-xchina/CJ-xchina.github.io.git" temp.txt > nul
if %errorlevel% equ 0 {
  echo Upload successful.
  echo %date:/=-% %time% - Upload successful >> log.txt
}
else(
  echo Upload failed.
  echo %date:/=-% %time% - Upload failed >> log.txt
  echo Failed to upload to github.com:CJ-xchina/CJ-xchina.github.io.git. Reason: Upload unsuccessful. >> log.txt
)

del temp.txt