---
uuid: 2f711cc0-f3d0-11e9-b7dd-6f88ead869a3
title: SELECT COUNT 那些事儿
tags:
  - mysql
  - select count
categories:
  - mysql
comments: true
date: 2019-10-20 14:58:28
description: 关于 SELECT COUNT 那些事儿，这篇博客总结的很好，感谢博主。COUNT(column), COUNT(*), COUNT(1)。
---

<!--more-->

```html
1、COUNT有几种用法？
2、COUNT(字段名)和COUNT(*)的查询结果有什么不同？
3、COUNT(1)和COUNT(*)之间有什么不同？
4、COUNT(1)和COUNT(*)之间的效率哪个更高？
5、为什么《阿里巴巴Java开发手册》建议使用COUNT(*)
6、MySQL的MyISAM引擎对COUNT(*)做了哪些优化？
7、MySQL的InnoDB引擎对COUNT(*)做了哪些优化？
8、上面提到的MySQL对COUNT(*)做的优化，有一个关键的前提是什么？
9、SELECT COUNT(*) 的时候，加不加where条件有差别吗？
10、COUNT(*)、COUNT(1)和COUNT(字段名)的执行过程是怎样的？
```
<!-- 
## COUNT有几种用法?

> COUNT(column), COUNT(*), COUNT(1)

## COUNT(字段名)和COUNT(*)的查询结果有什么不同？

返回结果可能不同：  
COUNT(字段名) 会过滤掉为 NULL 的值。  
COUNT(*)返回行数。  
![20191021151939.png](/images/20191021151939.png)

## COUNT(1)和COUNT(*)之间有什么不同？

没有。

## COUNT(1)和COUNT(*)之间的效率哪个更高？

MySQL官方文档：
> InnoDB handles SELECT COUNT(*) and SELECT COUNT(1) operations in the same way. There is no performance difference.  

画重点：`same way , no performance difference`。所以，对于COUNT(1)和COUNT(*)，MySQL的优化是完全一样的，根本不存在谁比谁快！

## 为什么《阿里巴巴Java开发手册》建议使用COUNT(*)

> COUNT(*)是SQL92定义的标准统计行数的语法，因为他是标准语法，所以MySQL数据库对他进行过很多优化。  

## MySQL的MyISAM引擎对COUNT(*)做了哪些优化？

MyISAM的锁是表级锁，所以同一张表上面的操作需要串行进行，所以，MyISAM做了一个简单的优化，那就是它可以把表的总行数单独记录下来，如果从一张表中使用COUNT(*)进行查询的时候，可以直接返回这个记录下来的数值就可以了，当然，前提是不能有where条件。

## MySQL的InnoDB引擎对COUNT(*)做了哪些优化？

我们知道，COUNT(*)的目的只是为了统计总行数，所以，他根本不关心自己查到的具体值，所以，他如果能够在扫表的过程中，选择一个成本较低的索引进行的话，那就可以大大节省时间。  
InnoDB中索引分为聚簇索引（主键索引）和非聚簇索引（非主键索引），聚簇索引的叶子节点中保存的是整行记录，而非聚簇索引的叶子节点中保存的是该行记录的主键的值。  
所以，相比之下，非聚簇索引要比聚簇索引小很多，所以MySQL会优先选择最小的非聚簇索引来扫表。所以，当我们建表的时候，除了主键索引以外，创建一个非主键索引还是有必要的。

> 至此，我们介绍完了MySQL数据库对于COUNT(*)的优化，这些优化的前提都是查询语句中不包含WHERE以及GROUP BY条件。  

## 上面提到的MySQL对COUNT(*)做的优化，有一个关键的前提是什么？

查询语句中不包含WHERE以及GROUP BY条件

## SELECT COUNT(*) 的时候，加不加where条件有差别吗？

有差别：不带 where 条件，可能被引擎优化。带 where 条件的话，不会被优化。

## COUNT(*)、COUNT(1)和COUNT(字段名)的执行过程是怎样的？

均不带 where 条件。  
1. COUNT(*)
   - MyISAM 引擎，可以直接返回结果。
   - InnoDB 引擎，扫表计算（可能会根据索引做一定优化）。
2. COUNT(1)
   - 与 COUNT(*) 执行过程一致。
3. COUNT(字段名)
   - 扫表，并过滤 NULL 记录。多了一个字段是否为 NULL 的判断，所以他的性能要比 COUNT(*) 慢。 -->


> 完整版参考原文：  
> [不就是SELECT COUNT语句吗](https://juejin.im/post/5dad103a518825579a1f9aaf?utm_source=gold_browser_extension)  



<link rel="stylesheet" href="http://yandex.st/highlightjs/6.1/styles/default.min.css">
<script src="http://yandex.st/highlightjs/6.1/highlight.min.js"></script>
<script>
hljs.tabReplace = ' ';
hljs.initHighlightingOnLoad();
</script>
