---
title: 执行hexo g出现DTraceProviderBindings
tags: 
  - hexo
categories: hexo
comments: false
date: 2017-07-07 20:06:42
---
---
报错信息:

```
{ Error: Cannot find module './build/default/DTraceProviderBindings'
    at Function.Module._resolveFilename (module.js:472:15)
    at Function.Module._load (module.js:420:25)
    at Module.require (module.js:500:17)
    at require (internal/module.js:20:19)
    at Object.<anonymous> (/usr/local/lib/node_modules/hexo/node_modules/dtrace-provider/dtrace-provider.js:17:23)
    at Module._compile (module.js:573:32)
    at Object.Module._extensions..js (module.js:582:10)
    at Module.load (module.js:490:32)
    at tryModuleLoad (module.js:449:12)
    at Function.Module._load (module.js:441:3)
    at Module.require (module.js:500:17)
    at require (internal/module.js:20:19)
    at Object.<anonymous> (/usr/local/lib/node_modules/hexo/node_modules/bunyan/lib/bunyan.js:79:18)
    at Module._compile (module.js:573:32)
    at Object.Module._extensions..js (module.js:582:10)
    at Module.load (module.js:490:32) code: 'MODULE_NOT_FOUND' }  
```

##解决办法：
重装：hexo-cli  

```
npm uninstall hexo-cli -g  
npm install hexo-cli -g   
```





---
<link rel="stylesheet" href="http://yandex.st/highlightjs/6.1/styles/default.min.css">
<script src="http://yandex.st/highlightjs/6.1/highlight.min.js"></script>
<script>
hljs.tabReplace = ' ';
hljs.initHighlightingOnLoad();
</script>


来源：[http://leunggeorge.github.io/](http://leunggeorge.github.io/)  