---
tags:
  - note
  - Golang
  - blog
  - 每日一库
  - uuid
  - DONE
categories:
  - essay
date: 2025-04-23
description: 
share: "true"
title: 
comments: true
---
Google 的 `uuid` 库是一个用于生成和操作 **UUID（Universally Unique Identifier，通用唯一标识符）** 的 Go 语言开源库，支持 UUID 的多个版本（v1-v5）。它提供简洁的 API，适合需要唯一标识符的分布式系统、数据库主键、日志追踪等场景。

- [GitHub - google/uuid: Go package for UUIDs based on RFC 4122 and DCE 1.1: Authentication and Security Services.](https://github.com/google/uuid)

---

### **核心功能**
1. **生成 UUID**
   - **v1**: 基于时间戳和 MAC 地址（可能涉及隐私，需谨慎使用）。
   - **v3/v5**: 基于命名空间和字符串的哈希（v3 用 MD 5，v5 用 SHA-1）。
   - **v4**: 基于密码学安全的随机数生成（最常用，推荐默认使用）。
   - **​v6 & v7​**​：时间有序的 UUID（较新标准，适合作为数据库主键）。
   ```go
   package main

   import (
     "fmt"
     "github.com/google/uuid"
   )

   func main() {
     // 生成 v4 UUID
     id := uuid.New()
     fmt.Println("UUID v4:", id)

     // 生成 v1 UUID
     idV1, _ := uuid.NewUUID()
     fmt.Println("UUID v1:", idV1)
   }
   ```

2. **解析与格式化**
   - 从字符串解析 UUID，支持带/不带连字符的格式。
   - 格式化为标准字符串、URN 或字节数组。
   ```go
   // 字符串解析
   s := "6ba7b810-9dad-11d1-80b4-00c04fd430c8"
   parsedUUID, err := uuid.Parse(s)
   if err != nil {
     panic(err)
   }
   fmt.Println("Parsed UUID:", parsedUUID)

   // 转换为字节数组
   bytes := parsedUUID[:]
   ```

3. **比较与零值检查**
   - 直接比较两个 UUID 是否相等。
   - 检查 UUID 是否为零值（全零）。
   ```go
   uuid1 := uuid.New()
   uuid2 := uuid.New()
   fmt.Println("Equal?", uuid1 == uuid2) // false

   zeroUUID := uuid.UUID{}
   fmt.Println("Is zero?", zeroUUID == uuid.Nil) // true
   ```

---

### **特点与优势**
- **安全性**：v4 使用 `crypto/rand` 生成随机数，满足加密安全要求。
- **轻量高效**：无外部依赖，性能优秀。
- **符合 RFC 4122**：严格遵循 UUID 标准规范。
- **灵活的格式化**：支持多种字符串和二进制格式转换。

---

### **适用场景**
- 分布式系统唯一 ID（如微服务请求追踪）。
- 数据库主键或唯一约束字段。
- 防止冲突的临时文件名、会话 Token 等。

---

### **注意事项**
1. **版本选择**
   - **v4**：默认推荐，无需担心隐私泄露。
   - **v1**：需注意 MAC 地址暴露风险。
   - **v3/v5**：确保命名空间唯一性（如使用 DNS、URL 等）。
1. **性能优化**
   - 避免频繁生成 UUID（如循环中），必要时可预生成批次。
3. **存储优化**
   - 数据库存储时可用 `BINARY(16)` 代替字符串节省空间。

---

### **示例：生成命名空间 UUID（v5）**
```go
// 使用 DNS 命名空间生成 UUID v5
namespaceDNS := uuid.MustParse("6ba7b810-9dad-11d1-80b4-00c04fd430c8")
name := "example.com"
uuidV5 := uuid.NewSHA1(namespaceDNS, []byte(name))
fmt.Println("UUID v5:", uuidV5)
```

---

### **总结**
Google 的 `uuid` 库以简洁的 API 和可靠性成为 Go 生态中 UUID 生成的首选。无论是需要随机性（v4）还是基于命名空间的标识符（v3/v5），它都能满足需求，且适合高并发场景。使用时注意版本特性，结合业务需求选择即可。
