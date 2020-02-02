---
uuid: 5b9f6a70-4409-11ea-85a2-0759b3fd8fa1
title: git 常用操作
tags:
  - git
  - writing
categories:
  - essay
comments: false
description:
---


<!--more-->

## 多个账号配置 ssh 

1. 生成公私钥
```
ssh-keygen -t rsa -C "邮箱地址" -f ~/.ssh/work_id_rsa
ssh-keygen -t rsa -C "邮箱地址" -f ~/.ssh/github_id_rsa
```

2. 公钥（*.pub）copy到平台上
```
cat ~/.ssh/work_id_rsa.pub
cat ~/.ssh/github_id_rsa.pub
```

3. 修改config文件
```
Host work.domain.com
  HostName work.domain.com
  User git
  IdentityFile ~/.ssh/work_id_rsa

Host github.com
    HostName github.com
    IdentityFile ~/.ssh/github_id_rsa
```

### 测试配置结果
```
ssh -T git@github.com
Hi LeungGeorge! You've successfully authenticated, but GitHub does not provide shell access.
```

---
![20200131220947.png](https://raw.githubusercontent.com/LeungGeorge/assets/master/images/20200131220947.png)

<link rel="stylesheet" href="http://yandex.st/highlightjs/6.1/styles/default.min.css">
<script src="http://yandex.st/highlightjs/6.1/highlight.min.js"></script>
<script>
hljs.tabReplace = ' ';
hljs.initHighlightingOnLoad();
</script>

<!-- > 来源：[https://leunggeorge.github.io/](https://leunggeorge.github.io/)   -->
