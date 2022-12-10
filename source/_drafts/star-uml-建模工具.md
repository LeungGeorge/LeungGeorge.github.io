uuid: 707c2090-4720-11ea-a4bf-6f20a583fbd1
title: star uml 建模工具
description: UML 是一种建模语言，可以用于面向对象系统的分析与设计
date: 2020-07-11 18:44:54
---
<!--more-->
<!-- 1. 发布前：删除草稿的 uuid -->
<!-- 2. 发布后：补充tag，category -->

## 面向对象设计与分析
- 模型是一个系统的完整抽象。人们对某个领域特定问题的求解及解决方案，对他们的理解和认识都蕴含在模型中。


**我们分析问题的一个常见模型：**
![20200202213109.png](/images/20200202213109.png)

- 建模的目的：    
  1）分析设计阶段定义软件功能、结构和对外接口。      
  2）可读性高，便于交流。    
  3）完整的软件模型是系统结构和实现的重要资料，可以作为系统档案保存，便于后续产品进行重用。    

- 面向对象分析和设计的精髓：按照对象的观点考虑问题，找出逻辑问题的解决方案。归纳、总结和抽象，上升到方法论的高度很重要。

### 类之间的关系
类之间有如下 5 种关系，呈逐步增强趋势。

- 依赖：对象间最弱的一种关系，属于短期关系。      
- 关联：长期关系，比如对象 `ObjA` 保存了对象 `ObjB` 作为自身的成员。     
- 聚合：部分与整体的关系。     
- 组合：同生共死，生命周期一致。     
- 继承：子类拥有父类的属性、方法。     

## UML 概述
UML 是一种建模语言，可以用于面向对象系统的分析与设计。提供了丰富的基于面向对象概念的模型元素及其图形表示元素。

我们常用的图主要有用例图、时序图、类图、活动图、状态图。

<!-- 
StarUML
1. 下载地址：https://xclient.info/s/staruml.html

2. 破解方式： 
sudo spctl --master-disabl

MAC应用无法打开或文件损坏的处理方法：https://xclient.info/a/74559ea2-7870-b992-ed53-52a9d988e382.html 
-->

## UML 基本表示法



## UML 模型图
### Use Case（用例图）
从用户角度出发描述系统功能，明确需求。有如下两个部分组成：

- Actor
- Use Case

![20200203165132.png](/images/20200203165132.png)

### Sequence Case（时序图）
对象之间动态合作的关系，体现的是对象间消息的次序。

![20200203170221.png](/images/20200203170221.png)

### Class Diagram（类图）
静态结构，描述类的内部结构以及类之间的关系。

![20200203195911.png](/images/20200203195911.png)

### Activity Diagram（活动图）
系统中操作或者方法的执行逻辑流程，描述各种活动的执行顺序。

![20200203204352.png](/images/20200203204352.png)

### State Diagram（状态图）
实体对象的动态行为，实体根据当前状态对不同事件作出的反应。

![20200203202927.png](/images/20200203202927.png)

### Object Diagram（对象图）
对象图是类图的一个具体实例，描述了对象及对象间的相互关系。

### Communication Diagram（协作图）
对象间的协作关系。

### Component Diagram（组件图）
系统组件及其相互依赖关系。

### Deployment Diagram（部署图）
定义系统中软硬件的物理体系结构；

> https://www.w3cschool.cn/uml_tutorial/


## 总结

UML 有 9 种图。

常用的有：用例图、时序图、类图、活动图、状态图。


---
![20200131220947.png](/images/20200131220947.png)

<link rel="stylesheet" href="http://yandex.st/highlightjs/6.1/styles/default.min.css">
<script src="http://yandex.st/highlightjs/6.1/highlight.min.js"></script>
<script>
hljs.tabReplace = ' ';
hljs.initHighlightingOnLoad();
</script>

<!-- > 来源：[https://leunggeorge.github.io/](https://leunggeorge.github.io/)   -->