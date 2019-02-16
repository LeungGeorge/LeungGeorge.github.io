---
uuid: e316c9ac-31d4-11e9-b40e-e5de14f70114
title: python scrapy框架
tags:
  - 爬虫
  - Python
  - scrapy
categories:
  - Python
  - scrapy
comments: false
date: 2017-07-21 23:59:15
description: 本文主要介绍了scrapy框架的使用，并给出了scrapy框架的安装教程（官方指南）。 
 
---

# 安装

[Scrapy 安装教程](http://scrapy-chs.readthedocs.io/zh_CN/latest/intro/install.html)

# 使用
## 创建新项目
创造一个项目：  

```
scrapy startproject tutorial
```
目录层级结构如图：  

```
tutorial 
  scrapy.cfg          # 项目的配置文件
  tutorial            # 项目的python模块, 在这里稍后你将会导入你的代码
    __init__.py       
    items.py          # 项目items文件
    middlewares.py    # 项目中间件文件
    pipelines.py      # 项目管道文件
    settings.py       # 项目配置文件
    spiders           # 你的spider目录
      __init__.py     
```

### 定义抓取项
定义我们要抓取的内容（items.py）： 

```
import scrapy

class TutorialItem(scrapy.Item):
    # define the fields for your item here like:
    # name = scrapy.Field()
    pass

class JianShuItem(scrapy.Item):
    # define the fields for your item here like:
    title = scrapy.Field()
    content = scrapy.Field()    
```
### 创建Spider
创建命令：

```
scrapy genspider -t basic jianshu jianshu.com
```

修改Spider内容为：

```
import scrapy

class CrawlSpider(scrapy.Spider):
    name = 'crawl'
    allowed_domains = ['JianShu']
    start_urls = ['http://JianShu/']

    def parse(self, response):
        pass
```

### 保存数据

```
scrapy crawl JianShuSpider  -o items.json -t json
```

# 错误处理
## [scrapy.core.engine] DEBUG: Crawled (403) <GET http://www.jianshu.com/> (referer: None)
修改DOWNLOADER_MIDDLEWARES配置：

```
DOWNLOADER_MIDDLEWARES = {
    'scrapy.contrib.downloadermiddleware.useragent.UserAgentMiddleware' : None,#必需 ,禁用默认的middleware
}
```

## [scrapy.core.scraper] ERROR: Spider error processing <GET http://www.jianshu.com/> (referer: None)
修改DOWNLOADER_MIDDLEWARES配置：

```
DOWNLOADER_MIDDLEWARES = {
    'scrapy.contrib.downloadermiddleware.useragent.UserAgentMiddleware' : None,#必需 ,禁用默认的middleware
    'jianshu.middlewares.JianshuSpiderMiddleware': 543,
}
```

修改middlewares.py配置：

```
from scrapy.downloadermiddlewares.useragent import UserAgentMiddleware

class JianShuSpiderAgent(UserAgentMiddleware):
    def __init__(self,user_agent=''):
        self.user_agent = user_agent

    def process_request(self,request,spider):
        request.headers.setdefault('Host','www.jianshu.com')
        request.headers.setdefault('User-Agent','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/53.0.2785.143 Chrome/53.0.2785.143 Safari/537.36')

}
```




> 参考资料
> [西刺免费代理IP](http://www.xicidaili.com/)  
> [scrapy代理、UA配置](http://www.cnblogs.com/rwxwsblog/p/4575894.html?utm_source=tuicool&utm_medium=referral)  
> [Scrapy环境搭建](http://agroup.baidu.com/media/md/article/78144)  
> [数据抓取框架](http://agroup.baidu.com/searchwar/md/article/155920)  
> [Scrapy下载中间件](http://www.jianshu.com/p/1352fb39bd94)  
> [scrapy自定义User-Agent](http://www.jianshu.com/p/0f39f9ca37d5)  
> [如何让你的scrapy爬虫不再被ban](http://www.cnblogs.com/rwxwsblog/p/4575894.html?utm_source=tuicool&utm_medium=referral)  
> [CnblogsSpider](https://github.com/jackgitgz/CnblogsSpider/blob/master/cnblogs/settings.py)

---
<link rel="stylesheet" href="http://yandex.st/highlightjs/6.1/styles/default.min.css">
<script src="http://yandex.st/highlightjs/6.1/highlight.min.js"></script>
<script>
hljs.tabReplace = ' ';
hljs.initHighlightingOnLoad();
</script>


来源：[http://leunggeorge.github.io/](http://leunggeorge.github.io/)  
