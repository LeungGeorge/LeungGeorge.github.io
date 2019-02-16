---
uuid: e316c9ab-31d4-11e9-b40e-e5de14f70114
title: php.ini修改php上传文件大小限制
tags:
  - writting
categories:
  - essay
comments: false
description: 修改php上传文件大小限制
date: 2017-07-13 11:18:52
---

打开php.ini，首先找到  
file_uploads = on ;是否允许通过HTTP上传文件的开关。默认为ON即是开  
upload_tmp_dir ;文件上传至服务器上存储临时文件的地方，如果没指定就会用系统默认的临时文件夹  
upload_max_filesize = 8m ;望文生意，即允许上传文件大小的最大值。默认为2M  
post_max_size = 8m ;指通过表单POST给PHP的所能接收的最大值，包括表单里的所有值。默认为8M  

一般地，设置好上述四个参数后，上传<=8M的文件是不成问题，在网络正常的情况下。  
但如果要上传>8M的大体积文件，只设置上述四项还一定能行的通。  

进一步配置以下的参数  
max_execution_time = 600 ;每个PHP页面运行的最大时间值(秒)，默认30秒  
max_input_time = 600 ;每个PHP页面接收数据所需的最大时间，默认60秒  
memory_limit = 8m ;每个PHP页面所吃掉的最大内存，默认8M  
把上述参数修改后，在网络所允许的正常情况下，就可以上传大体积文件了  
max_execution_time = 600  
max_input_time = 600  
memory_limit = 32m  
file_uploads = on  
upload_tmp_dir = /tmp  
upload_max_filesize = 32m  
post_max_size = 32m  



引用地址：  
[文章1](http://www.phpchina.com/blog-52440-181965.html)





---
<link rel="stylesheet" href="http://yandex.st/highlightjs/6.1/styles/default.min.css">
<script src="http://yandex.st/highlightjs/6.1/highlight.min.js"></script>
<script>
hljs.tabReplace = ' ';
hljs.initHighlightingOnLoad();
</script>


来源：[http://leunggeorge.github.io/](http://leunggeorge.github.io/)  
