---
uuid: e316f0b2-31d4-11e9-b40e-e5de14f70114
title: linux-shell-find
tags:
  - writting
  - shell
categories:
  - linux
  - shell
comments: false
date: 2017-12-28 11:59:00
description:
---
find命令是通过文件属性查找文件的。所以，find表达式的tests都是文件的属性条件，比如文件的各种时间，文件权限等。

很多参数中会出现指定一个数字n，一般会出现三种写法：  
+n：表示大于n。  
-n：表示小于n。  
n：表示等于n。


<!--more-->

## 参数详解


```

-name   filename             #查找名为filename的文件

-perm                        #按执行权限来查找

-user    username             #按文件属主来查找

-group   groupname            #按组来查找

-mtime   -n +n                #按文件更改时间来查找文件，-n指n天以内，+n指n天以前

-atime    -n +n               #按文件访问时间来查GIN: 0px">

-ctime    -n +n              #按文件创建时间来查找文件，-n指n天以内，+n指n天以前

-nogroup                     #查无有效属组的文件，即文件的属组在/etc/groups中不存在

-nouser                     #查无有效属主的文件，即文件的属主在/etc/passwd中不存

-newer   f1 !f2              找文件，-n指n天以内，+n指n天以前 

-ctime    -n +n               #按文件创建时间来查找文件，-n指n天以内，+n指n天以前 

-nogroup                     #查无有效属组的文件，即文件的属组在/etc/groups中不存在

-nouser                      #查无有效属主的文件，即文件的属主在/etc/passwd中不存

-newer   f1 !f2               #查更改时间比f1新但比f2旧的文件

-type    b/d/c/p/l/f         #查是块设备、目录、字符设备、管道、符号链接、普通文件

-size      n[c]               #查长度为n块[或n字节]的文件

-depth                       #使查找在进入子目录前先行查找完本目录

-fstype                     #查更改时间比f1新但比f2旧的文件

-type    b/d/c/p/l/f         #查是块设备、目录、字符设备、管道、符号链接、普通文件

-size      n[c]               #查长度为n块[或n字节]的文件

-depth                       #使查找在进入子目录前先行查找完本目录

-fstype                      #查位于某一类型文件系统中的文件，这些文件系统类型通常可 在/etc/fstab中找到

-mount                       #查文件时不跨越文件系统mount点

-follow                      #如果遇到符号链接文件，就跟踪链接所指的文件

-cpio                %;      #查位于某一类型文件系统中的文件，这些文件系统类型通常可 在/etc/fstab中找到

-mount                       #查文件时不跨越文件系统mount点

-follow                      #如果遇到符号链接文件，就跟踪链接所指的文件

-cpio                        #对匹配的文件使用cpio命令，将他们备份到磁带设备中

-prune                       #忽略某个目录

```

## 举个栗子
### 按照修改时间查找文件
其他时间参数用法（如ctime、mmin等）与此类似，
#### mtime
 
```
find . –mtime n中的n指的是24*n，-n、n、+n分别表示：  
-n: 小于n  
n: 等于n  
+n: 大于n 
```

|命令|功能|备注|
|-|-|-|
|find . -mtime -n|查询n天内修改的文件|最后一次修改发生在n天以内，距离当前时间为n\*24小时以内|
|find . -mtime n|最近n天修改的文件|最后一次修改发生在距离当前时间n\*24小时至(n+1)\*24 小时|
|find . -mtime +n|查询n+1天前修改的文件|最后一次修改发生在n+1天以前，距离当前时间为(n+1)\*24小时或者更早|
|-|-|-|


### 按照大小查找文件
 
```
find . -size n[cwbkMG]：指定文件长度查找文件。  
单位选择位：  
c：字节单位。  
b：块为单位，块大小为512字节，这个是默认单位。  
w：以words为单位，words表示两个字节。  
k：以1024字节为单位。  
M：以1048576字节为单位。  
G：以1073741824字节温单位。 
```

|命令|功能|备注|
|-|-|-|
|find . -size -nk|查询小于nk的文件|-|
|find . -size nk|查询等于nk的文件|-|
|find . -size +nk|查询大于nk的文件|-|
|-|-|-|





> 引用  
> [shell中find常见用法](https://my.oschina.net/u/1186928/blog/810092)  
> [find命令详解](http://liwei.life/2016/07/11/find%E5%91%BD%E4%BB%A4%E8%AF%A6%E8%A7%A3/)

---
<link rel="stylesheet" href="http://yandex.st/highlightjs/6.1/styles/default.min.css">
<script src="http://yandex.st/highlightjs/6.1/highlight.min.js"></script>
<script>
hljs.tabReplace = ' ';
hljs.initHighlightingOnLoad();
</script>


来源：[http://leunggeorge.github.io/](http://leunggeorge.github.io/)  
