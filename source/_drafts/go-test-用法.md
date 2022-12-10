---
uuid: 14470760-44da-11ea-b973-b70b2c73677a
title: go test 用法
tags:
  - go test
  - 单元测试
categories:
  - golang
comments: false
description: go test 使用总结
---

## 运行目录下所有的单元测试函数
```
➜  rate git:(master) ✗ go test *                                    
ok      command-line-arguments  5.312s
```

## 运行指定单元测试函数
```
➜  rate git:(master) ✗ go test -v -run TestLimiterBurst1 *       
=== RUN   TestLimiterBurst1
--- PASS: TestLimiterBurst1 (0.00s)
PASS
ok      command-line-arguments  (cached)
```



<!--more-->

## go test 遇到的坑
### cache 导致当前时间被缓存

如果你在单元测试中用到了如下代码：
```
t.Logf("current time : %d", time.Now().Unix())
```

那么多次运行的结果可能是一样的，运行结果（注意 cached）如：
```
➜  rate git:(master) ✗ go test -v -run TestLimiterBurst1 *
=== RUN   TestLimiterBurst1
--- PASS: TestLimiterBurst1 (0.00s)
    rate_test.go:77: current time : 1580552944
PASS
ok      command-line-arguments  (cached)
```

**解决方法有两种：**
```
方法一（清除cache）：
➜  rate git:(master) ✗ go clean -testcache         

方法二（禁用cache）：  
➜  rate git:(master) ✗ go test -v -count=1 -run TestLimiterBurst1 *
```
> https://golang.org/cmd/go/#hdr-Testing_flags





---
![20200131220947.png](/images/20200131220947.png)

<link rel="stylesheet" href="http://yandex.st/highlightjs/6.1/styles/default.min.css">
<script src="http://yandex.st/highlightjs/6.1/highlight.min.js"></script>
<script>
hljs.tabReplace = ' ';
hljs.initHighlightingOnLoad();
</script>

<!-- > 来源：[https://leunggeorge.github.io/](https://leunggeorge.github.io/)   -->
