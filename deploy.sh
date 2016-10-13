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
remote=$(git remote -v)
if [[ $remote != *"yontact-gitbook"* ]]; then
  git init
  git remote add origin git@git.coding.net:chenweiyj/yontact-gitbook.git
fi

git branch --set-upstream-to=origin/master master
git pull -u origin master
git add -A
git commit -m 'deploy...'
git push -u origin master

# 将 markdown 源文件提交
cd ..
git pull
git add -A
git commit -m "update document $1"
git push -u origin master
