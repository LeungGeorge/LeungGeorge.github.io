---
title: php day 2 date and time
tags: writting
categories: PHP
comments: false
date: 2016-09-10 13:21:22

---

# 日期转换为时间戳  
```
<?php

    //日期转换为时间戳
    $strDateTime = '2016-09-10 13:30:01';
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
string(19) "2016-09-10 13:30:01"

``` 
# 日期的加减

```
<?php
    var_dump(date('Y-m-d H:i:s', time()));
    var_dump(date('Y-m-d H:i:s', strtotime("-2 day")));
    var_dump(date('Y-m-d H:i:s', strtotime("+2 day")));
    
    var_dump(date('Y-m-d H:i:s', strtotime("-1 week")));
    var_dump(date('Y-m-d H:i:s', strtotime("+1 week")));
    
    var_dump(date('Y-m-d H:i:s', strtotime("+1 week +1 day +1 hour +1 minute +1 second")));
    
    var_dump(date('Y-m-d H:i:s', strtotime("last month")));
    var_dump(date('Y-m-d H:i:s', strtotime("next month")));
    
    var_dump(date('Y-m-d H:i:s', strtotime("+1 year")));
    var_dump(date('Y-m-d H:i:s', strtotime("next Thursday")));
?>

输出：  
string(19) "2016-09-10 13:42:04"  
string(19) "2016-09-08 13:42:04"  
string(19) "2016-09-12 13:42:04"  
string(19) "2016-09-03 13:42:04"  
string(19) "2016-09-17 13:42:04"  
string(19) "2016-09-18 14:43:05"  
string(19) "2016-08-10 13:42:04"  
string(19) "2016-10-10 13:42:04"  
string(19) "2017-09-10 13:42:04"  
string(19) "2016-09-15 00:00:00"  
```


---
<link rel="stylesheet" href="http://yandex.st/highlightjs/6.1/styles/default.min.css">
<script src="http://yandex.st/highlightjs/6.1/highlight.min.js"></script>
<script>
hljs.tabReplace = ' ';
hljs.initHighlightingOnLoad();
</script>


来源：[http://leunggeorge.github.io/](http://leunggeorge.github.io/)  