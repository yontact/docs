#!/bin/bash
#
export PATH=/Applications/calibre.app/Contents/MacOS:$PATH
gitbook pdf

gitbook build
cd _book
rm deploy.sh gendocx.* .gitignore
cp ../book.pdf download/mate/云镜说明书-完整版.pdf
cd ..
mkdir -p _publish
rsync -avz _book/ _publish/

cd _publish
git remote -v #FIXME: 会获取到上级的git，所以总是返回成功
status=$?
if [[ status -ne 0 ]]; then
  git init
  git remote add origin git@git.coding.net:chenweiyj/yontact-gitbook.git
fi

git branch --set-upstream-to=origin/master master
git pull
git add -A
git commit -m 'deploy...'
git push -u origin master

# 将 markdown 源文件提交
git pull
git add -A
git commit -m "update document $1"
git push -u origin master
