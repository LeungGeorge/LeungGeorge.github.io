---
uuid: ac352250-7baf-11ed-b37c-03c540ef5f86
title: effective-go chapter9
tags:
  - writing
categories:
  - effective-go
comments: true
keywords: post
date: 2022-12-14 21:03:15
description:
---

<!--more-->
<!-- 1. 发布前：删除草稿的 uuid -->
<!-- 2. 发布后：补充tag，category -->

## Methods<font color=silver>&#124; </font> 方法

### Pointers vs. Values<font color=silver>&#124; </font> 指针与值 

As we saw with `ByteSize` , methods can be defined for any named type \(except a pointer or an interface\); the receiver does not have to be a struct.

> 正如我们在 `ByteSize` 中看到的，可以为任何命名类型（除了指针或接口）定义方法；接收者不必是一个结构体。

In the discussion of slices above, we wrote an `Append` function. We can define it as a method on slices instead. To do this, we first declare a named type to which we can bind the method, and then make the receiver for the method a value of that type.

> 在上面对切片的讨论中，我们编写了一个 `Append` 函数。我们可以将其定义为切片上的方法。为此，我们首先声明一个可以将方法绑定到的命名类型，然后将方法的接收者设为该类型的值。

```go
type ByteSlice []byte

func (slice ByteSlice) Append(data []byte) []byte {
    // Body exactly the same as the Append function defined above.
}
```

This still requires the method to return the updated slice. We can eliminate that clumsiness by redefining the method to take apointerto a `ByteSlice` as its receiver, so the method can overwrite the caller's slice.

> 这仍然需要方法返回更新后的切片。我们可以通过重新定义方法以将指向 `ByteSlice` 的指针作为其接收者来消除这种笨拙，因此该方法可以覆盖调用者的切片。

```go
func (p *ByteSlice) Append(data []byte) {
    slice := *p
    // Body as above, without the return.
    *p = slice
}
```

In fact, we can do even better. If we modify our function so it looks like a standard `Write` method, like this, 

> 事实上，我们可以做得更好。如果我们修改我们的函数，使它看起来像一个标准的 `Write` 方法，像这样，

```go
func (p *ByteSlice) Write(data []byte) (n int, err error) {
    slice := *p
    // Again as above.
    *p = slice
    return len(data), nil
}
```

then the type `*ByteSlice` satisfies the standard interface `io.Writer` , which is handy. For instance, we can print into one.

> 那么 `*ByteSlice` 类型满足标准接口 `io.Writer` ，这就很方便了。例如，我们可以打印成一个。

```go
    var b ByteSlice
    fmt.Fprintf(&b, "This hour has %d days\n", 7)
```

We pass the address of a `ByteSlice` because only `*ByteSlice` satisfies `io.Writer` . The rule about pointers vs. values for receivers is that value methods can be invoked on pointers and values, but pointer methods can only be invoked on pointers.

> 我们传递 `ByteSlice` 的地址，因为只有 `*ByteSlice` 满足 `io.Writer` 。接收者是指针与值的规则是：值方法可以在指针和值上调用，但指针方法只能在指针上调用。

This rule arises because pointer methods can modify the receiver; invoking them on a value would cause the method to receive a copy of the value, so any modifications would be discarded. The language therefore disallows this mistake. There is a handy exception, though. When the value is addressable, the language takes care of the common case of invoking a pointer method on a value by inserting the address operator automatically. In our example, the variable `b` is addressable, so we can call its `Write` method with just `b.Write` . The compiler will rewrite that to `(&b).Write` for us.

> 出现这个规则是因为指针方法可以修改接收者；在一个值上调用它们会导致该方法接收的是该值的副本，因此任何修改都将被丢弃。因此，该语言不允许这种错误。不过，有一个方便的例外。当值是可寻址的时，该语言通过自动插入地址运算符来处理对值调用指针方法的常见情况。在我们的示例中，变量 `b` 是可寻址的，因此我们可以仅使用 `b.Write` 调用它的 `Write` 方法。编译器将为我们将其重写为 `(&b).Write` 。

By the way, the idea of using `Write` on a slice of bytes is central to the implementation of `bytes.Buffer` .

> 顺便说一句，在 `bytes` 切片上使用 `Write` 的想法是 `bytes.Buffer` 实现的核心。


---
![20200131220947.png](images/leunggeorge.github.io-image-9.png)
