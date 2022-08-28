#!/bin/bash

hexo clean
hexo g
hexo d

# hexo algolia

git add --all
git commit -m "by 七点一刻"
git pull

git push origin hexo
