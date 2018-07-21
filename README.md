## Inject inspirational into the project

### SQPerformance
> Focus on performance optimization topics, Include `fluency-ui` technology

##### Get Started

- First, you need a [node](https://nodejs.org/en/) server environment

- Then, run the following command to launch server

```
$ node server.js
```

##### Contents
- `pre-layout` >>> when the `asynchronous thread` is started, the `typesetting processing` is performed while the network data is acquired.
- `reuse-pool` >>> design a universal `reuse pool` to reduce `memory consumption`. reference `UITableViewCell`.
- `pre-decode` >>> perform image `decoding operations` on `asynchronous threads` to `reduce resource usage` of the main thread
- `pre-render` >>> `graphics rendering` in `asynchronous threads`, using the `CPU` for rendering operations, avoiding `GPU` `off-screen rendering` consumption
- `asynchronous drawing` >>> create a `graphics context` in an `asynchronous thread` and draw it into `layer.contents`


##### Display

<img src="./SQPerformance/contents/step1.gif"><img src="./SQPerformance/contents/step2.gif">


- `Step1`: The left is used `pre-layout`, `reusepool`, `pre-decode`, `pre-render`.
- `Step2`: The Right is used `pre-layout`, `reusepool`, `pre-decode`, `pre-render`, `asynchronous drawing`.

Then you can see that is maintained at 60fps when launch the `asynchronous drawing`.


##### Article
- [iOS 界面性能优化浅析 / 2018 / 07](https://coderzsq.github.io/2018/07/iOS-%E7%95%8C%E9%9D%A2%E6%80%A7%E8%83%BD%E4%BC%98%E5%8C%96%E6%B5%85%E6%9E%90/)

<br/>

### SQTemplate

> Focus on generating template architecture files to speed up productivity & `code specification`

##### Get Started

- This project is base on the `RouterPattern` practice, So you need to clone [RouterPattern](https://github.com/coderZsq/coderZsq.practice.native/tree/master/RouterPattern) 
- Then, you need a [node](https://nodejs.org/en/) server environment
- Last, run the following command to launch server

```
$ cd RouterPattern/server/RouterPattern
$ npm start
```

##### Content
- `SQTemplate` >>> 



### SQLifestyle