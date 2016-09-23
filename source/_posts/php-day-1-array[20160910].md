---
title: php day 1 array  
tags: writting  
categories: PHP  
comments: false  
date: 2016-09-10 11:18:22  

---
# array_shift用法 
array_shift-将数组开头的单元移出数组。

说明：  
mixed array_shift( array &array)

array_shift()将数组array的第一个单元移除并作为结果返回，array的长度减1，其他单元向前移动1位，所有的数字键名将改为从0开始计数，文字键名不变。array为空（或非数组时）返回null

```
<?php
    $stack = array("orange", "banana", "apple", "raspberry");
    $fruit = array_shift($stack);
    print_r($stack);
?>

输出：
Array
(
    [0] => banana
    [1] => apple
    [2] => raspberry
)

```  

# array交集
## array_intersect_assoc
原型：array array_intersect_assoc ( array array1, array array2 [, array ...] )   
array_intersect_assoc()，带索引检查计算数组的交集。要求<键名,键值>完全一致。

```
<?php

// 求数组交集, key 也用于比较
$array1 = array("a" => "green", "b" => "brown", "c" => "blue", "red");
$array2 = array("a" => "green", "yellow", "red");
$result_array = array_intersect_assoc($array1, $array2);

var_dump($result_array);

?>

输出：
array(1) {
  ["a"]=>
  string(5) "green"
}
```

## array_intersect
原型：array array_intersect ( array array1, array array2 [, array ...] )  
array_intersect()返回一个数组，该数组包含了所有在array1中同时也在其他所有数组中的值。键名保留不变。

```
<?php

// 求数组交集, key 也用于比较
$array1 = array("a" => "green", "b" => "brown", "c" => "blue", "red");
$array2 = array("a" => "green", "yellow", "red");
$result_array = array_intersect($array1, $array2);

var_dump($result_array);

?>

输出：
array(2) {
  ["a"]=>
  string(5) "green"
  [0]=>
  string(3) "red"
}
```






---
<link rel="stylesheet" href="http://yandex.st/highlightjs/6.1/styles/default.min.css">
<script src="http://yandex.st/highlightjs/6.1/highlight.min.js"></script>
<script>
hljs.tabReplace = ' ';
hljs.initHighlightingOnLoad();
</script>


来源：[http://leunggeorge.github.io/](http://leunggeorge.github.io/)  