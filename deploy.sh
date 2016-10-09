#!/bin/bash
#
export PATH=/Applications/calibre.app/Contents/MacOS:$PATH
gitbook pdf

gitbook build
cd _book
rm deploy.sh gendocx.* .gitignore
cp ../book.pdf 云镜说明书-完整版.pdf
git init
git remote add origin git@git.coding.net:chenweiyj/yontact-gitbook.git
git add -A
git commit -m 'deploy...'
git push -f -u origin master


