---
tags:
  - note
  - Golang
  - blog
  - 每日一库
categories:
  - essay
date: 2025-04-17
description: 
share: "true"
title: 
comments: true
---
## 概述  
**Expr** 是一个专为 Go 语言设计的表达式求值库，旨在通过简洁的语法实现动态配置、业务规则和条件判断。它强调**安全性**（内存安全、无副作用、无死循环）、**高性能**（基于字节码虚拟机优化）和**无缝 Go 集成**（直接复用 Go 类型，静态类型检查）。

- [GitHub - expr-lang/expr: Expression language and expression evaluation for Go](https://github.com/expr-lang/expr)

---

## 核心特性  
1. **安全性优先**  
   • **内存安全**：禁止访问无关内存，避免潜在漏洞。
   • **无副作用**：表达式仅依赖输入计算输出，不修改外部状态。
   • **强制终止**：防止无限循环，确保表达式执行可控。

2. **深度集成 Go 生态**  
   • **无需类型重定义**：直接使用已有的 Go 结构体、函数作为表达式环境变量。
   • **静态类型检查**：编译阶段捕获类型错误（如 `string + int` 直接报错）。

3. **高性能设计**  
   • 优化编译器 + 字节码虚拟机，适用于高频调用场景（如实时规则引擎）。

4. **开发友好**  
   • 丰富的内置函数（`all`、`filter`、`map` 等）和操作符。
   • 清晰的错误提示，快速定位语法或逻辑问题。

---

## 快速上手  
**安装**：  
```bash
go get github.com/expr-lang/expr
```

**示例 1：动态字符串生成**  
```go
env := map[string]interface{}{
    "greet":   "Hello, %v!",
    "names":   []string{"world", "you"},
    "sprintf": fmt.Sprintf,
}

code := `sprintf(greet, names[0])`  // 输出 "Hello, world!"
program, _ := expr.Compile(code, expr.Env(env))
output, _ := expr.Run(program, env)
fmt.Println(output)
```

**示例 2：业务规则验证**  
```go
type Tweet struct{ Len int }
type Env struct{ Tweets []Tweet }

code := `all(Tweets, {.Len <= 240})`  // 检查所有推文长度 ≤240
program, _ := expr.Compile(code, expr.Env(Env{}))
env := Env{Tweets: []Tweet{{42}, {98}, {69}}}
output, _ := expr.Run(program, env)  // 输出 true
```

---

## 适用场景  
1. **动态业务规则**（如 Uber Eats 的商家配置、Wish 的促销规则）
2. **实时条件判断**（如游戏匹配算法、风控系统）
3. **配置验证**（如 K8s 资源策略、网络流分类）
4. **交互式工具**（如 REPL 环境、DSL 实现）

---

## 谁在使用？  
• **Uber**、**GoDaddy**：动态配置电商/服务策略  
• **ByteDance**、**Aviasales**：业务规则引擎  
• **Argo Rollouts**、**CoreDNS**：基础设施逻辑控制  
• **Chaos Mesh**、**CrowdSec**：安全与混沌工程  

---

## 总结  
Expr 凭借其**安全性**、**性能**和**Go 原生友好性**，成为动态规则场景的优选方案。若你的项目需要灵活表达式求值（如用户自定义条件、实时策略调整），Expr 能以极低成本接入，避免重复造轮子的同时保障代码健壮性。
