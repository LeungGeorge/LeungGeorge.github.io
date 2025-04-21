---
tags:
  - note
  - Golang
  - blog
  - 每日一库
  - 字幕
categories:
  - essay
date: 2025-04-21
description: 
share: "true"
title: 
comments: true
---

## 项目简介
go-astisub 是一个用 Go 语言编写的开源库，专注于多种字幕格式的解析、编辑和转换。支持主流格式如 `.srt`、`.ssa/.ass`、`.stl`、`.ttml`、`.vtt`（WebVTT）、`teletext` 等，提供时间轴调整、分段/合并、格式转换等实用功能。适合需要处理字幕的开发者或视频处理工具链集成。

**GitHub 地址**：https://github.com/asticode/go-astisub  
[GitHub - asticode/go-astisub: Manipulate subtitles in GO (.srt, .ssa/.ass, .stl, .ttml, .vtt (webvtt), teletext, etc.)](https://github.com/asticode/go-astisub)

---

## 核心功能
### 1. 格式支持：
   - 输入/输出格式：SRT、SSA/ASS、STL、TTML、WebVTT、Teletext。
   - 支持跨格式转换（如 SRT 转 TTML）。

### 2. 操作功能：

   - 时间轴调整：整体偏移（Sync）、线性校正（基于两点时间戳的线性缩放）。
   - 分段与合并：按时长分割字幕（Fragment）或合并多个字幕文件（Merge）。
   - 优化：自动删除空白或重叠字幕，提升可读性。
   - 反分段：合并被过度分割的字幕片段（Unfragment）。

### 3. CLI 工具：

   - 提供命令行工具，无需编程即可完成常见操作：

```bash
# 转换格式
astisub convert -i input.srt -o output.ttml
# 时间轴线性校正（如修正不同步问题）
astisub apply-linear-correction -i input.srt -a1 1s -d1 2s -a2 5s -d2 7s -o output.srt
# 合并字幕
astisub merge -i s1.srt -i s2.ttml -o merged.srt
```

---

## 安装

通过 Go Modules 安装：
```bash
go get github.com/asticode/go-astisub
```

---

## 使用示例

**场景**：将 SRT 字幕转换为 WebVTT 格式，并整体延迟 2 秒。

```go
package main

import (
    "github.com/asticode/go-astisub"
    "time"
)

func main() {
    // 读取 SRT 文件
    subs, err := astisub.OpenFile("input.srt")
    if err != nil {
        panic(err)
    }

    // 调整时间：整体延迟 2 秒
    subs.Add(time.Second * 2)

    // 保存为 WebVTT 格式
    err = subs.Write("output.vtt")
    if err != nil {
        panic(err)
    }
}
```

---

## 适用场景

- 视频处理工具：集成到视频转码、剪辑工具中自动调整字幕。
- 多语言支持：批量转换字幕格式以适应不同播放平台。
- 字幕修正：修复时间轴不同步问题或合并多语言字幕。

---

## 项目亮点

- 模块化设计：每个字幕格式有独立处理模块（如 `srt.go`、`ttml.go`），易于扩展。
- 测试覆盖：提供完备的测试用例（`*_test.go`），稳定性较高。
- MIT 协议：允许商业使用和修改，无法律风险。

---
## 注意事项

- 错误处理：示例代码省略错误处理，实际使用需检查返回值（如文件解析失败）。
- 格式特性差异：转换时可能丢失高级样式（如 ASS 的特效），建议在支持最完整格式的 TTML 或 ASS 中编辑。

---

## 总结

`go-astisub` 是 Go 生态中处理字幕的瑞士军刀，适合需要高可靠性字幕操作的场景。其简洁的 API 和多格式支持使其成为开发视频相关应用的理想选择。对于更复杂的字幕样式需求，建议结合专业工具（如 FFmpeg）使用。


GitHub 地址：[asticode/go-astisub](https://github.com/asticode/go-astisub)  
推荐指数：★★★★☆（字幕处理需求的 Go 开发者必备）

