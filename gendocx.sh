#!/bin/bash

node gendocx.js
cd _docx
pandoc -o book.docx -f markdown -t docx book.md
