---
uuid: e316f0b1-31d4-11e9-b40e-e5de14f70114
title: 基于redis实现scrapy分布式爬虫
tags:
  - writing
categories:
  - Python
  - scrapy
comments: false
date: 2017-12-23 17:08:56
description:

---

# 安装redis

## 下载

```shell
wget http://download.redis.io/releases/redis-stable.tar.gz
```

## 安装

```shell
tar -zxvf redis-stable.tar.gz
cd redis-stable
```
<!--more-->

## 运行

```shell
./src/redis-server
./src/redis-cli
```

## 安装scrapy-redis

```shell
pip install scrapy-redis
```

# 新建分布式爬虫

![20190907082159.png](https://raw.githubusercontent.com/LeungGeorge/assets/master/images/20190907082159.png)

## 新建项目

```shell
scrapy startproject distributedspider
```

## 新建redis crawler(mycrawler_redis.py)

```python
import redis
from scrapy.spiders import Rule
from scrapy.linkextractors import LinkExtractor
from scrapy_redis.spiders import RedisCrawlSpider

class MyCrawler(RedisCrawlSpider):
    """Spider that reads urls from redis queue (myspider:start_urls)."""
    name = 'mycrawler_redis'
    redis_key = 'mycrawler:start_urls'
    start_urls = []

    def __init__(self, *args, **kwargs):
        super(MyCrawler, self).__init__(*args, **kwargs)
        # Dynamically define the allowed domains list.
        domain = kwargs.pop('domain', '')
        self.allowed_domains = filter(None, domain.split(','))
        self.start_urls.append('http://joke.4399pk.com/funnyimg/find-cate-2.html')

        r = redis.Redis()
        for pageNum in range(1, 20, 1):
            pageUrl = 'http://joke.4399pk.com/funnyimg/find-cate-2-p-' + str(pageNum) + '.html'
            start_urls_len = r.lpush("myspider:start_urls", pageUrl)
            print 'start_urls_len:' + str(start_urls_len)

```

## 新建redis spider(myspider_redis.py)
```
from scrapy_redis.spiders import RedisSpider

class MySpider(RedisSpider):
    """Spider that reads urls from redis queue (myspider:start_urls)."""
    name = 'myspider_redis'
    redis_key = 'myspider:start_urls'

    def __init__(self, *args, **kwargs):
        # Dynamically define the allowed domains list.
        domain = kwargs.pop('domain', '')
        self.allowed_domains = filter(None, domain.split(','))

        super(MySpider, self).__init__(*args, **kwargs)

    def parse(self, response):
        print 'spider_____________'
        print response.url

        return {
            'name': response.css('title::text').extract_first(),
            'url': response.url,
        }

```

## 修改配置（settings.pyc）
配置redis地址，多机部署时队列读取地址。

```

DUPEFILTER_CLASS = "scrapy_redis.dupefilter.RFPDupeFilter"
SCHEDULER = "scrapy_redis.scheduler.Scheduler"

ITEM_PIPELINES = {
    'distributedspider.pipelines.DistributedspiderPipeline': 300,
    'scrapy_redis.pipelines.RedisPipeline': 400,
}

REDIS_HOST = '127.0.0.1'
REDIS_PORT = 6379


```

## 运行
### 启动redis

![20190907082348.png](https://raw.githubusercontent.com/LeungGeorge/assets/master/images/20190907082348.png)

### 运行spider1
![20190907082407.png](https://raw.githubusercontent.com/LeungGeorge/assets/master/images/20190907082407.png)

### 运行spider2
![20190907082428.png](https://raw.githubusercontent.com/LeungGeorge/assets/master/images/20190907082428.png)

### 添加start_urls
方式一（手动添加）：
![20190907082458.png](https://raw.githubusercontent.com/LeungGeorge/assets/master/images/20190907082458.png)

方式二（执行脚本添加）：

```
scrapy crawl mycrawler_redis
```

### 结论
可以看到spider1、spider2在并行处理请求

![20190907082524.png](https://raw.githubusercontent.com/LeungGeorge/assets/master/images/20190907082524.png)

![20190907082541.png](https://raw.githubusercontent.com/LeungGeorge/assets/master/images/20190907082541.png)

---
<link rel="stylesheet" href="http://yandex.st/highlightjs/6.1/styles/default.min.css">
<script src="http://yandex.st/highlightjs/6.1/highlight.min.js"></script>
<script>
hljs.tabReplace = ' ';
hljs.initHighlightingOnLoad();
</script>


来源：[http://leunggeorge.github.io/](http://leunggeorge.github.io/)  
