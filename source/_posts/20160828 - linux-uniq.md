---
title: linux-uniq
tags: 
  - uniq
  - shell
date: 2016-08-28 21:51:19
categories: 
  - linux
  - ubuntu
description: uniq

---

# uniq
1. uniq -c

2. uniq -w 5 -c

3. uniq -ic

## read me

```
-c, --count
prefix lines by the number of occurrences（列出值出现次数）
-d, --repeated
only print duplicate lines（仅打印重复值，一个值一次）
-D, --all-repeated[=delimit-method] print all duplicate lines
delimit-method={none(default),prepend,separate} Delimiting is done with blank lines.（打印所有重复的值，一个值多次）
-f, --skip-fields=N
avoid comparing the first N fields（不比较前N个fields，空格分割）
-i, --ignore-case
ignore differences in case when comparing（忽略大小写）
-s, --skip-chars=N
avoid comparing the first N characters（跳过前N个字符）
-u, --unique
only print unique lines（仅打印不重复的值）
-w, --check-chars=N
compare no more than N characters in lines（最多比较前N个字符）
```




---
<link rel="stylesheet" href="http://yandex.st/highlightjs/6.1/styles/default.min.css">
<script src="http://yandex.st/highlightjs/6.1/highlight.min.js"></script>
<script>
hljs.tabReplace = ' ';
hljs.initHighlightingOnLoad();
</script>


来源：[http://leunggeorge.github.io/](http://leunggeorge.github.io/)  