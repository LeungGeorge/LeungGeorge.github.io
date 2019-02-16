---
uuid: e316c9ae-31d4-11e9-b40e-e5de14f70114
title: linux-crontab 定时任务
tags:
  - writting
categories:
  - essay
comments: false
description: crontab定时任务详解，各种周期的ct任务写法。我们通过创建ct任务（crontab定时任务），可以达到周期运行脚本的目的。时间周期为：分钟、小时、日、月、周的各种组合。
date: 2017-08-08 19:47:47
---
# 说明

我们通过创建ct任务（crontab定时任务），可以达到周期运行脚本的目的。时间周期为：分钟、小时、日、月、周的各种组合。

## 举个栗子
### 每分钟执行一次

```
* * * * * shellCommand
```

### 每小时执行一次

```
0 * * * * shellCommand
```

### 每小时的1,10,20分钟执行一次

```
1,10,20 * * * * shellCommand
```

### 8-11点的1,10,20分钟执行一次

```
1,10,20 8-11 * * * shellCommand
```

### 每隔2天的8-11点的1,10,20分钟执行一次

```
1,10,20 8-11 */2 * * shellCommand
```

### 每隔周一的8-11点的1,10,20分钟执行一次

```
1,10,20 8-11 * * 1 shellCommand
```




---
<link rel="stylesheet" href="http://yandex.st/highlightjs/6.1/styles/default.min.css">
<script src="http://yandex.st/highlightjs/6.1/highlight.min.js"></script>
<script>
hljs.tabReplace = ' ';
hljs.initHighlightingOnLoad();
</script>


来源：[http://leunggeorge.github.io/](http://leunggeorge.github.io/)  
