---
title: php day 2 date and time
tags: 写作
categories: 随笔
comments: false
date: 2016-09-10 13:21:22

---

# 日期转换为时间戳
```
<?php
    //日期转换为时间戳
    $strDateTime = '2016-09-10 12:01:01';
    $intTime = strtotime($strDateTime);
    var_dump(intval($intTime));
?>

输出：
int(1473480061)

``` 

# 时间戳转换为日期
```
<?php
    //时间戳转换为日期
    $intTime = time();
    $strDateTime = date('Y-m-d H:i:s', $intTime);
    var_dump($strDateTime);
?>

输出：
string(19) "2016-09-10 12:01:01"

``` 

# 日期的加减







---
<link rel="stylesheet" href="http://yandex.st/highlightjs/6.1/styles/default.min.css">
<script src="http://yandex.st/highlightjs/6.1/highlight.min.js"></script>
<script>
hljs.tabReplace = ' ';
hljs.initHighlightingOnLoad();
</script>


来源：[http://leunggeorge.github.io/](http://leunggeorge.github.io/)  