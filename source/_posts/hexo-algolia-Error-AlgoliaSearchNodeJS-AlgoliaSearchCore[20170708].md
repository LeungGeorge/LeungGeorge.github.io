---
title: hexo algolia Error AlgoliaSearchNodeJS.AlgoliaSearchCore
tags: 
  - Hexo
  - Search
categories: 
  - Hexo
comments: false 
date: 2017-07-08 00:06:32  

---
# 报错信息

```
/home/work/github/blog/LeungGeorge.github.io/node_modules/bluebird/js/release/async.js:61
        fn = function () { throw arg; };
                           ^
Error
    at AlgoliaSearchNodeJS.AlgoliaSearchCore (/home/work/github/blog/LeungGeorge.github.io/node_modules/algoliasearch/src/AlgoliaSearchCore.js:51:11)
    at AlgoliaSearchNodeJS.AlgoliaSearch (/home/work/github/blog/LeungGeorge.github.io/node_modules/algoliasearch/src/AlgoliaSearch.js:11:21)
    at AlgoliaSearchNodeJS.AlgoliaSearchServer (/home/work/github/blog/LeungGeorge.github.io/node_modules/algoliasearch/src/server/builds/AlgoliaSearchServer.js:17:17)
    at new AlgoliaSearchNodeJS (/home/work/github/blog/LeungGeorge.github.io/node_modules/algoliasearch/src/server/builds/node.js:79:23)
    at algoliasearch (/home/work/github/blog/LeungGeorge.github.io/node_modules/algoliasearch/src/server/builds/node.js:68:10)
    at /home/work/github/blog/LeungGeorge.github.io/node_modules/hexo-algoliasearch/lib/algolia.js:119:18
    at tryCatcher (/home/work/github/blog/LeungGeorge.github.io/node_modules/bluebird/js/release/util.js:16:23)
    at Promise.successAdapter [as _fulfillmentHandler0] (/home/work/github/blog/LeungGeorge.github.io/node_modules/bluebird/js/release/nodeify.js:22:30)
    at Promise._settlePromise (/home/work/github/blog/LeungGeorge.github.io/node_modules/bluebird/js/release/promise.js:566:21)
    at Promise._settlePromise0 (/home/work/github/blog/LeungGeorge.github.io/node_modules/bluebird/js/release/promise.js:614:10)
    at Promise._settlePromises (/home/work/github/blog/LeungGeorge.github.io/node_modules/bluebird/js/release/promise.js:693:18)
    at Async._drainQueue (/home/work/github/blog/LeungGeorge.github.io/node_modules/bluebird/js/release/async.js:133:16)
    at Async._drainQueues (/home/work/github/blog/LeungGeorge.github.io/node_modules/bluebird/js/release/async.js:143:10)
    at Immediate.Async.drainQueues (/home/work/github/blog/LeungGeorge.github.io/node_modules/bluebird/js/release/async.js:17:14)
    at runCallback (timers.js:637:20)
    at tryOnImmediate (timers.js:610:5)
    at processImmediate [as _immediateCallback] (timers.js:582:5)
```



# 修复方法
安装hexo-algolia@0.2.0，再执行hexo algolia就可以了

```
npm install hexo-algolia@0.2.0
```





---
<link rel="stylesheet" href="http://yandex.st/highlightjs/6.1/styles/default.min.css">
<script src="http://yandex.st/highlightjs/6.1/highlight.min.js"></script>
<script>
hljs.tabReplace = ' ';
hljs.initHighlightingOnLoad();
</script>


来源：[http://leunggeorge.github.io/](http://leunggeorge.github.io/)  