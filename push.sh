#!/bin/bash

# cd current
# cd /Users/yuanzhengliang/home/go/src/github.com/LeungGeorge/LeungGeorge.github.io

# cp -r source/_posts/local.assets/ source/local.assets/
# cp -r source/_posts/assets/ source/assets/

git status

/usr/local/lib/node_modules/hexo/bin/hexo clean
/usr/local/lib/node_modules/hexo/bin/hexo g
/usr/local/lib/node_modules/hexo/bin/hexo d

# hexo algolia

git add --all
git commit -m "by 七点一刻"
git pull

git push origin hexo
