---
uuid: 151f73e0-233f-11f0-b969-2d2358f21799
tags:
  - note
  - 每日一库
  - blog
  - Golang
  - 工具箱
categories:
  - essay
date: 2025-04-16,09:53
description: 
share: "true"
title: 
comments: true
---

## 项目简介
**Lancet** 是一个全面、高效且可复用的 Go 语言工具库，灵感来源于 Java 的 Apache Commons 和 JavaScript 的 Lodash。它提供了 **600+ 实用函数**，覆盖字符串、切片、日期时间、加密、并发、数据结构等高频场景，旨在简化开发流程，减少重复代码。

• **GitHub 地址**: [duke-git/lancet](https://github.com/duke-git/lancet)
• **核心特点**:
  • **全面性**：支持字符串处理、加密、数据结构、网络工具等。
  • **高效轻量**：仅依赖 Go 标准库和 `golang.org/x`，无冗余依赖。
  • **强测试**：每个导出函数均有单元测试，保障代码质量。
  • **泛型支持**：v 2.x.x 基于 Go 1.18+ 泛型重构，提供更灵活的类型处理。

---

## 安装指南
根据 Go 版本选择合适版本：
```go
// Go 1.18+ 安装 v2.x.x
go get github.com/duke-git/lancet/v2

// Go 1.18 以下安装 v1.x.x（最新 v1.4.3）
go get github.com/duke-git/lancet
```

---

## 核心功能概览
1. **常用数据类型处理**  
   • **字符串处理** (`strutil`)：反转、驼峰/蛇形命名、子串截取等。
     ```go
     s := "hello"
     reversed := strutil.Reverse(s) // "olleh"
     ```
   • **切片操作** (`slice`)：去重、过滤、分块、排序等。
   • **Map 工具** (`maputil`)：合并、过滤、转换、交集差集计算。

2. **算法与数据结构**  
   • **排序算法** (`algorithm`)：冒泡、堆排、快排等。
   • **LRU 缓存**：基于 LRU 算法实现内存缓存。
   • **并发结构** (`concurrency`)：协程管理、通道合并、超时控制。

3. **加密与安全** (`cryptor`)  
   支持 AES、DES、RSA 等加密算法，以及 HMAC、MD 5、SHA 系列哈希。
   ```go
   encrypted := cryptor.AesEcbEncrypt(data, key) // AES-ECB 加密
   ```

4. **日期时间处理** (`datetime`)  
   提供时间计算、格式化、范围判断等功能：
   ```go
   now := datetime.GetNowDateTime() // "2023-10-01 12:34:56"
   ```

5. **数据验证** (`validator`)  
   校验邮箱、URL、IP、身份证号、密码强度等：
   ```go
   isValid := validator.IsEmail("user@example.com") // true
   ```

6. **高级特性**  
   • **函数式编程** (`function`)：防抖、重试、管道组合。
   • **流处理** (`stream`)：类似 Java Stream 的链式操作。
   • **元组与可选值** (`tuple`, `optional`)：简化多返回值处理。

---

## 示例场景
**场景 1：高效处理切片**
```go
import "github.com/duke-git/lancet/v2/slice"

nums := []int{1, 2, 3, 4}
filtered := slice.Filter(nums, func(n int) bool { return n%2 == 0 }) // [2,4]
```

**场景 2：并发控制**
```go
import "github.com/duke-git/lancet/v2/concurrency"

ch := concurrency.NewChannel()
ch.TrySend("data") // 非阻塞发送
result, ok := ch.TryReceive() // 非阻塞接收
```

**场景 3：数据验证**
```go
import "github.com/duke-git/lancet/v2/validator"

isStrong := validator.IsStrongPassword("Passw0rd!", 8) // 校验强度
```

---

## 为何选择 Lancet？
• **减少重复代码**：覆盖大部分工具需求，避免重复造轮子。
• **性能优化**：函数经过优化，适合高性能场景。
• **社区活跃**：持续更新，贡献者友好（见 [CONTRIBUTION.md](https://github.com/duke-git/lancet/blob/main/CONTRIBUTION.md)）。

---

## 总结
Lancet 是 Go 开发者提升效率的利器，尤其适合需要快速实现复杂逻辑的中大型项目。其模块化设计允许按需引入，避免项目膨胀。通过丰富的文档和测试用例，开发者可快速上手，建议结合官方示例探索更多功能！