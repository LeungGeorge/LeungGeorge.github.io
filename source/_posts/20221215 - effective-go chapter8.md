---
uuid: aa1b4300-7baf-11ed-bc99-2f584511b012
title: effective-go chapter8
tags:
  - writing
categories:
  - effective-go
comments: true
keywords: post
date: 2022-12-14 21:03:12
description:
---

<!--more-->
<!-- 1. 发布前：删除草稿的 uuid -->
<!-- 2. 发布后：补充tag，category -->

## Initialization<font color=silver>&#124; </font> 初始化

Although it doesn't look superficially very different from initialization in C or C++, initialization in Go is more powerful. Complex structures can be built during initialization and the ordering issues among initialized objects, even among different packages, are handled correctly.

> 虽然从表面上看起来，它与 `C` 或 `C++` 的初始化没有太大的区别，但是 `Go` 的初始化更加强大。复杂的结构体可以在初始化期间构建，初始化对象之间的顺序问题，甚至不同包之间的顺序问题，都能得到正确的处理。

### Constants<font color=silver>&#124; </font> 常量

Constants in Go are just that—constant. They are created at compile time, even when defined as locals in functions, and can only be numbers, characters \(runes\), strings or booleans. Because of the compile-time restriction, the expressions that define them must be constant expressions, evaluatable by the compiler. For instance, `1<<3` is a constant expression, while `math.Sin(math.Pi/4)` is not because the function call to `math.Sin` needs to happen at run time.

> Go 中的常量就是常数。它们是在编译时创建的，即使在函数中定义的局部变量，也只能是数字、字符（runes）、字符串或布尔值。由于编译时的限制，定义它们的表达式必须是可由编译器计算的常量表达式。例如， `1<<3` 是一个常量表达式，而 `math.Sin(math.Pi/4)` 不是，因为对 `math.Sin` 的函数调用需要在运行时发生。

In Go, enumerated constants are created using the `iota` enumerator. Since `iota` can be part of an expression and expressions can be implicitly repeated, it is easy to build intricate sets of values.

> 在 Go 中，枚举常量是使用 `iota` 枚举器创建的。 由于 `iota` 可以是表达式的一部分，并且表达式可以隐式重复，因此很容易构建复杂的值集。

```go
type ByteSize float64

const (
    _           = iota // ignore first value by assigning to blank identifier
    KB ByteSize = 1 << (10 * iota)
    MB
    GB
    TB
    PB
    EB
    ZB
    YB
)
```

The ability to attach a method such as `String` to any user-defined type makes it possible for arbitrary values to format themselves automatically for printing. Although you'll see it most often applied to structs, this technique is also useful for scalar types such as floating-point types like `ByteSize` .

> 将诸如 `String` 之类的方法附加到任何用户定义的类型的能力，使得任意值可以自动格式化以进行打印。 尽管您会看到它最常应用于结构体，但这种技术也适用于标量类型，例如 `ByteSize` 之类的浮点类型。

```go
func (b ByteSize) String() string {
    switch {
    case b >= YB:
        return fmt.Sprintf("%.2fYB", b/YB)
    case b >= ZB:
        return fmt.Sprintf("%.2fZB", b/ZB)
    case b >= EB:
        return fmt.Sprintf("%.2fEB", b/EB)
    case b >= PB:
        return fmt.Sprintf("%.2fPB", b/PB)
    case b >= TB:
        return fmt.Sprintf("%.2fTB", b/TB)
    case b >= GB:
        return fmt.Sprintf("%.2fGB", b/GB)
    case b >= MB:
        return fmt.Sprintf("%.2fMB", b/MB)
    case b >= KB:
        return fmt.Sprintf("%.2fKB", b/KB)
    }
    return fmt.Sprintf("%.2fB", b)
}
```

The expression `YB` prints as `1.00YB` , while `ByteSize(1e13)` prints as `9.09TB` .

> 表达式 `YB` 打印为 `1.00YB` ，而 `ByteSize(1e13)` 打印为 `9.09TB` 。

The use here of `Sprintf` to implement `ByteSize` 's `String` method is safe \(avoids recurring indefinitely\) not because of a conversion but because it calls `Sprintf` with `%f` , which is not a string format: `Sprintf` will only call the `String` method when it wants a string, and `%f` wants a floating-point value.

> 在这里使用 `Sprintf` 来实现 `ByteSize` 的 `String` 方法是安全的（避免无限重复），不是因为转换，而是因为它使用 `%f` 调用 `Sprintf` ，它不是字符串格式： `Sprintf` 只会在需要字符串时调用 `String` 方法，而 `%f` 需要浮点值。

### Variables<font color=silver>&#124; </font> 变量

Variables can be initialized just like constants but the initializer can be a general expression computed at run time.

> 变量可以像常量一样被初始化，但初始化器可以是在运行时计算的通用表达式。

```go
var (
    home   = os.Getenv("HOME")
    user   = os.Getenv("USER")
    gopath = os.Getenv("GOPATH")
)
```

### The init function<font color=silver>&#124; </font> init 方法

Finally, each source file can define its own niladic `init` function to set up whatever state is required. \(Actually each file can have multiple `init` functions.\) And finally means finally: `init` is called after all the variable declarations in the package have evaluated their initializers, and those are evaluated only after all the imported packages have been initialized.

> 最后，每个源文件都可以定义自己的无参数 `init` 函数来设置所需的任何状态。（实际上每个文件可以有多个 `init` 函数。）finally 的意思是： `init` 在包中的所有变量声明都评估了它们的初始值设定项之后被调用，并且只有在所有导入的包都被评估后才被评估初始化。

Besides initializations that cannot be expressed as declarations, a common use of `init` functions is to verify or repair correctness of the program state before real execution begins.

> 除了不能表示为声明的初始化之外， `init` 函数的一个常见用途是在实际执行开始之前验证或修复程序状态的正确性。

```go
func init() {
    if user == "" {
        log.Fatal("$USER not set")
    }
    if home == "" {
        home = "/home/" + user
    }
    if gopath == "" {
        gopath = home + "/go"
    }
    // gopath may be overridden by --gopath flag on command line.
    flag.StringVar(&gopath, "gopath", gopath, "override default GOPATH")
}
```


---
![20200131220947.png](source/_posts/assets/images/leunggeorge.github.io-image-9%201.png)
