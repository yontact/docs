#!/bin/bash

gitbook build
cd _book
rm deploy.sh gendocx.*
git init
git remote add origin git@git.coding.net:chenweiyj/yontact-gitbook.git
git add -A
git commit -m 'deploy...'
git push -f -u origin master
cd ..

export PATH=/Applications/calibre.app/Contents/MacOS:$PATH
gitbook pdf
