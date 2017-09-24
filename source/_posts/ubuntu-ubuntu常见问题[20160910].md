---
title: ubuntu常见问题
tags: 
  - ubuntu
  - 文件
  - 音乐播放器
  - PHP开发环境
categories: 
  - ubuntu
comments: false
date: 2016-09-10 13:13:33
description: ubuntu常见问题

---

# 文件操作 
1.修改文件名：mv old.txt new.txt
# 音乐播放器乱码 
这是因为phthon-mutagen没有安装 
安装 sudo apt-get install python -mutagen ，然后到音乐文件夹 修改编码 mid3iconv -e utf-8 *.mp3 或者 mid3iconv -e GBK *.mp3

# PHP开发环环境搭建
[Eclipse for php + Xdebug搭建PHP的调试环境](http://blog.csdn.net/zztfj/article/details/18750295)

# ubuntu 14.04 使用极点五笔输入法

相比12.04在外观改变不是很大，但其中细节有些许变化，特别输入法很不大好用，为此，我们使用fcitx输入法，使用我喜欢的五笔拼音，安装过程如下：

方法一：

最新的方法很简单：

安装14.04后，语言包一定要安装完整，从ibus加入极点五笔。

方法二：

快捷键“ctrl+AIt+T",弹出终端，输入以下指令

```
//先卸载IBUS输入法
killall ibus-daemon
sudo apt-  get  purge ibus ibus-gtk ibus-gtk3 ibus-pinyin* ibus-sunpinyin ibus-table python-ibus
rm -rf ~/.config/ibus
//安装fcitx输入法
sudo add-apt-repository ppa:fcitx-team/nightly
sudo apt-  get  update
sudo apt-  get  install fcitx-sogoupinyin
```
其它输入法的名称如下

```
//拼音：
fcitx-pinyin、fcitx-sunpinyin、fcitx-googlepinyin，
//五笔：
fcitx-table、fcitx-table-wubi、fcitx-table-wbpy（五笔拼音混合）
```

# 安装搜狗输入法 
http://jingyan.baidu.com/article/ad310e80ae6d971849f49ed3.html 

1.到官方网站下载搜狗输入法 

2.下载安装后，在终端输入 im-config,打开配置页面，这时会出现一个窗口点击ok，这是又出现一个窗口点击yes，这时又出现一个窗口选择 fcitx，然后一路ok yes下去，重启电脑   

---
<link rel="stylesheet" href="http://yandex.st/highlightjs/6.1/styles/default.min.css">
<script src="http://yandex.st/highlightjs/6.1/highlight.min.js"></script>
<script>
hljs.tabReplace = ' ';
hljs.initHighlightingOnLoad();
</script>


来源：[http://leunggeorge.github.io/](http://leunggeorge.github.io/)  