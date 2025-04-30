---
tags:
  - note
  - Golang
  - blog
  - 每日一库
  - DONE
categories:
  - essay
date: 2025-04-30
description: 
share: "true"
title: 
comments: true
---
## 1. 库简介 

Excelize 是用 Go 语言编写的开源库，专注于处理 Excel 文件（XLSX 格式）。由 qax-os 组织维护，支持创建、读取、编辑复杂 Excel 文档，适用于报表生成、数据导入导出等场景。

[GitHub - qax-os/excelize: Go language library for reading and writing Microsoft Excel™ (XLAM / XLSM / XLSX / XLTM / XLTX) spreadsheets](https://github.com/qax-os/excelize)

![](assets/images/IMG-63D0ABAB64CBAEB70F1CD383BC8B0939.png)


## 2. 核心功能  

- **基础操作**：创建/保存文件、增删工作表、读写单元格数据。  
- **样式设置**：自定义字体、颜色、边框、对齐方式等，支持合并单元格。  
- **高级元素**：插入图表（柱状图、折线图等）、图片、公式计算。  
- **数据处理**：数据验证（如下拉列表）、条件格式、数据透视表。  
- **流式 API**：处理大数据时通过 `StreamWriter` 逐行写入，降低内存占用。  
- **并发安全**：API 设计支持多 Goroutine 并发操作，适合高并发场景。  

## 3. 快速入门示例  

```go
package main

import (
    "fmt"
    "github.com/xuri/excelize/v2"
)

func main() {
    f := excelize.NewFile()
    defer f.Close()
    // 创建新Sheet并写入数据
    index, _ := f.NewSheet("Sheet2")
    f.SetCellValue("Sheet1", "A1", "Hello")
    f.SetCellValue("Sheet2", "B2", 123)
    f.SetActiveSheet(index)
    if err := f.SaveAs("Book1.xlsx"); err != nil {
        fmt.Println("保存失败:", err)
    }
}
```

## 4. 高级特性  

- **样式定义**：通过 `NewStyle` 创建样式对象，应用至单元格：  
  ```go
  style, _ := f.NewStyle(&excelize.Style{Font: &excelize.Font{Bold: true}})
  f.SetCellStyle("Sheet1", "A1", "A1", style)
  ```
  
- **插入图表**：指定数据范围生成图表：  
  ```go
  f.AddChart("Sheet1", "E1", `{...}`) // JSON 配置图表参数
  ```
  
- **流式写入**：高效处理大数据：  
  ```go
  streamWriter, _ := f.NewStreamWriter("Sheet1")
  for row := 1; row <= 10000; row++ {
      cell, _ := excelize.CoordinatesToCellName(1, row)
      streamWriter.SetRow(cell, []interface{}{fmt.Sprintf("Row %d", row)})
  }
  streamWriter.Flush()
  ```

**添加三维簇状柱形图​**​：

```go
chart := &excelize.Chart{
    Type: excelize.Col3DClustered,
    Series: []excelize.ChartSeries{
        {Name: "Sheet1!$A$2", Categories: "Sheet1!$B$1:$D$1", Values: "Sheet1!$B$2:$D$2"},
        // 添加更多数据系列...
    },
    Title: []excelize.RichTextRun{{Text: "Fruit Sales Analysis"}},
}
f.AddChart("Sheet1", "E1", chart)
```

​**​插入图片（支持缩放与打印设置）​**​：

```go
err := f.AddPicture("Sheet1", "A2", "image.png", &excelize.GraphicOptions{
    ScaleX: 0.5, 
    ScaleY: 0.5,
    PrintObject: &enable,  // 控制是否可打印
})
```

## 5. 优势与适用场景  

- **功能全面**：覆盖 Excel 操作几乎所有需求，从基础到高级功能。  
- **高性能**：流式 API 和并发安全设计优化资源使用。  
- **易用性**：API 设计简洁，文档详尽，社区活跃（GitHub 19k+ Star）。  
- **适用场景**：Web 后端数据导出、自动化报表、数据分析工具等。

## 6. 对比与选型  

相较于 `tealeg/xlsx`，Excelize 更新更活跃，支持更多新特性（如公式、数据透视表）。若项目需复杂 Excel 操作或高性能处理，推荐优先选择 Excelize。

## 7. 总结  

Excelize 是 Go 生态中处理 Excel 的首选库，平衡了功能丰富性与性能，适合各类需要高效操作 Excel 文件的场景。通过其清晰的 API 和强大功能，开发者能轻松实现复杂的电子表格交互需求。

