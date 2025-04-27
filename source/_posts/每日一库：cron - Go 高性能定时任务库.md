---
uuid: 151f4cd6-233f-11f0-b969-2d2358f21799
tags:
  - note
  - Golang
  - blog
  - 每日一库
  - 定时任务
  - DONE
categories:
  - essay
date: 2025-04-25
description: 
share: "true"
title: 
comments: true
number headings: auto, first-level 1, max 6, 1.1
---

`robfig/cron` 是一个用于 Go 语言的定时任务调度库，支持标准的 cron 表达式语法，允许开发者以简单的方式定义和管理周期性任务。以下是它的核心特性和使用方法的详细介绍。

# 1 项目基本信息

- **项目名称**：robfig/cron
- **项目地址**：[GitHub - robfig/cron](https://github.com/robfig/cron)
- **项目定位**：Go 语言的定时任务调度库，支持标准 Cron 表达式解析、时区处理、任务链拦截等功能，适用于构建需要定时执行任务的应用程序（如批处理、数据同步、监控等）。

![](assets/images/IMG-AF12944F8BAD125BB187855B722B3E8A.png)

---

# 2 核心特性
- **Cron 表达式支持**  
  兼容 Unix/Linux 的 cron 表达式语法（支持到秒级精度），例如 `0 30 * * * *` 表示每小时的第 30 分钟执行。
- **灵活的任务调度**  
  支持秒级（6 段）、分钟级（5 段）两种表达式格式。
- **任务链（Job Chaining）**  
  可以通过 `JobWrapper` 实现任务执行前后的拦截逻辑（如日志、统计、超时控制）。
- **任务恢复机制**  
  当某个任务执行时发生 panic，可通过 `Recover()` 恢复并记录错误。
- **轻量且线程安全**  
  适用于高并发场景，提供优雅的任务启停接口。

---

# 3 **快速开始**
## 3.1 安装
```bash
go get github.com/robfig/cron/v3@v3.0.0  # v3 是最新稳定版
```

## 3.2 示例代码
```go
package main

import (
	"fmt"
	"github.com/robfig/cron/v3"
)

func main() {
	c := cron.New()

	// 添加任务：每分钟执行一次
	_, _ = c.AddFunc("* * * * *", func() {
		fmt.Println("执行任务：每分钟触发")
	})

	// 添加任务：每天10:30执行
	_, _ = c.AddFunc("0 30 10 * * *", func() {
		fmt.Println("执行任务：每天10:30")
	})

	c.Start()          // 启动调度器
	defer c.Stop()     // 程序退出前停止

	select{}           // 阻塞主线程（或根据实际需求调整）
}
```

---

# 4 Cron 表达式格式

**⓵ 标准格式（5 段）**  
  
`分 时 日 月 星期`  
  示例：`0 30 * * *` 表示每小时的第 30 分钟执行。

**⓶ 扩展格式（6 段，支持秒）**  
  
`秒 分 时 日 月 星期`  
  示例：`0 0 12 * * *` 表示每天12:00:00执行。

---

# 5 高级功能

## 5.1 **自定义日志**
```go
c := cron.New(
	cron.WithLogger(
		cron.VerbosePrintfLogger(log.New(os.Stdout, "cron: ", log.LstdFlags)),
)
```

## 5.2 **错误处理**
任务执行时的 panic 会被捕获并记录：
```go
c := cron.New(cron.WithPanicLogger(log.Printf))
```

## 5.3 **任务链（JobWrapper）**
```go
// 添加一个带超时控制的任务
c := cron.New()
chain := cron.NewChain(
	cron.Recover(cron.DefaultLogger), // 捕获 panic
	cron.DelayIfStillRunning(cron.DefaultLogger),
)

// 将任务包装到链中
_, _ = c.AddJob("0 0 * * * *", chain.Then(cron.FuncJob(func() {
	// 执行任务
}))
```

## 5.4 **任务执行控制​**​

```go
// 延迟执行直到前任务完成
cron.New(
    cron.WithChain(
        cron.DelayIfStillRunning(logger),
    )
)
```

## 5.5 ​**​动态任务管理​**​
```go
// 运行时添加/删除任务
entryID := c.Schedule(cron.Every(10*time.Minute), cron.FuncJob(task))
c.Remove(entryID)
```

---

# 6 性能与可靠性​​

- ​**​精确调度​**​：基于系统时间轮询，误差通常在毫秒级
- ​**​并发安全​**​：支持多 goroutine 调用 `AddFunc` 和 `Remove`
- ​**​资源占用​**​：每个任务独立 goroutine 执行，需注意资源泄漏

---

# 7 常见问题
**⓵ 如何停止任务？**

调用 `c.Stop()` 会等待正在执行的任务完成后再关闭调度器。

**⓶ 如何动态添加/删除任务？**

- 添加任务：`entryID, _ := c.AddFunc(...)`
- 删除任务：`c.Remove(entryID)`

**⓷ 时区问题**

默认使用本地时区，可通过 `cron.WithLocation` 指定：
```go
location, _ := time.LoadLocation("Asia/Shanghai")
c := cron.New(cron.WithLocation(location))
```

**⓸ v3 版本向后不兼容变更​**
 
- ​**​导入路径​**​：必须使用 `github.com/robfig/cron/v3`
- ​**​构造函数​**​：使用函数式选项（如 `cron.WithLogger()`）
- ​**​错误处理​**​：不再自动恢复 panic（需手动添加 `Recover` 中间件）

**⓹ ​v3 版本表达式解析调整​**
​​
```go
// 旧版（默认含秒）：需显式切换解析器
parser := cron.NewParser(cron.SecondOptional | cron.Minute | cron.Hour | cron.Dom | cron.Month | cron.Dow)
cron.New(cron.WithParser(parser))
```

**⓺ v1 vs v3版本差异**

- `v3` 引入了模块化设计（如 ` cron.WithLogger ` 配置）。
- `v3` 默认支持秒级精度（表达式为 6 段），而 `v1` 仅支持 5 段。
- `v3` 的 API 更简洁（如 `cron.New()` 替代 `cron.NewCron()`）。

---

# 8 总结

**适用场景**：  
- 定时执行后台任务（如数据清理、报表生成）。
- 分布式系统中的定时心跳检测。
- 需要高精度（秒级）或复杂调度逻辑的任务。

**优势**：  
- 代码简洁，API 设计友好。
- 社区活跃，稳定性高（广泛用于生产环境）。

**对比标准库**：  
Go 标准库的 `time.Ticker` 适合简单周期性任务，而 `robfig/cron` 更适合需要灵活 cron 表达式控制的场景。
