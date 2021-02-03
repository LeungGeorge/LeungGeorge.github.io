#!/bin/bash

hexo clean
hexo g
hexo d

# hexo algolia

git add --all
git commit -m "auto commit"
git pull

git push origin hexo
