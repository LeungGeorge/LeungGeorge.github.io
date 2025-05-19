---
uuid: 69eb07f1-3464-11f0-b80a-f93b102e20cc
tags:
  - note
  - Golang
  - blog
  - 每日一库
  - DONE
categories:
  - essay
date: 2025-05-15
description: 
share: "true"
title: 
comments: true
---

## 简介
[`copier`](https://github.com/jinzhu/copier) 是一个轻量级的 Go 语言库，专注于简化结构体之间的数据复制。通过自动或自定义的字段映射，它能够高效处理结构体、切片、甚至嵌套类型的复制，减少手动赋值的冗余代码。由知名 [GORM](https://github.com/go-gorm/gorm) 作者 jinzhu 开发，稳定性和设计理念值得信赖。

![](assets/images/IMG-D5EC71B6E47807471872D0338B53DEA2.png)

---

## 核心功能

**1️⃣结构体 ↔ 结构体复制**  
   - **自动匹配同名字段**：无需配置，自动复制名称和类型相同的字段。
   - **标签支持**：通过 `copier:"目标字段名"` 标签映射不同名称的字段。
   - **嵌套结构体**：自动递归复制嵌套的结构体（默认深度复制）。

   ```go
   type User struct {
       Name string
       Age  int
   }

   type Employee struct {
       Name    string
       Age     int `copier:"UserAge"` // 显式映射到源结构体的 Age 字段
       Salary  float64
   }

   func main() {
       user := User{Name: "Alice", Age: 30}
       employee := Employee{}
       copier.Copy(&employee, &user)
       // employee.Name = "Alice", employee.UserAge = 30
   }
   ```

**2️⃣切片 ↔ 切片复制**  
   - 自动将源切片元素逐个复制到目标切片。
   - 支持不同类型切片（需元素类型可转换）。

   ```go
   users := []User{{Name: "Alice"}, {Name: "Bob"}}
   var employees []Employee
   copier.Copy(&employees, &users) // employees 成为包含两个 Employee 的切片
   ```

**3️⃣自定义转换函数**  
   - 注册函数处理特定类型或字段的转换逻辑（如时间格式、枚举解析），自动处理基础类型转换（如 `int` ↔ `int32`、`string` ↔ `[]byte`）。
   - 支持自定义转换器：通过 `copier.RegisterConverter` 注册函数处理复杂类型转换。

   ```go
   copier.CopyWithOption(&dest, &src, copier.Option{
       Converters: []copier.TypeConverter{
           {
               SrcType: time.Time{},
               DstType: copier.String,
               Fn: func(src interface{}) (interface{}, error) {
                   return src.(time.Time).Format("2006-01-02"), nil
               },
           },
       },
   })
   ```

**4️⃣忽略字段**  
   - 使用 `copier:"-"` 标签跳过指定字段。

   ```go
   type Config struct {
       APIKey string `copier:"-"` // 复制时忽略此字段
       Port   int
   }
   ```

**5️⃣深度复制（Deep Copy）**  
   - 对指针、切片、映射等引用类型创建独立副本，避免副作用。

**6️⃣复制选项（Option）**
- `IgnoreEmpty`：跳过源字段为零值（如 `""`、`0`、`nil`）的复制。

    ```go
    copier.CopyWithOption(&dest, &src, copier.Option{IgnoreEmpty: true}) // 源字段为空时不覆盖目标
    ```

- `CaseInsensitive`：启用不区分大小写的字段匹配（如 `Source.Name` 匹配 `Target.NAME`）
- `DeepCopy`：深度复制指针、切片等引用类型（默认浅复制）。

    ```go
    src := &User{Addresses: []Address{{City: "NY"}}}
    var dest User
    copier.CopyWithOption(&dest, src, copier.Option{DeepCopy: true}) // 复制切片内容而非指针
    ```

---

## 典型应用场景

- **DTO 转换**：将数据库模型（Model）转换为 API 响应体（DTO）或前端所需的 JSON 结构。
- **配置覆盖**：合并默认配置和用户自定义配置，忽略敏感字段。
- **微服务通信**：不同服务间消息结构的转换，如 gRPC 消息 ↔ 内部结构体。
- **测试数据构造**：快速生成测试对象的变体，避免重复初始化逻辑。

---

## 实战示例

**场景：API 响应过滤敏感字段**  
```go
type UserModel struct {
    ID       int
    Email    string
    Password string
}

type UserResponse struct {
    ID    int    `json:"id"`
    Email string `json:"email"`
    // Password 字段被排除
}

func GetUser(ctx *gin.Context) {
    user := getUserFromDB() // 获取数据库模型
    var resp UserResponse
    copier.Copy(&resp, &user) // 自动复制 ID 和 Email，跳过 Password
    ctx.JSON(200, resp)
}
```

---

## 总结

`copier` 是处理 Go 结构体复制的神器，尤其适合需要频繁进行数据转换的场景。尽管反射带来轻微性能损耗，但其带来的代码简洁性和可维护性提升，在大多数项目中利大于弊。推荐在 Web 开发、微服务架构或任何涉及多数据模型转换的项目中尝试使用。
