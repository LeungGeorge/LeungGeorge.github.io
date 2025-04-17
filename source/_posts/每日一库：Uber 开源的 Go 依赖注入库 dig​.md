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

## 1. 简介
**dig**（Dependency Injection for Go）是 Uber 开源的一款基于反射的依赖注入工具，专为 Go 语言设计。它通过自动管理对象间的依赖关系，简化代码结构，适用于构建应用框架（如 Uber 的 [Fx](https://github.com/uber-go/fx)）或初始化复杂依赖图。

-  [GitHub - uber-go/dig: A reflection based dependency injection toolkit for Go.](https://github.com/uber-go/dig)

---

## 2. 核心特点
• **反射驱动**：无需代码生成，通过反射分析函数参数和返回值，自动解析依赖。
• **容器化管理**：通过 `dig.Container` 管理所有依赖的构造函数和实例。
• **启动时依赖解析**：适合在应用启动阶段构建依赖图，避免运行时开销。
• **稳定性**：遵循 SemVer 规范，v 1 版本无破坏性变更。
• **轻量级**：核心代码简洁，适合作为底层工具集成到框架中。

---

## 3. 使用场景
• ✅ **适用场景**：
  • 构建应用框架（如 Fx）。
  • 初始化阶段集中管理复杂依赖（如配置、数据库连接、服务层）。
• ❌ **不适用场景**：
  • 替代完整的应用框架（需结合 Fx 等）。
  • 运行时动态依赖注入。

---

## 4. 快速入门
### 示例代码
```go
package daemon

import (
	"fmt"

	"go.uber.org/dig"
)

type Config struct {
	Addr string
}

func NewConfig() *Config {
	return &Config{Addr: ":8080"}
}

type Server struct {
	cfg *Config
}

func NewServer(cfg *Config) *Server {
	return &Server{cfg: cfg}
}

func ABC() {
	c := dig.New()

	c.Provide(NewConfig)
	c.Provide(NewServer)

	c.Invoke(func(s *Server) {
		fmt.Println("Server started at", s.cfg.Addr)
	})
}

```

### 输出
```
Server started at :8080
```

---

## 5. 高级功能
### 5.1 组注入（Grouping）
将多个相同类型的实例注入为切片，适用于插件化场景：
```go
c.Provide(func() *Logger { return NewFileLogger() }, dig.Group("loggers"))
c.Provide(func() *Logger { return NewConsoleLogger() }, dig.Group("loggers"))

// 使用时注入 []*Logger
c.Invoke(func(loggers []*Logger) {
    for _, l := range loggers {
        l.Log("Hello")
    }
})
```

### 5.2 装饰器（Decorators）
动态增强已有依赖：
```go
c.Decorate(func(l *Logger) *Logger {
    return l.WithLevel("debug")
})
```

### 5.3 接口绑定
通过返回接口类型实现接口-具体类型绑定：
```go
type Writer interface { Write([]byte) }
type FileWriter struct{}

func NewWriter() Writer { return &FileWriter{} }

c.Provide(NewWriter) // 依赖注入时识别为 Writer 接口
```

---

## 6. 性能与注意事项
• **性能**：反射在启动时一次性解析依赖，对运行时性能无影响，但大型项目可能增加启动时间。
• **错误处理**：支持构造函数返回 `error`，容器会捕获并终止初始化。
• **循环依赖检测**：启动时自动检测循环依赖（如 A → B → A）并报错。

---

## 7. 对比其他工具

| 工具      | 特点                          | 适用场景               |
|-----------|-------------------------------|------------------------|
| **dig**   | 反射驱动，灵活，启动时解析    | 中小项目、框架集成     |
| **wire**  | 代码生成，编译时检查，高性能  | 大型项目、追求性能     |
| **Fx**    | 基于 dig 的应用框架，生命周期管理 | 全功能应用开发       |

---
## 8. 总结
**dig** 是 Go 生态中轻量且强大的依赖注入工具，适合需要灵活依赖管理的场景。结合 Fx 可构建完整的应用框架，但需注意反射带来的启动开销。对于性能敏感项目，可考虑代码生成方案（如 wire）。

