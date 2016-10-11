#!/bin/bash
#
# export PATH=/Applications/calibre.app/Contents/MacOS:$PATH
# gitbook pdf

gitbook build
cd _book
rm deploy.sh gendocx.* .gitignore
cp ../book.pdf download/mate/云镜说明书-完整版.pdf
cd ..
mkdir -p _publish
mv _book/* _publish/

git remote -v
status=$?
if [[ status -ne 0 ]]; then
  git init
  git remote add origin git@git.coding.net:chenweiyj/yontact-gitbook.git
fi

git add -A
git commit -m 'deploy...'
git push -u origin master


