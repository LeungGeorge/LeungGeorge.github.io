#!/bin/bash
git pull

hexo clean
hexo g
hexo d

cp baidu-verify-F90255460A.txt ./public/

#hexo algolia

git add --all
git commit -m "auto commit"
git push origin hexo

git pull

