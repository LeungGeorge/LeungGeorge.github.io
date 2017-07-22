#!/bin/bash
cp baidu-verify-F90255460A.txt ./public/
git pull

hexo clean
hexo g
hexo d

git add --all
git commit -m "auto commit"
git push origin hexo

git pull

