uuid: ae7a5640-4410-11ea-be26-5f58b99d11f6
title: golang 令牌桶限流器 rate
tags:
  - golang
  - 令牌桶
  - 限流器
  - rate
categories:
  - golang
comments: true
description: golang 实现的令牌桶限流器。
date: 2020-02-01 22:22:04
---
<!--more-->

## 令牌桶算法

令牌桶算法(Token Bucket)随着时间流逝, 系统会按恒定1/QPS时间间隔(如果QPS=100, 则间隔是10ms)往桶里加入Token, 如果桶已经满了就不再加了。新请求来临时, 会各自拿走一个Token, 如果没有Token可拿了就阻塞或者拒绝服务.

![upload successful](source/assets/images/leunggeorge.github.io-image-4%202.png)

> 限流器 rate 原理与上图的令牌桶类似。

## 限流器 rate 的用法和实现逻辑

[官方代码库 github.com/golang/time](https://github.com/golang/time)，限流器主要用来限制请求速率，保护服务，防止服务过载。

### NewLimiter
```
func NewLimiter(r Limit, b int) *Limiter
```

构造限流器，参数说明：  
* `r` : 令牌桶每秒可以产生 `r` 个 token。  
* `b` : 令牌桶的大小。

![upload successful](source/assets/images/leunggeorge.github.io-image-8%202.png)

### Reserve/ReserveN

* 获取一个预定对象 `r`，表示调用者需要等待的相关信息（如，是否可以处理、何时可以处理等等），调用者可根据 `r` 自行决定处理逻辑。
* 如下 case 返回 false：    
  1). 请求令牌数 `n` 超过桶容量   

```
func (lim *Limiter) Reserve() *Reservation
func (lim *Limiter) ReserveN(now time.Time, n int) *Reservation
```

**用法：**

```
// Usage example:
r := lim.ReserveN(time.Now(), 1)
if !r.OK() {
    // Not allowed to act! Did you remember to set lim.burst to be > 0 ?
    return
}
time.Sleep(r.Delay())
// Act()
```

#### 实现逻辑

![upload successful](source/assets/images/leunggeorge.github.io-image-5%202.png)

### Allow/AllowN

* 截止到某一时刻，是否可以从桶中获取 N 个令牌。如果可以，消费 n 个 token 并返回 true；否则返回 false。 
* 按照频率限制执行，超过频率限制时丢弃或者跳过

```
func (lim *Limiter) Allow()
func (lim *Limiter) AllowN(now time.Time, n int) bool
```

> Allow 是 AllowN(time. Now(), 1) 的简写。

#### 实现逻辑

实现逻辑与 `ReserveN` 相同，仅使用预定对象的成功状态，即：

```
return lim.reserveN(now, n, 0).ok
```

### Wait/WaitN 

* 阻塞等待，可自定义等待时间（超时自动取消）。
* 如下 case 会报 error：  
  1). 请求令牌数 `n` 超过桶容量    
  2). 请求被取消   
  3). 等待超时   

```
func (lim *Limiter) Wait(ctx context.Context) (err error)
func (lim *Limiter) WaitN(ctx context.Context, n int) (err error)
```

> Wait 是 WaitN(ctx, 1) 的简写。

#### 实现逻辑

![upload successful](source/assets/images/leunggeorge.github.io-image-6%202.png)

### SetLimit/SetLimitAt

令牌桶限流频率设置。

### SetBurst/SetBurstAt

令牌桶容量设置。

> ## 引用
> [限流算法之漏桶算法、令牌桶算法](https://blog.csdn.net/skiof007/article/details/81302566)  

---

![20200131220947 2.png](source/assets/images/20200131220947%202.png)

<link rel="stylesheet" href="http://yandex.st/highlightjs/6.1/styles/default.min.css">
<script src="http://yandex.st/highlightjs/6.1/highlight.min.js"></script>
<script>
hljs.tabReplace = ' '; 
hljs.initHighlightingOnLoad(); 
</script>

<!-- > 来源：[https://leunggeorge.github.io/](https://leunggeorge.github.io/)   -->
