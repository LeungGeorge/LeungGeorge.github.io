---
title: hexo搭建github个人博客
tags:
  - writting
categories:
  - essay
comments: false
date: 2017-07-09 09:48:42
---


#1. 安装Hexo

## 安装node.js

```
sudo add-apt-repository ppa:chris-lea/node.js
sudo apt-get update
sudo apt-get install nodejs
```

##  安装hexo
```
 sudo npm install hexo -g
```

#2. 部署Hexo
#3. Hexo命令
#4. 一些报错处理
#5. 博客管理
#6. 插件
## RSS插件
安装hexo-generator-feed

```
npm install hexo-generator-feed --save
```
修改站点配置文件：

```
feed:
  type: atom
  path: atom.xml
  limit: 20
  hub:
  content:
```

## Sitemap插件
给博客生成一个站点地图:

```
npm install hexo-generator-sitemap --save
npm install hexo-generator-baidu-sitemap --save
```

修改站点配置文件：

```
# 自动生成sitemap
sitemap:
  path: sitemap.xml
baidusitemap:
  path: baidusitemap.xml
```


## search插件
### 安装hexo-generator-searchdb
```
npm install hexo-generator-searchdb --save
```

## 百度统计插件
## 图片插件
安装

```
npm install https://github.com/CodeFalling/hexo-asset-image -- save
```
修改站点配置文件：

```
post_asset_folder: true #是否启动资源文件夹
```

使用
```

```



#7. 评论设置
#8. 404页面
配置腾讯公益

```
![image](pic-404.png)
```

#9. 统计
#10. 更新
#11. 总结
#12. 参考引用
#13. 搭建博客相关网站


[安装Hexo](http://www.jianshu.com/p/35e197cb1273)  
[hexo.io](https://hexo.io/)  
[hexo](http://blog.sina.com.cn/s/blog_617ccc0c0101h84p.html)