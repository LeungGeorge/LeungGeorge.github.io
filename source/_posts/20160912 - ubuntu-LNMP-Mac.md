---
uuid: e316c9a5-31d4-11e9-b40e-e5de14f70114
title: ubuntu LNMP Mac
tags:
  - lnmp
  - linux
  - nginx
  - mysql
  - php
categories:
  - linux
comments: true
date: 2016-09-12 21:14:24
description: ubuntu LNMP Mac
share: "true"
---

# 安装 homebrew

# 安装 Nginx

安装

```
brew search nginx
brew install nginx
```

启动、关闭 nginx

```
nginx -s reload|reopen|stop|quit
```

配置

```
cd /usr/local/etc/nginx/
mkdir conf.d
vim nginx.conf
vim ./conf.d/default.conf
```

nginx.conf 内容

```
worker_processes  1;

error_log  /usr/local/var/log/nginx/error.log  warn;

pid /usr/local/var/run/nginx.pid;


events {
    #worker_connections  1024;
    worker_connections  256;
}

http {
    include       mime.types;
    default_type  application/octet-stream;

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';


    access_log  /usr/local/var/log/nginx/access.log  main;

    port_in_redirect off;
    sendfile        on;
    keepalive_timeout  65;
    include /usr/local/etc/nginx/conf.d/*.conf;
    include servers/*;
}


```

default.conf 文件内容

```
server {
    listen       80;
    server_name  localhost;
    # root /usr/local/var/www/

    # /usr/local/var/www/
    # root /Users/username/Sites/; # 该项要修改为你准备存放相关网页的路径
    root /usr/local/var/; # 该项要修改为你准备存放相关网页的路径

    location / {
        index index.php;
        autoindex on;
    }

    #proxy the php scripts to php-fpm
    location ~ \.php$ {
        include /usr/local/etc/nginx/fastcgi.conf;
        fastcgi_intercept_errors on;
        fastcgi_pass   127.0.0.1:9000;
        include     fastcgi_params;
    }

}
```

# 安装 MYSQL

# 测试

Nginx 配置文件 root 对应目录下新建 index.php

```
<?
	phpinfo();
?>
```

# 安装 php

# 参考资料

[Mac 下安装 LNMP(Nginx+PHP5.6)环境](http://www.tuicool.com/articles/2yM7Z3)
[Mac OSX 10.9 搭建 nginx+mysql+php-fpm 环境](http://my.oschina.net/chen0dgax/blog/190161)

---

来源：[http://leunggeorge.github.io/](http://leunggeorge.github.io/)
