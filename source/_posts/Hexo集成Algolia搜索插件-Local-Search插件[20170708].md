---
title: 'Hexo集成Algolia搜索插件,Local Search插件'
tags:
  - hexo
  - algolia
  - search
  
categories: 
  - Hexo
comments: false
date: 2017-07-08 11:30:05
---

# 集成为搜索Local Search
1.安装 hexo-generator-searchdb，在站点的根目录下执行以下命令：

```
npm install hexo-generator-searchdb --save
```

2.编辑 站点配置文件，新增以下内容

```
search:
  path: search.xml
  field: post
  format: html
  limit: 10000
```

3.编辑 主题配置文件，启用本地搜索功能：

```
# Local search
local_search:
  enable: true
```


# 集成Algolia
## 1. 注册Algolia，穿件Index  
前往 Algolia 注册页面，注册一个新账户。 可以使用 GitHub 或者 Google 账户直接登录，注册后的 14 天内拥有所有功能（包括收费类别的）。之后若未续费会自动降级为免费账户，免费账户 总共有 10,000 条记录，每月有 100,000 的可以操作数。注册完成后，创建一个新的 Index，这个 Index 将在后面使用。  
    
![image](algolia_index.png)

## 2. 安装hexo algolia
Index 创建完成后，此时这个 Index 里未包含任何数据。 接下来需要安装 Hexo Algolia 扩展， 这个扩展的功能是搜集站点的内容并通过 API 发送给 Algolia。前往站点根目录，执行命令安装：

```
npm install --save hexo-algolia
```

## 3. 设置key，更新站点配置文件
在 Algolia 服务站点上找到需要使用的一些配置的值，包括 ApplicationID、Search API Key、 Admin API Key。注意，Admin API Key 需要保密保存。  

![image](api_keys.png)  
编辑 站点配置文件，新增以下配置(替换除了 chunkSize 以外的其他字段为在 Algolia 获取到的值)：

```
algolia:
  applicationID: applicationID
  apiKey: apiKey
  adminApiKey: adminApiKey
  indexName: indexName
  chunkSize: 5000
```

## 4. 更新index

当配置完成，在站点根目录下执行 hexo algolia 来更新 Index。请注意观察命令的输出。

![image](update_index-4.png)  

## 5. 主题集成

更改主题配置文件，找到 Algolia Search 配置部分,将 enable 改为 true 即可，根据需要你可以调整 labels 中的文本。 

```
# Algolia Search
algolia_search:
  enable: true
  hits:
    per_page: 10
  labels:
    input_placeholder: Search for Posts
    hits_empty: "We didn't find any results for the search: ${query}"
    hits_stats: "${hits} results found in ${time} ms"
```

来源：[http://leunggeorge.github.io/](http://leunggeorge.github.io/)  