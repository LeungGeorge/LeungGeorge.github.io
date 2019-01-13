---
title: starUML破解方法（Windows10 & MAC）
tags:
  - writting
categories:
  - essay
comments: false
date: 2017-11-30 10:00:55
description: 

---


# 破解之路
## Mac版（摘自互联网）
> 原文请查看引用【StarUML 版本破解(MAC版)】

1，打开对应 mac版本的安装包位置，在对应目录js文件

```
/Applications/StarUML.app/Contents/www/license/node/LicenseManagerDomain.js
```

<!--more-->

2，找到文件23行，修改对应下面函数。更改为如下代码：

```
function validate(PK, name, product, licenseKey) {
        var pk, decrypted;
        // edit by 0xcb
        return {
            name: "0xcb",
            product: "StarUML",
            licenseType: "vip",
            quantity: "mergades.com",
            licenseKey: "later equals never!"
        };

        try {
            pk = new NodeRSA(PK);
            decrypted = pk.decrypt(licenseKey, 'utf8');
        } catch (err) {
            return false;
        }
        var terms = decrypted.trim().split("\n");
        if (terms[0] === name && terms[1] === product) {
            return { 
                name: name, 
                product: product, 
                licenseType: terms[2],
                quantity: terms[3],
                licenseKey: licenseKey
            };
        } else {
            return false;
        }
    }
```

我的做法是注释掉原有代码，再增加，防止出现问题。

3，打开starUML。

help>enter license

```
Name:0xcb
licenseKey:later
```
 equals never! 然后提示你注册成功！

> 引用  
> [UML——状态图](https://www.cnblogs.com/sura/archive/2012/07/01/2572083.html)  
> [starUML破解方法（Windows10 & MAC）](http://blog.csdn.net/laojiu_/article/details/52334999)  
> [StarUML 版本破解(MAC版)](http://blog.csdn.net/mergades/article/details/46662413)  
> [App can’t be opened because it is from an unidentified developer](http://osxdaily.com/2012/07/27/app-cant-be-opened-because-it-is-from-an-unidentified-developer/)



---
<link rel="stylesheet" href="http://yandex.st/highlightjs/6.1/styles/default.min.css">
<script src="http://yandex.st/highlightjs/6.1/highlight.min.js"></script>
<script>
hljs.tabReplace = ' ';
hljs.initHighlightingOnLoad();
</script>


来源：[http://leunggeorge.github.io/](http://leunggeorge.github.io/)  
