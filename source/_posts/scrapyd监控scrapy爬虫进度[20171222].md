---
title: scrapyd监控scrapy爬虫进度
tags:
  - writting
categories:
  - essay
comments: false
date: 2017-12-22 23:30:33
description:

---
# 准备工作
## 安装scrapyd
```
pip install scrapyd
```

## 安装scrapyd-client
```
pip install scrapyd-client
```


# 运行scrapyd服务

```
scrapyd
```

Spider进度查看地址：http://localhost:6800/

<!--more-->

![image](yh31_jobs.png)


# 部署scrapy项目
## 部署scrapy项目（修改Spider之后需要重新部署哦）
修改scrapy.cfg文件

``` 
[deploy] section see:

[settings]
default = demo.settings

[deploy:demo_deploy]
url = http://localhost:6800/
project = demo

```

直接在项目demo的根目录路运行部署命令：

```
➜  demo git:(master) ✗ scrapyd-deploy demo_deploy -p demo
Packing version 1513956720
Deploying to project "demo" in http://localhost:6800/addversion.json
Server response (200):
{"status": "ok", "project": "demo", "version": "1513956720", "spiders": 2, "node_name": "MacBook-Pro-4.local"}
```


## 添加Spider到任务队列

查看已有爬虫：

```
➜  demo git:(master) scrapy list
demo4399pk
yh31
```

添加Spider到任务队列：

```
curl http://localhost:6800/schedule.json -d project=demo -d spider=yh31
```




---
<link rel="stylesheet" href="http://yandex.st/highlightjs/6.1/styles/default.min.css">
<script src="http://yandex.st/highlightjs/6.1/highlight.min.js"></script>
<script>
hljs.tabReplace = ' ';
hljs.initHighlightingOnLoad();
</script>


来源：[http://leunggeorge.github.io/](http://leunggeorge.github.io/)  
