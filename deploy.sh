#!/bin/bash

gitbook build
cd _book
git add -A
git commit -m 'deploy...'
git push
