---
uuid: 4c947a50-cfda-11e9-abce-b19ae548998f
title: MySQL表转为Golang结构体
tags:
  - Table2Struct
  - Golang
  - MySQL
categories:
  - 工具
comments: false
date: 2019-09-05 20:40:10
description:
---

- `MySQL` 表结构转为 `go` 结构体。

<!--more-->

```go
package main

import (
	"fmt"

	"github.com/gohouse/converter"
)

func main() {
	table2Struct := converter.NewTable2Struct()
	table2Struct.Config(&converter.T2tConfig{
		SeperatFile: false,
	})
	err := table2Struct.
		EnableJsonTag(true).
		PackageName("main").
		TagKey("ddb").
		SavePath("model.go").
		Dsn("root:123456@tcp(127.0.0.1:3306)/test?charset=utf8").
		Run()
	if err != nil {
		fmt.Println(err)
	} else {
		fmt.Println("success")
	}
}

```







---
<link rel="stylesheet" href="http://yandex.st/highlightjs/6.1/styles/default.min.css">
<script src="http://yandex.st/highlightjs/6.1/highlight.min.js"></script>
<script>
hljs.tabReplace = ' ';
hljs.initHighlightingOnLoad();
</script>

> 来源：[https://leunggeorge.github.io/](https://leunggeorge.github.io/)  
