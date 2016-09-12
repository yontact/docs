#!/bin/bash

gitbook build
cd _book
git init
git remote add origin git@git.coding.net:chenweiyj/yontact-gitbook.git
git add -A
git commit -m 'deploy...'
git push -f -u origin master
cd ..
