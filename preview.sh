#!/bin/bash

cp -r source/_posts/local.assets/ source/local.assets/

hexo clean
# hexo generate
hexo g
# hexo server --debug --draft
hexo s --debug
