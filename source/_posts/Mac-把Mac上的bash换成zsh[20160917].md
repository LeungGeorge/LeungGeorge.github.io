---
title: Mac-把Mac上的bash换成zsh
tags: writting
categories: essay
comments: false
date: 2016-09-17 20:10:10

---

1. 下载.oh-my-zsh配置  

```
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
```
2. 创建新配置
NOTE:如果有~/.zshrc，那就先备份下。 
 
```
cp ~/.zshrc ~/.zshrc.orig
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
```
3. 把zsh设置为默认的shell
 
```
chsh -s /bin/zsh
```
4. 重启zsh（打开一个新的terminal窗口）








---
<link rel="stylesheet" href="http://yandex.st/highlightjs/6.1/styles/default.min.css">
<script src="http://yandex.st/highlightjs/6.1/highlight.min.js"></script>
<script>
hljs.tabReplace = ' ';
hljs.initHighlightingOnLoad();
</script>


来源：[http://leunggeorge.github.io/](http://leunggeorge.github.io/)  