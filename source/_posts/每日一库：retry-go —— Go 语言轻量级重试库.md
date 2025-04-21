---
tags:
  - note
  - Golang
  - blog
  - 每日一库
  - 工具箱
categories:
  - essay
date: 2025-04-20
description: 
share: "true"
title: 
comments: true
---

#### 概述
**retry-go** 是一个简单易用的 Go 语言重试库，由 Avast 开源。它提供灵活的重试策略和丰富的配置选项，适用于需要网络请求、资源访问等场景的错误重试。与其他重试库（如 `cenkalti/backoff`）相比，retry-go 的接口更直观，支持**带返回值重试**和**动态条件控制**，适合快速集成到项目中。

- Github：https://github.com/avast/retry-go [GitHub - avast/retry-go: Simple golang library for retry mechanism](https://github.com/avast/retry-go)

---

#### 核心特性
1. **简洁的 API 设计**：
   • `retry.Do()`：执行无返回值的重试逻辑。
   • `retry.DoWithData()`：执行带返回值的重试逻辑（支持泛型）。
   
2. **多种延迟策略**：
   • **指数退避**（默认）、固定延迟、随机抖动，支持自定义组合。
   
3. **灵活的重试条件**：
   • 根据错误类型、重试次数、自定义逻辑动态控制是否重试。
   
4. **上下文支持**：
   • 集成 `context.Context`，支持超时或手动取消重试任务。
   
5. **错误处理**：
   • 收集所有重试错误，或仅返回最后一次错误。
   • 支持将错误标记为**不可恢复**（Unrecoverable），立即终止重试。

---

#### 快速开始
##### 安装
```bash
go get github.com/avast/retry-go
```

##### 基本用法：HTTP GET 重试
```go
url := "http://example.com"
var body []byte

err := retry.Do(
    func() error {
        resp, err := http.Get(url)
        if err != nil {
            return err
        }
        defer resp.Body.Close()
        body, err = io.ReadAll(resp.Body)
        return err
    },
    retry.Attempts(3),       // 最大重试次数
    retry.Delay(time.Second),// 重试间隔
)

if err != nil {
    log.Fatal("请求失败:", err)
}
fmt.Println(string(body))
```

##### 带返回值的重试
使用 `DoWithData` 简化返回值处理：
```go
body, err := retry.DoWithData(
    func() ([]byte, error) {
        resp, err := http.Get(url)
        if err != nil {
            return nil, err
        }
        defer resp.Body.Close()
        return io.ReadAll(resp.Body)
    },
    retry.Attempts(5),
)
```

---

#### 高级配置
##### 1. 延迟策略
• **指数退避**（默认）：
  ```go
  retry.DelayType(retry.BackOffDelay)
  ```
  
• **固定延迟**：
  ```go
  retry.DelayType(retry.FixedDelay)
  retry.Delay(500 * time.Millisecond) // 固定 500ms
  ```

• **随机抖动**：
  ```go
  retry.DelayType(retry.RandomDelay)
  retry.MaxJitter(1 * time.Second)    // 最大抖动 1s
  ```

• **组合策略**（如固定延迟 + 随机抖动）：
  ```go
  retry.DelayType(retry.CombineDelay(
      retry.FixedDelay,
      retry.RandomDelay,
  ))
  ```

##### 2. 自定义重试条件
通过 `RetryIf` 根据错误类型判断是否重试：
```go
retry.Do(
    fetchData,
    retry.RetryIf(func(err error) bool {
        return strings.Contains(err.Error(), "timeout")
    }),
)
```

标记不可恢复错误：
```go
err := retry.Do(
    func() error {
        if criticalError {
            return retry.Unrecoverable(errors.New("致命错误"))
        }
        return nil
    },
)
```

##### 3. 无限重试与上下文
```go
ctx, cancel := context.WithTimeout(context.Background(), 5*time.Minute)
defer cancel()

retry.Do(
    task,
    retry.Attempts(0),       // 无限重试
    retry.Context(ctx),      // 绑定上下文
    retry.Delay(time.Second),
)
```

##### 4. 重试回调
记录每次重试日志：
```go
retry.OnRetry(func(attempt uint, err error) {
    log.Printf("第 %d 次重试，错误: %v", attempt, err)
})
```

---

#### 版本迁移注意
• **v 1 → v 2**：`retry.Delay` 的语义从“基础单位”变为“最终延迟”，移除 `retry.Units`。
• **v 0 → v 1**：函数名从 `Retry` 改为 `Do`，新增 `Options` 模式。

---

#### 对比其他库
| 库名               | 特点                              | 适用场景               |
|--------------------|-----------------------------------|-----------------------|
| retry-go           | 简单直观，支持泛型返回值          | 快速集成，通用重试逻辑 |
| cenkalti/backoff   | 复杂退避算法，Google 官方实现      | 高并发场景，精细控制   |
| matryer/try        | 链式调用，高人气                  | 偏好流式接口的项目     |

---

#### 总结
**retry-go** 是 Go 生态中轻量级重试库的优选，尤其适合：
• 需要快速实现 HTTP 请求重试。
• 希望灵活控制重试条件与延迟策略。
• 需要结合上下文管理（如超时取消）。

通过合理配置 `Options`，可以轻松应对从简单到复杂的需求，是提升系统容错能力的利器。