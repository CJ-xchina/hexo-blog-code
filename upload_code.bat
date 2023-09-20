@echo off

setlocal

REM 设置变量
set REPO_OWNER=CJ-xchina
set REPO_NAME=hexo-blog-code
set COMMIT_MESSAGE=Initial commit

REM 初始化仓库
echo Initializing repository...
git init

REM 添加文件到暂存区
echo Adding files to staging area...
git add .

REM 提交到本地仓库
echo Committing changes to local repository...
git commit -m "%COMMIT_MESSAGE%"

REM 添加远程仓库
echo Adding remote repository...
git remote add origin https://github.com/CJ-xchina/hexo-blog-code.git

REM 推送到GitHub
echo Pushing changes to GitHub...
git push -u origin master

REM 清理临时文件
echo Cleaning up...
git remote remove origin
git reset

echo Done!
pause