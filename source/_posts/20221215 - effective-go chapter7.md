---
uuid: a75ee220-7baf-11ed-b066-81409bde4fc5
title: effective-go chapter7
tags:
  - writing
categories:
  - effective-go
comments: true
keywords: post
date: 2022-12-14 21:03:07
description:
---

<!--more-->
<!-- 1. 发布前：删除草稿的 uuid -->
<!-- 2. 发布后：补充tag，category -->

# 数据（Data）

## 使用 `new` 分配 （Allocation with `new` ）

`Go` 有两个分配原语。内置函数 `new` 和 `make` 。它们会干不同的事情，分配不同的类型，虽然有点迷惑人，但区分规则很简单。我们先来说 `new` 。它是一个内置的分配内存的函数，但它在其他语言中的同名兄弟，它不会初始化内存，仅仅是初始为零值。也就是说， `new(T)` 分配了一个类型为T的条目，并且被初始化为零值的存储空间，并返回它的地址，类型为 `*T` 。在Go的术语中，它返回了一个指针，指向类型为 `T` 的新分配的零值。

> Go has two allocation primitives, the built-in functions new and make. They do different things and apply to different types, which can be confusing, but the rules are simple. Let's talk about new first. It's a built-in function that allocates memory, but unlike its namesakes in some other languages it does not initialize the memory, it only zeros it. That is, new\(T\) allocates zeroed storage for a new item of type T and returns its address, a value of type \*T. In Go terminology, it returns a pointer to a newly allocated zero value of type T.

由于 `new` 返回的内存是零值，这会有助于设计你的数据结构，每个类型的零值都可以直接使用，无需额外初始化操作。这意味着，结构体的使用者可以直接使用 `new` 创建，并可以直接使用。例如， `bytes.Bufer` 的文档中说 `Buffer` 的零值是一个空的待用的缓存。类似的， `sync.Mutex` 没有显式构造或者初始化方法。相反的， `sync.Mutex` 的零值被定义为一个未加锁的互斥量。

> Since the memory returned by new is zeroed, it's helpful to arrange when designing your data structures that the zero value of each type can be used without further initialization. This means a user of the data structure can create one with new and get right to work. For example, the documentation for `bytes.Buffer` states that "the zero value for Buffer is an empty buffer ready to use." Similarly, `sync.Mutex` does not have an explicit constructor or Init method. Instead, the zero value for a `sync.Mutex` is defined to be an unlocked mutex.

零值的属性是可以传递的，请看如下类型声明：

> The zero-value-is-useful property works transitively. Consider this type declaration.

```go
type SyncedBuffer struct {
    lock    sync.Mutex
    buffer  bytes.Buffer
}
```

`SyncedBuffer` 类型的值也可以在分配或者声明时立即使用。在下一个片段， `p` 和 `v` 无需进一步的处理即可正常使用。

> Values of type `SyncedBuffer` are also ready to use immediately upon allocation or just declaration. In the next snippet, both p and v will work correctly without further arrangement.

```go
p := new(SyncedBuffer)  // type *SyncedBuffer
var v SyncedBuffer      // type  SyncedBuffer
```

### 构造函数和复合文字

有时候，零值并不是很好，这时一个初始化构造函数就很有必要了，就如同这个从 `os` 包中提取的例子。

> Sometimes the zero value isn't good enough and an initializing constructor is necessary, as in this example derived from package os.

```go
func NewFile(fd int, name string) *File {
    if fd < 0 {
        return nil
    f := new(File)
    f.fd = fd
    f.name = name
    f.dirinfo = nil
    f.nepipe = 0
    return f
}
```

这里有很多的示例。我们可以使用复合文字简化它，即，使用一个表达式创建一个新实例。

> There's a lot of boiler plate in there. We can simplify it using a composite literal, which is an expression that creates a new instance each time it is evaluated.

```go
func NewFile(fd int, name string) *File {
    if fd < 0 {
        return nil
    }
    f := File{fd, name, nil, 0}
    return &f
}
```

注意，与 `C` 不同，在 `Go` 中返回局部变量的地址是完全没问题的，与变量相关的存储在函数返回后不会释放。事实上，获取复合文字的地址时，每个新的实例有一个地址，因此我们可以把最后两行合并起来。

> Note that, unlike in C, it's perfectly OK to return the address of a local variable; the storage associated with the variable survives after the function returns. In fact, taking the address of a composite literal allocates a fresh instance each time it is evaluated, so we can combine these last two lines.

```go
    return &File{fd, name, nil, 0}
```

复合文字的字段按序列出，并且所有字段都要使用到。然而，通过显式的成对列出字段名：字段值，就可以以任意次序初始化了（不再受次序限制），没列出的将会被设置为各自的零值。因此，可以写成这样：

> The fields of a composite literal are laid out in order and must all be present. However, by labeling the elements explicitly as field `:` value pairs, the initializers can appear in any order, with the missing ones left as their respective zero values. Thus we could say

```go
 return &File{fd: fd, name: name}
```

一个极端的情况，若复合文字中不包含任何字段，它会创建为这个类型的零值。表达式 `new(File)和&File{}` 是等值的。

复合文字也可以用来创建arrays，slices 和 maps，字段标号使用索引或 map key。再这些例子中，不论 `Enone` 、 `Eio` 和 `Einval` 的取值如何，只要不同即可初始化。

> As a limiting case, if a composite literal contains no fields at all, it creates a zero value for the type. The expressions `new(File)` and `&File{}` are equivalent.
>
> Composite literals can also be created for arrays, slices, and maps, with the field labels being indices or map keys as appropriate. In these examples, the initializations work regardless of the values of `Enone` , `Eio` , and `Einval` , as long as they are distinct.

```go
a := [...]string   {Enone: "no error", Eio: "Eio", Einval: "invalid argument"}
s := []string      {Enone: "no error", Eio: "Eio", Einval: "invalid argument"}
m := map[int]string{Enone: "no error", Eio: "Eio", Einval: "invalid argument"}
```

### 用make分配

说到（资源）分配。内置函数 `make(T, args)` 与 `new(T)` 的作用略有不同。 `make` 仅用来创建 slices, maps, and channels

> Back to allocation. The built-in function `make(T,args)` serves a purpose different from `new(T)` . It creates slices, maps, and channels only, and it returns an _initialized_ (not _zeroed_) value of type `T` (not `*T` ). The reason for the distinction is that these three types represent, under the covers, references to data structures that must be initialized before use. A slice, for example, is a three-item descriptor containing a pointer to the data \(inside an array\), the length, and the capacity, and until those items are initialized, the slice is `nil` . For slices, maps, and channels, `make` initializes the internal data structure and prepares the value for use. For instance, 

```go
make([]int, 10, 100)
```

allocates an array of 100 ints and then creates a slice structure with length 10 and a capacity of 100 pointing at the first 10 elements of the array. \(When making a slice, the capacity can be omitted; see the section on slices for more information.\) In contrast, `new([]int)` returns a pointer to a newly allocated, zeroed slice structure, that is, a pointer to a `nil` slice value.

These examples illustrate the difference between `new` and `make` .

```go
var p *[]int = new([]int)       // allocates slice structure; *p == nil; rarely useful
var v  []int = make([]int, 100) // the slice v now refers to a new array of 100 ints

// Unnecessarily complex:
var p *[]int = new([]int)
*p = make([]int, 100, 100)

// Idiomatic:
v := make([]int, 100)
```

Remember that `make` applies only to maps, slices and channels and does not return a pointer. To obtain an explicit pointer allocate with `new` or take the address of a variable explicitly.

### Arrays 

Arrays are useful when planning the detailed layout of memory and sometimes can help avoid allocation, but primarily they are a building block for slices, the subject of the next section. To lay the foundation for that topic, here are a few words about arrays.

There are major differences between the ways arrays work in Go and C. In Go, 

* Arrays are values. Assigning one array to another copies all the elements.
* In particular, if you pass an array to a function, it will receive a copy of the array, not a pointer to it.
* The size of an array is part of its type. The types`[10]int`and`[20]int`are distinct.

The value property can be useful but also expensive; if you want C-like behavior and efficiency, you can pass a pointer to the array.

```go
func Sum(a *[3]float64) (sum float64) {
    for _, v := range *a {
        sum += v
    }
    return
}

array := [...]float64{7.0, 8.5, 9.1}
x := Sum(&array)  // Note the explicit address-of operator
```

But even this style isn't idiomatic Go. Use slices instead.

### Slices 

Slices wrap arrays to give a more general, powerful, and convenient interface to sequences of data. Except for items with explicit dimension such as transformation matrices, most array programming in Go is done with slices rather than simple arrays.

Slices hold references to an underlying array, and if you assign one slice to another, both refer to the same array. If a function takes a slice argument, changes it makes to the elements of the slice will be visible to the caller, analogous to passing a pointer to the underlying array. A `Read` function can therefore accept a slice argument rather than a pointer and a count; the length within the slice sets an upper limit of how much data to read. Here is the signature of the `Read` method of the `File` type in package `os` :

```go
func (f *File) Read(buf []byte) (n int, err error)
```

The method returns the number of bytes read and an error value, if any. To read into the first 32 bytes of a larger buffer `buf` , slice\(here used as a verb\) the buffer.

```go
    n, err := f.Read(buf[0:32])
```

Such slicing is common and efficient. In fact, leaving efficiency aside for the moment, the following snippet would also read the first 32 bytes of the buffer.

```go
    var n int
    var err error
    for i := 0; i < 32; i++ {
        nbytes, e := f.Read(buf[i:i+1])  // Read one byte.
        if nbytes == 0 || e != nil {
            err = e
            break
        }
        n += nbytes
    }
```

The length of a slice may be changed as long as it still fits within the limits of the underlying array; just assign it to a slice of itself. Thecapacityof a slice, accessible by the built-in function `cap` , reports the maximum length the slice may assume. Here is a function to append data to a slice. If the data exceeds the capacity, the slice is reallocated. The resulting slice is returned. The function uses the fact that `len` and `cap` are legal when applied to the `nil` slice, and return 0.

```go
func Append(slice, data []byte) []byte {
    l := len(slice)
    if l + len(data) > cap(slice) {  // reallocate
        // Allocate double what's needed, for future growth.
        newSlice := make([]byte, (l+len(data))*2)
        // The copy function is predeclared and works for any slice type.
        copy(newSlice, slice)
        slice = newSlice
    }
    slice = slice[0:l+len(data)]
    copy(slice[l:], data)
    return slice
}
```

We must return the slice afterwards because, although `Append` can modify the elements of `slice` , the slice itself \(the run-time data structure holding the pointer, length, and capacity\) is passed by value.

The idea of appending to a slice is so useful it's captured by the `append` built-in function. To understand that function's design, though, we need a little more information, so we'll return to it later.

### Two-dimensional slices 

Go's arrays and slices are one-dimensional. To create the equivalent of a 2D array or slice, it is necessary to define an array-of-arrays or slice-of-slices, like this:

```go
type Transform [3][3]float64  // A 3x3 array, really an array of arrays.
type LinesOfText [][]byte     // A slice of byte slices.
```

Because slices are variable-length, it is possible to have each inner slice be a different length. That can be a common situation, as in our `LinesOfText` example: each line has an independent length.

```go
text := LinesOfText{
    []byte("Now is the time"),
    []byte("for all good gophers"),
    []byte("to bring some fun to the party."),
}
```

Sometimes it's necessary to allocate a 2D slice, a situation that can arise when processing scan lines of pixels, for instance. There are two ways to achieve this. One is to allocate each slice independently; the other is to allocate a single array and point the individual slices into it. Which to use depends on your application. If the slices might grow or shrink, they should be allocated independently to avoid overwriting the next line; if not, it can be more efficient to construct the object with a single allocation. For reference, here are sketches of the two methods. First, a line at a time:

```go
// Allocate the top-level slice.
picture := make([][]uint8, YSize) // One row per unit of y.
// Loop over the rows, allocating the slice for each row.
for i := range picture {
    picture[i] = make([]uint8, XSize)
}
```

And now as one allocation, sliced into lines:

```go
// Allocate the top-level slice, the same as before.
picture := make([][]uint8, YSize) // One row per unit of y.
// Allocate one large slice to hold all the pixels.
pixels := make([]uint8, XSize*YSize) // Has type []uint8 even though picture is [][]uint8.
// Loop over the rows, slicing each row from the front of the remaining pixels slice.
for i := range picture {
    picture[i], pixels = pixels[:XSize], pixels[XSize:]
}
```

### Maps 

Maps are a convenient and powerful built-in data structure that associate values of one type \(the_key_\) with values of another type \(the_element\_or\_value_\). The key can be of any type for which the equality operator is defined, such as integers, floating point and complex numbers, strings, pointers, interfaces \(as long as the dynamic type supports equality\), structs and arrays. Slices cannot be used as map keys, because equality is not defined on them. Like slices, maps hold references to an underlying data structure. If you pass a map to a function that changes the contents of the map, the changes will be visible in the caller.

Maps can be constructed using the usual composite literal syntax with colon-separated key-value pairs, so it's easy to build them during initialization.

```go
var timeZone = map[string]int{
    "UTC":  0*60*60,
    "EST": -5*60*60,
    "CST": -6*60*60,
    "MST": -7*60*60,
    "PST": -8*60*60,
}
```

Assigning and fetching map values looks syntactically just like doing the same for arrays and slices except that the index doesn't need to be an integer.

```go
offset := timeZone["EST"]
```

An attempt to fetch a map value with a key that is not present in the map will return the zero value for the type of the entries in the map. For instance, if the map contains integers, looking up a non-existent key will return `0` . A set can be implemented as a map with value type `bool` . Set the map entry to `true` to put the value in the set, and then test it by simple indexing.

```go
attended := map[string]bool{
    "Ann": true,
    "Joe": true,
    ...
}

if attended[person] { // will be false if person is not in the map
    fmt.Println(person, "was at the meeting")
}
```

Sometimes you need to distinguish a missing entry from a zero value. Is there an entry for `"UTC"` or is that 0 because it's not in the map at all? You can discriminate with a form of multiple assignment.

```go
var seconds int
var ok bool
seconds, ok = timeZone[tz]
```

For obvious reasons this is called the “comma ok” idiom. In this example, if `tz` is present, `seconds` will be set appropriately and `ok` will be true; if not, `seconds` will be set to zero and `ok` will be false. Here's a function that puts it together with a nice error report:

```go
func offset(tz string) int {
    if seconds, ok := timeZone[tz]; ok {
        return seconds
    }
    log.Println("unknown time zone:", tz)
    return 0
}
```

To test for presence in the map without worrying about the actual value, you can use the[blank identifier](https://golang.org/doc/effective_go.html#blank)\( `_` \) in place of the usual variable for the value.

```go
_, present := timeZone[tz]
```

To delete a map entry, use the `delete` built-in function, whose arguments are the map and the key to be deleted. It's safe to do this even if the key is already absent from the map.

```go
delete(timeZone, "PDT")  // Now on Standard Time
```

### Printing 

Formatted printing in Go uses a style similar to C's `printf` family but is richer and more general. The functions live in the `fmt` package and have capitalized names: `fmt.Printf` , `fmt.Fprintf` , `fmt.Sprintf` and so on. The string functions \( `Sprintf` etc.\) return a string rather than filling in a provided buffer.

You don't need to provide a format string. For each of `Printf` , `Fprintf` and `Sprintf` there is another pair of functions, for instance `Print` and `Println` . These functions do not take a format string but instead generate a default format for each argument. The `Println` versions also insert a blank between arguments and append a newline to the output while the `Print` versions add blanks only if the operand on neither side is a string. In this example each line produces the same output.

```go
fmt.Printf("Hello %d\n", 23)
fmt.Fprint(os.Stdout, "Hello ", 23, "\n")
fmt.Println("Hello", 23)
fmt.Println(fmt.Sprint("Hello ", 23))
```

The formatted print functions `fmt.Fprint` and friends take as a first argument any object that implements the `io.Writer` interface; the variables `os.Stdout` and `os.Stderr` are familiar instances.

Here things start to diverge from C. First, the numeric formats such as `%d` do not take flags for signedness or size; instead, the printing routines use the type of the argument to decide these properties.

```go
var x uint64 = 1<<64 - 1
fmt.Printf("%d %x; %d %x\n", x, x, int64(x), int64(x))
```

prints

```go
18446744073709551615 ffffffffffffffff; -1 -1
```

If you just want the default conversion, such as decimal for integers, you can use the catchall format `%v` \(for “value”\); the result is exactly what `Print` and `Println` would produce. Moreover, that format can print\_any\_value, even arrays, slices, structs, and maps. Here is a print statement for the time zone map defined in the previous section.

```go
fmt.Printf("%v\n", timeZone)  // or just fmt.Println(timeZone)
```

which gives output

```go
map[CST:-21600 PST:-28800 EST:-18000 UTC:0 MST:-25200]
```

For maps the keys may be output in any order, of course. When printing a struct, the modified format `%+v` annotates the fields of the structure with their names, and for any value the alternate format `%#v` prints the value in full Go syntax.

```go
type T struct {
    a int
    b float64
    c string
}
t := &T{ 7, -2.35, "abc\tdef" }
fmt.Printf("%v\n", t)
fmt.Printf("%+v\n", t)
fmt.Printf("%#v\n", t)
fmt.Printf("%#v\n", timeZone)
```

prints

```go
&{7 -2.35 abc   def}
&{a:7 b:-2.35 c:abc     def}
&main.T{a:7, b:-2.35, c:"abc\tdef"}
map[string] int{"CST":-21600, "PST":-28800, "EST":-18000, "UTC":0, "MST":-25200}
```

\(Note the ampersands.\) That quoted string format is also available through `%q` when applied to a value of type `string` or `[]byte` . The alternate format `%#q` will use backquotes instead if possible. \(The `%q` format also applies to integers and runes, producing a single-quoted rune constant.\) Also, `%x` works on strings, byte arrays and byte slices as well as on integers, generating a long hexadecimal string, and with a space in the format \( `% x` \) it puts spaces between the bytes.

Another handy format is `%T` , which prints the\_type\_of a value.

```go
fmt.Printf("%T\n", timeZone)
```

prints

```go
map[string] int
```

If you want to control the default format for a custom type, all that's required is to define a method with the signature `String() string` on the type. For our simple type `T` , that might look like this.

```go
func (t *T) String() string {
    return fmt.Sprintf("%d/%g/%q", t.a, t.b, t.c)
}
fmt.Printf("%v\n", t)
```

to print in the format

```go
7/-2.35/"abc\tdef"
```

\(If you need to print\_values\_of type `T` as well as pointers to `T` , the receiver for `String` must be of value type; this example used a pointer because that's more efficient and idiomatic for struct types. See the section below on[pointers vs. value receivers](https://golang.org/doc/effective_go.html#pointers_vs_values)for more information.\)

Our `String` method is able to call `Sprintf` because the print routines are fully reentrant and can be wrapped this way. There is one important detail to understand about this approach, however: don't construct a `String` method by calling `Sprintf` in a way that will recur into your `String` method indefinitely. This can happen if the `Sprintf` call attempts to print the receiver directly as a string, which in turn will invoke the method again. It's a common and easy mistake to make, as this example shows.

```go
type MyString string

func (m MyString) String() string {
    return fmt.Sprintf("MyString=%s", m) // Error: will recur forever.
}
```

It's also easy to fix: convert the argument to the basic string type, which does not have the method.

```go
type MyString string
func (m MyString) String() string {
    return fmt.Sprintf("MyString=%s", string(m)) // OK: note conversion.
}
```

In the[initialization section](https://golang.org/doc/effective_go.html#initialization)we'll see another technique that avoids this recursion.

Another printing technique is to pass a print routine's arguments directly to another such routine. The signature of `Printf` uses the type `...interface{}` for its final argument to specify that an arbitrary number of parameters \(of arbitrary type\) can appear after the format.

```go
func Printf(format string, v ...interface{}) (n int, err error) {
```

Within the function `Printf` , `v` acts like a variable of type `[]interface{}` but if it is passed to another variadic function, it acts like a regular list of arguments. Here is the implementation of the function `log.Println` we used above. It passes its arguments directly to `fmt.Sprintln` for the actual formatting.

```go
// Println prints to the standard logger in the manner of fmt.Println.
func Println(v ...interface{}) {
    std.Output(2, fmt.Sprintln(v...))  // Output takes parameters (int, string)
}
```

We write `...` after `v` in the nested call to `Sprintln` to tell the compiler to treat `v` as a list of arguments; otherwise it would just pass `v` as a single slice argument.

There's even more to printing than we've covered here. See the `godoc` documentation for package `fmt` for the details.

By the way, a `...` parameter can be of a specific type, for instance `...int` for a min function that chooses the least of a list of integers:

```go
func Min(a ...int) int {
    min := int(^uint(0) >> 1)  // largest int
    for _, i := range a {
        if i < min {
            min = i
        }
    }
    return min
}
```

### Append 

Now we have the missing piece we needed to explain the design of the `append` built-in function. The signature of `append` is different from our custom `Append` function above. Schematically, it's like this:

```go
func append(slice []T, elements ...T) []T
```

whereTis a placeholder for any given type. You can't actually write a function in Go where the type `T` is determined by the caller. That's why `append` is built in: it needs support from the compiler.

What `append` does is append the elements to the end of the slice and return the result. The result needs to be returned because, as with our hand-written `Append` , the underlying array may change. This simple example

```go
x := []int{1,2,3}
x = append(x, 4, 5, 6)
fmt.Println(x)
```

prints `[1 2 3 4 5 6]` . So `append` works a little like `Printf` , collecting an arbitrary number of arguments.

But what if we wanted to do what our `Append` does and append a slice to a slice? Easy: use `...` at the call site, just as we did in the call to `Output` above. This snippet produces identical output to the one above.

```go
x := []int{1,2,3}
y := []int{4,5,6}
x = append(x, y...)
fmt.Println(x)
```

Without that `...` , it wouldn't compile because the types would be wrong; `y` is not of type `int` .


---
![20200131220947.png](source/assets/images/leunggeorge.github.io-image-9%201%201.png)
