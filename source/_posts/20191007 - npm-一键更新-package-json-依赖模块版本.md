---
uuid: bc02f8b0-e8a5-11e9-900c-9588bf31f02c
title: npm 一键更新 package.json 依赖模块版本
tags:
  - npm
  - 版本升级
categories:
  - 工具
comments: true
date: 2019-10-07 09:56:53
description: github 报 We found potential security vulnerabilities in your dependencies，遂升级依赖包版本。记录 package.json 升级方法。
---

<!--more-->


github 提示：
<img src="/images/20191007095849.png" width="100%">

## 安装 npm-check-updates

step 1： 执行 `npm install -g npm-check-updates` 安装升级工具。

## 检查更新

step 2： 执行 `npm-check-updates -u` 检查是否有更新。
<img src="/images/20191007100530.png" width="60%">

## 升级更新

step 3： 执行 `npm-check-updates -u` 进行升级。
<img src="/images/20191007100431.png" width="60%">

再次执行 `npm-check-updates -u` 会发现已更新到最新版本：
<img src="/images/20191007100813.png" width="60%">

<!-- ## 更新 package-lock.json

使用 `npm install xxx@1.0.0 --save` 更新 `package-lock.json` 文件，例如：

```shell
npm install braces@2.3.1 --save
``` -->


---
<link rel="stylesheet" href="http://yandex.st/highlightjs/6.1/styles/default.min.css">
<script src="http://yandex.st/highlightjs/6.1/highlight.min.js"></script>
<script>
hljs.tabReplace = ' ';
hljs.initHighlightingOnLoad();
</script>

> 来源：[https://leunggeorge.github.io/](https://leunggeorge.github.io/)  
