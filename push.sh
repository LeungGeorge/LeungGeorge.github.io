#!/bin/bash
git pull

hexo g
hexo d

git add --all
git commit -m "auto commit"
git push origin hexo

git pull

