---
title: linux-grep
tags:
  - writting
  - shell
categories:
  - linux
  - shell
comments: false
date: 2017-08-13 09:59:54
description: grep（global search regular expression(RE) and print out the line，全面搜索正则表达式并把行打印出来）是一种强大的文本搜索工具，它能使用正则表达式搜索文本，并把匹配的行打印出来。


---
# DESCRIPTION（描述）
> The grep utility searches any given input files, selecting lines that match one or more patterns.  By default, a pattern matches an input line if the regular expression (RE) in the pattern matches the input line without its trailing newline.  An empty expression matches every line.  Each input line that matches at least one of the patterns is written to the standard output.  
> grep实用工具，筛选给定模式匹配到的文件行。模式是默认按行匹配的（不含换行符）；其中，空模式会匹配所有的行，输入文件中被匹配的行会写到标准输出。  
>  
> grep is used for simple patterns and basic regular expressions (BREs); egrep can handle extended regular expressions (EREs).  See re_format(7) for more information on regular expressions.  fgrep is quicker than both grep and egrep, but can only handle fixed patterns (i.e. it does not interpret regular expressions).  Patterns may consist of one or more lines, allowing any of the pattern lines to match a portion of the input.
> grep支持纯文本和标准正则查找，egrep支持扩展的正则。re_format(7)有更多的关于正则的信息。fgrep比grep和egrep要快，但只能处理固定模式（如：fgrep不支持正则）。模式可以是一行或多行，（任意一个）匹配输入行即输出。

# synopsis（概要，大纲）

```
grep [-abcdDEFGHhIiJLlmnOopqRSsUVvwxZ] [-A num] [-B num] [-C[num]] [-e pattern] [-f file] [--binary-files=value] [--color[=when]] [--colour[=when]] [--context[=num]] [--label] [--line-buffered] [--null] [pattern] [file ...]
```



> 引用  
> http://man.linuxde.net/grep




---
<link rel="stylesheet" href="http://yandex.st/highlightjs/6.1/styles/default.min.css">
<script src="http://yandex.st/highlightjs/6.1/highlight.min.js"></script>
<script>
hljs.tabReplace = ' ';
hljs.initHighlightingOnLoad();
</script>


来源：[http://leunggeorge.github.io/](http://leunggeorge.github.io/)  