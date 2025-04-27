---
uuid: 151f4cd3-233f-11f0-b969-2d2358f21799
tags:
  - note
  - Golang
  - blog
  - 每日一库
  - 工具箱
  - 校验
categories:
  - essay
date: 2025-04-19
description: 
share: "true"
title: 
comments: true
---

## 概述
**Govalidator** 是一个 Go 语言库，专注于数据验证与清理，支持字符串、数字、切片、结构体及嵌套数据。灵感来源于 JavaScript 的 `validator.js`，它提供了丰富的内置验证函数，同时支持灵活的自定义扩展。

- [GitHub - asaskevich/govalidator: \[Go\] Package of validators and sanitizers for strings, numerics, slices and structs](http://github.com/asaskevich/govalidator)

---

## 核心功能
1. **安装与导入**
   ```bash
   go get github.com/asaskevich/govalidator
   ```
   导入到代码：
   ```go
   import "github.com/asaskevich/govalidator"
   ```

2. **强制字段验证**
   • 启用 `SetFieldsRequiredByDefault(true)` 后，所有结构体字段需显式标记 `valid` 标签，否则验证失败。
   • 例外：使用 `valid:"-"` 或 `valid:"email,optional"` 跳过验证或设为可选。

3. **内置验证器**
   • **字符串**：`IsURL`、`IsEmail`、`IsIPv4`、`IsCreditCard` 等。
   • **数值**：`IsInt`、`IsFloat`、`InRange`。
   • **格式**：`IsJSON`、`IsBase64`、`IsUUID`。
   • **国际化**：`IsUTFLetter`、`IsFullWidth`。
   • **完整列表**：超过 70 种验证函数，覆盖常见需求。

4. **结构体验证**
   ```go
   type User struct {
       Name  string `valid:"required,alpha"`
       Email string `valid:"email"`
   }
   isValid, err := govalidator.ValidateStruct(User{Name: "Bob", Email: "bob@example.com"})
   ```

5. **Map 验证**
   ```go
   template := map[string]interface{}{
       "name": "required,alpha",
       "age":  "numeric,range(18|99)",
   }
   input := map[string]interface{}{"name": "Alice", "age": 25}
   isValid, err := govalidator.ValidateMap(input, template)
   ```

6. **自定义验证器**
   • **无参数验证器**：
     ```go
     govalidator.TagMap["isDuck"] = govalidator.Validator(func(str string) bool {
         return str == "duck"
     })
     ```
   • **带参数验证器**：
     ```go
     govalidator.ParamTagMap["animal"] = govalidator.ParamValidator(func(str string, params ...string) bool {
         return str == params[0]
     })
     ```

7. **错误处理**
   • 自定义错误消息：
     ```go
     type Ticket struct {
         Name string `valid:"required~Name cannot be empty"`
     }
     ```
   • 遍历多错误：
     ```go
     if errs, ok := err.(govalidator.Errors); ok {
         for _, e := range errs.Errors() {
             fmt.Println(e.Error())
         }
     }
     ```

8. **辅助工具**
   • **字符串处理**：`Trim`、`PadLeft`、`Reverse`、`WhiteList`（过滤字符）。
   • **切片操作**：`Each`、`Map`、`Filter`、`Count`。
   • **类型转换**：`ToBoolean`、`ToFloat`、`ToString`。

---

## 使用场景
• **API 请求验证**：确保输入数据符合预期格式。
• **数据清洗**：过滤非法字符或格式化字符串。
• **复杂结构校验**：嵌套结构体或动态 Map 数据的规则验证。
• **国际化支持**：处理多语言字符集的验证需求。

---

## 注意事项
• **破坏性变更**：v 10 版本后，自定义验证函数需接收上下文参数 `func(i interface{}, o interface{}) bool`，以支持依赖验证。
• **性能**：大量数据验证时注意性能，可结合基准测试优化。
• **错误消息**：优先使用自定义错误提升可读性。

---

## 示例代码
```go
package main

import (
    "fmt"
    "github.com/asaskevich/govalidator"
)

func init() {
    govalidator.SetFieldsRequiredByDefault(true)
}

type Product struct {
    ID    string `valid:"required,uuidv4"`
    Name  string `valid:"required,alpha"`
    Price float64 `valid:"required,range(10|1000)"`
}

func main() {
    p := Product{ID: "bad-id", Name: "Laptop123", Price: 5.0}
    isValid, err := govalidator.ValidateStruct(p)
    if err != nil {
        for _, e := range err.(govalidator.Errors).Errors() {
            fmt.Println("Error:", e)
        }
    }
    fmt.Println("Is valid?", isValid)
}
// 输出：
// Error: ID must be a valid UUIDv4
// Error: Name must contain alphabetic characters only
// Error: Price must be between 10 and 1000
// Is valid? false
```

---

## 总结
**Govalidator** 是 Go 生态中功能全面的验证库，适合需要严格数据校验的场景。通过组合内置规则与自定义逻辑，可轻松应对复杂业务需求。使用时注意版本升级的变更，合理设计验证规则以平衡灵活性与性能。