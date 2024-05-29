---
uuid: ae6f81f0-7baf-11ed-a5e1-2338ebbe8389
title: effective-go chapter10
tags:
  - writing
categories:
  - effective-go
comments: true
keywords: post
date: 2022-12-14 21:03:19
description:
---

<!--more-->
<!-- 1. 发布前：删除草稿的 uuid -->
<!-- 2. 发布后：补充tag，category -->

## Interfaces and other types <font color=silver>&#124; </font> 接口与其他类型

### Interfaces <font color=silver>&#124; </font> 接口

Interfaces in Go provide a way to specify the behavior of an object: if something can do *this*, then it can be used *here*. We've seen a couple of simple examples already; custom printers can be implemented by a `String` method while `Fprintf` can generate output to anything with a `Write` method. Interfaces with only one or two methods are common in Go code, and are usually given a name derived from the method, such as `io.Writer` for something that implements `Write`.

> Go 中的接口提供了一种指定对象行为的方法：如果有东西可以做到这一点，那么它就可以在这里使用。我们已经看过几个简单的例子；自定义打印函数可以通过 String 方法实现，而 Fprintf 可以使用 Write 方法生成任何输出。只有一两个方法的接口在 Go 代码中很常见，并且通常被赋予从方法派生的名称，例如 io.Writer 表示实现了 Write 的一类对象。

A type can implement multiple interfaces. For instance, a collection can be sorted by the routines in package `sort` if it implements `sort.Interface` , which contains `Len()` , `Less(i, j int) bool` , and `Swap(i, j int)` , and it could also have a custom formatter. In this contrived example `Sequence` satisfies both.

> 一个类型可以实现多个接口。例如，如果集合实现了 `sort.Interface` 接口，就可以通过 `sort` 包中的例程对其进行排序，接口包含`Len()`、`Less(i, j int) bool` 和 `Swap(i, j int)` ，它也可以有一个自定义的格式化程序。
>
> 一个类型可以实现多个接口。例如，如果集合实现了 `sort.Interface` 包，则可以通过 `sort` 包中的例程对集合进行排序，其中包含 `Len()`、`Less(i, j int) bool` 和 `Swap(i, j int)` ，它也可以有一个自定义的格式化程序。以下构造的例子中，`Sequence` 满足两种情况。

```go
type Sequence []int

// Methods required by sort.Interface.
func (s Sequence) Len() int {
    return len(s)
}
func (s Sequence) Less(i, j int) bool {
    return s[i] < s[j]
}
func (s Sequence) Swap(i, j int) {
    s[i], s[j] = s[j], s[i]
}

// Method for printing - sorts the elements before printing.
func (s Sequence) String() string {
    sort.Sort(s)
    str := "["
    for i, elem := range s {
        if i > 0 {
            str += " "
        }
        str += fmt.Sprint(elem)
    }
    return str + "]"
}
```

### Conversions <font color=silver>&#124; </font> 转换

The `String` method of `Sequence` is recreating the work that `Sprint` already does for slices. We can share the effort if we convert the `Sequence` to a plain `[]int` before calling `Sprint` .

>  `Sequence` 的 `String`方法重新实现了 `Sprint`为切片实现的功能。如果我们在调用`Sprint`前把 `Sequence` 转为纯粹的 []int，就可以共享之前的功能。

```go
func (s Sequence) String() string {
    sort.Sort(s)
    return fmt.Sprint([]int(s))
}
```

This method is another example of the conversion technique for calling `Sprintf` safely from a `String` method. Because the two types \( `Sequence` and `[]int` \) are the same if we ignore the type name, it's legal to convert between them. The conversion doesn't create a new value, it just temporarily acts as though the existing value has a new type. \(There are other legal conversions, such as from integer to floating point, that do create a new value.\)

> 该方法是转换技术的另一个例子，在 `String` 方法中安全地调用`Sprintf` 。如果我们忽略类型名的话，其实这两种类型（ `Sequence` and `[]int`）是相同的，因此它们之间是可以相互转换的。转换并不会创建新的值，它只是暂时让现在的值看起来有一个新类型而已。（也有一些会创建新值的合法转换，如从整数转为浮点数。）

It's an idiom in Go programs to convert the type of an expression to access a different set of methods. As an example, we could use the existing type `sort.IntSlice` to reduce the entire example to this:

> 在Go语言中，访问不同方法集时进行类型转换是一种习惯用法。例如，我们可以用现有类型 `sort.IntSlice` 来简化整个例子。

```go
type Sequence []int

// Method for printing - sorts the elements before printing
func (s Sequence) String() string {
    sort.IntSlice(s).Sort()
    return fmt.Sprint([]int(s))
}
```

Now, instead of having `Sequence` implement multiple interfaces \(sorting and printing\), we're using the ability of a data item to be converted to multiple types \( `Sequence` , `sort.IntSlice` and `[]int` \), each of which does some part of the job. That's more unusual in practice but can be effective.

> 现在，不必为`Sequence` 实现多个接口（sorting and printing），我们可以通过将数据项转换为多种类型（`Sequence` , `sort.IntSlice` and `[]int`），每个完成其一部分工作。在实践中虽不多见，却往往很高效。

### Interface conversions and type assertions <font color=silver>&#124; </font> 接口转换和类型断言

[Type switches](https://docs.huihoo.com/go/golang.org/doc/effective_go.html#type_switch) are a form of conversion: they take an interface and, for each case in the switch, in a sense convert it to the type of that case. Here's a simplified version of how the code under `fmt.Printf` turns a value into a string using a type switch. If it's already a string, we want the actual string value held by the interface, while if it has a `String` method we want the result of calling the method.

> 类型选择是一种转换形式，他们接收一个接口，在选择语句中转换为条件对应的类型。以下是`fmt.Printf`的简化代码，它使用类型转换将值转换成一个字符串。如果它已经是一个字符串，我们需要接口中的实际字符串值，而如果它有一个`String`方法，我们需要调用该方法的结果。
>

```go
type Stringer interface {
    String() string
}

var value interface{} // Value provided by caller.
switch str := value.(type) {
case string:
    return str
case Stringer:
    return str.String()
}
```

The first case finds a concrete value; the second converts the interface into another interface. It's perfectly fine to mix types this way.

> 第一种情况是获取具体值；第二种则转换为一个新接口。对于混合类型这种方式非常好。

What if there's only one type we care about? If we know the value holds a `string` and we just want to extract it? A one-case type switch would do, but so would a_type assertion_. A type assertion takes an interface value and extracts from it a value of the specified explicit type. The syntax borrows from the clause opening a type switch, but with an explicit type rather than the `type` keyword:

> 如果我们只关心一种类型呢？如果我们知道它的值是个字符串，而我们只想提取它呢？一个 case 的 switch 可以实现，类型断言也可以。类型断言采用接口值并从中提取指定显式类型的值。该语法借鉴了一个 case 的 switch 子句，但使用了显式类型而不是`type`关键字：

```go
value.(typeName)
```

and the result is a new value with the static type `typeName` . That type must either be the concrete type held by the interface, or a second interface type that the value can be converted to. To extract the string we know is in the value, we could write:

> 结果是一个静态类型为 `typeName` 的新值。该类型必须是接口持有的具体类型，或者是值可以转换的第二种接口类型。要提取其中的字符串，我们可以这样写：

```go
str := value.(string)
```

But if it turns out that the value does not contain a string, the program will crash with a run-time error. To guard against that, use the "comma, ok" idiom to test, safely, whether the value is a string:

> 如果事实上值中不包含字符串，程序就会崩溃并报运行时错误。为防止这种情况，使用"逗号, ok"习语来安全地测试值是否为字符串：

```go
str, ok := value.(string)
if ok {
    fmt.Printf("string value is: %q\n", str)
} else {
    fmt.Printf("value is not a string\n")
}
```

If the type assertion fails, `str` will still exist and be of type string, but it will have the zero value, an empty string.

> 如果类型断言失败了， `str` 仍然存在并且是一个字符串类开，但它将是零值，一个空字符串。

As an illustration of the capability, here's an `if` - `else` statement that's equivalent to the type switch that opened this section.

> 为了说明这个功能，来看下这个`if-else`语句，它等同于前面的swith

```go
if str, ok := value.(string); ok {
    return str
} else if str, ok := value.(Stringer); ok {
    return str.String()
}
```

### Generality <font color=silver>&#124; </font> 

If a type exists only to implement an interface and will never have exported methods beyond that interface, there is no need to export the type itself. Exporting just the interface makes it clear the value has no interesting behavior beyond what is described in the interface. It also avoids the need to repeat the documentation on every instance of a common method.

In such cases, the constructor should return an interface value rather than the implementing type. As an example, in the hash libraries both `crc32.NewIEEE` and `adler32.New` return the interface type `hash.Hash32` . Substituting the CRC-32 algorithm for Adler-32 in a Go program requires only changing the constructor call; the rest of the code is unaffected by the change of algorithm.

A similar approach allows the streaming cipher algorithms in the various `crypto` packages to be separated from the block ciphers they chain together. The `Block` interface in the `crypto/cipher` package specifies the behavior of a block cipher, which provides encryption of a single block of data. Then, by analogy with the `bufio` package, cipher packages that implement this interface can be used to construct streaming ciphers, represented by the `Stream` interface, without knowing the details of the block encryption.

The `crypto/cipher` interfaces look like this:

```go
type Block interface {
    BlockSize() int
    Encrypt(src, dst []byte)
    Decrypt(src, dst []byte)
}

type Stream interface {
    XORKeyStream(dst, src []byte)
}
```

Here's the definition of the counter mode \(CTR\) stream, which turns a block cipher into a streaming cipher; notice that the block cipher's details are abstracted away:

```go
// NewCTR returns a Stream that encrypts/decrypts using the given Block in
// counter mode. The length of iv must be the same as the Block's block size.
func NewCTR(block Block, iv []byte) Stream
```

`NewCTR` applies not just to one specific encryption algorithm and data source but to any implementation of the `Block` interface and any `Stream` . Because they return interface values, replacing CTR encryption with other encryption modes is a localized change. The constructor calls must be edited, but because the surrounding code must treat the result only as a `Stream` , it won't notice the difference.

### Interfaces and methods <font color=silver>&#124; </font> 

Since almost anything can have methods attached, almost anything can satisfy an interface. One illustrative example is in the `http` package, which defines the `Handler` interface. Any object that implements `Handler` can serve HTTP requests.

```go
type Handler interface {
    ServeHTTP(ResponseWriter, *Request)
}
```

`ResponseWriter` is itself an interface that provides access to the methods needed to return the response to the client. Those methods include the standard `Write` method, so an `http.ResponseWriter` can be used wherever an `io.Writer` can be used. `Request` is a struct containing a parsed representation of the request from the client.

For brevity, let's ignore POSTs and assume HTTP requests are always GETs; that simplification does not affect the way the handlers are set up. Here's a trivial but complete implementation of a handler to count the number of times the page is visited.

```go
// Simple counter server.
type Counter struct {
    n int
}

func (ctr *Counter) ServeHTTP(w http.ResponseWriter, req *http.Request) {
    ctr.n++
    fmt.Fprintf(w, "counter = %d\n", ctr.n)
}
```

\(Keeping with our theme, note how `Fprintf` can print to an `http.ResponseWriter` .\) For reference, here's how to attach such a server to a node on the URL tree.

```go
import "net/http"
...
ctr := new(Counter)
http.Handle("/counter", ctr)
```

But why make `Counter` a struct? An integer is all that's needed. \(The receiver needs to be a pointer so the increment is visible to the caller.\)

```go
// Simpler counter server.
type Counter int

func (ctr *Counter) ServeHTTP(w http.ResponseWriter, req *http.Request) {
    *ctr++
    fmt.Fprintf(w, "counter = %d\n", *ctr)
}
```

What if your program has some internal state that needs to be notified that a page has been visited? Tie a channel to the web page.

```go
// A channel that sends a notification on each visit.
// (Probably want the channel to be buffered.)
type Chan chan *http.Request

func (ch Chan) ServeHTTP(w http.ResponseWriter, req *http.Request) {
    ch <- req
    fmt.Fprint(w, "notification sent")
}
```

Finally, let's say we wanted to present on `/args` the arguments used when invoking the server binary. It's easy to write a function to print the arguments.

```go
func ArgServer() {
    fmt.Println(os.Args)
}
```

How do we turn that into an HTTP server? We could make `ArgServer` a method of some type whose value we ignore, but there's a cleaner way. Since we can define a method for any type except pointers and interfaces, we can write a method for a function. The `http` package contains this code:

```go
// The HandlerFunc type is an adapter to allow the use of
// ordinary functions as HTTP handlers.  If f is a function
// with the appropriate signature, HandlerFunc(f) is a
// Handler object that calls f.
type HandlerFunc func(ResponseWriter, *Request)

// ServeHTTP calls f(w, req).
func (f HandlerFunc) ServeHTTP(w ResponseWriter, req *Request) {
    f(w, req)
}
```

`HandlerFunc` is a type with a method, `ServeHTTP` , so values of that type can serve HTTP requests. Look at the implementation of the method: the receiver is a function, `f` , and the method calls `f` . That may seem odd but it's not that different from, say, the receiver being a channel and the method sending on the channel.

To make `ArgServer` into an HTTP server, we first modify it to have the right signature.

```go
// Argument server.
func ArgServer(w http.ResponseWriter, req *http.Request) {
    fmt.Fprintln(w, os.Args)
}
```

`ArgServer` now has same signature as `HandlerFunc` , so it can be converted to that type to access its methods, just as we converted `Sequence` to `IntSlice` to access `IntSlice.Sort` . The code to set it up is concise:

```go
http.Handle("/args", http.HandlerFunc(ArgServer))
```

When someone visits the page `/args` , the handler installed at that page has value `ArgServer` and type `HandlerFunc` . The HTTP server will invoke the method `ServeHTTP` of that type, with `ArgServer` as the receiver, which will in turn call `ArgServer` \(via the invocation `f(w, req)` inside `HandlerFunc.ServeHTTP` \). The arguments will then be displayed.

In this section we have made an HTTP server from a struct, an integer, a channel, and a function, all because interfaces are just sets of methods, which can be defined for \(almost\) any type.


---
![20200131220947.png](source/_posts/images/leunggeorge.github.io-image-9.png)
