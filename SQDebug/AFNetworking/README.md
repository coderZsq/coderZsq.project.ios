## AFNetworking

[Github 官方文档](https://github.com/AFNetworking/AFNetworking)
[AFNetworking 4.0.1 源码下载](https://github.com/AFNetworking/AFNetworking/archive/4.0.1.zip)

>AFNetworking是一个适用于iOS，macOS，watchOS和tvOS的令人愉悦的网络库。它建立在Foundation URL loading System的基础上，扩展了Cocoa中内置的强大的高级网络抽象。它具有模块化的体系结构，以及精心设计的，功能丰富的API，使用起来很愉快。

### AFNetworking Debug

```shell
$ pod init
```

```ruby
# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'

target 'AFNetworking-Debug' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for AFNetworking-Debug
  pod 'AFNetworking', '~> 4.0'
end
```

```shell
$ pod install

Analyzing dependencies
Downloading dependencies
Installing AFNetworking (4.0.1)
Generating Pods project
Integrating client project
Pod installation complete! There is 1 dependency from the Podfile and 1 total pod installed.
```

info.plist root \<dict>\</dict>中添加ATS

```xml
<key>NSAppTransportSecurity</key>
<dict>
	<key>NSAllowsArbitraryLoads</key>
	<true/>
</dict>
```

```js
const Router = require('koa-router');
const send = require('koa-send');

const router = new Router({ prefix: '/afn' });

router.get('/downloadTask/:name', async (ctx, next) => {
  const name = ctx.params.name;
  console.log(name)
  const path = `uploads/${name}`;
  ctx.attachment(path);
  await send(ctx, path);
});
```

```objc
- (void)create_a_downloadTask {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"http://example.com/download.zip"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error: nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSLog(@"File downloaded to: %@", filePath);
    }];
    [downloadTask resume];
}
```

```
download.zip
```

```c
File downloaded to: file:///Users/zhushuangquan/Library/Developer/CoreSimulator/Devices/384515F7-F815-4CD8-89F8-90481BD7EB0C/data/Containers/Data/Application/8E0DB155-CB63-4619-8A90-9565214E8E43/Documents/download.zip
```

```
.
├── Documents
│   └── download.zip
├── Library
│   ├── Caches
│   │   └── coderZsq.AFNetworking-Debug
│   │       ├── Cache.db
│   │       ├── Cache.db-shm
│   │       └── Cache.db-wal
│   ├── Preferences
│   ├── Saved\ Application\ State
│   │   └── coderZsq.AFNetworking-Debug.savedState
│   │       └── KnownSceneSessions
│   │           └── data.data
│   └── SplashBoard
│       └── Snapshots
│           └── coderZsq.AFNetworking-Debug\ -\ {DEFAULT\ GROUP}
│               ├── 1E10EA2C-9182-4108-837A-78BDFD4C990F@2x.ktx
│               ├── 3047D744-C433-48AF-9659-1C6D069F4BD6@2x.ktx
│               ├── A112B466-ECE1-4D2C-8B28-593B850EF0C5@2x.ktx
│               └── A6E0B8E4-F5D8-4FB3-84A8-A3E327196816@2x.ktx
├── SystemData
└── tmp

```

```js
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'uploads/');
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + path.extname(file.originalname));
  }
});

const upload = multer({
  storage
});

router.post('/uploadTask/upload', upload.single('afn'), (ctx, next) => {
  console.log(ctx.req.file);
  ctx.response.body = {
    msg: 'upload success!'
  };
});
```

```objc
- (void)create_an_uploadTask {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:@"http://localhost:8080/afn/uploadTask/upload" parameters:nil headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSURL *filePath = [NSURL fileURLWithPath:@"/Users/zhushuangquan/Desktop/AFN.png"];
        [formData appendPartWithFileURL:filePath name:@"afn" error:nil];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"Success: %@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
    }];
}
```

```js
{
  fieldname: 'afn',
  originalname: 'AFN.png',
  encoding: '7bit',
  mimetype: 'image/png',
  destination: 'uploads/',
  filename: '1605983019624.png',
  path: 'uploads/1605983019624.png',
  size: 88871
}
```

```js
Success: { msg = 'upload success!' }
```

```shell
$ cd AFNetworking-4.0.1
$ tree
```

```
.
├── AFNetworking
│   ├── AFNetworking.h
│   ├── AFCompatibilityMacros.h
│   ├── AFHTTPSessionManager.h
│   ├── AFHTTPSessionManager.m
│   ├── AFNetworkReachabilityManager.h
│   ├── AFNetworkReachabilityManager.m
│   ├── AFSecurityPolicy.h
│   ├── AFSecurityPolicy.m
│   ├── AFURLRequestSerialization.h
│   ├── AFURLRequestSerialization.m
│   ├── AFURLResponseSerialization.h
│   ├── AFURLResponseSerialization.m
│   ├── AFURLSessionManager.h
│   └── AFURLSessionManager.m
└── UIKit+AFNetworking
    ├── AFAutoPurgingImageCache.h
    ├── AFAutoPurgingImageCache.m
    ├── AFImageDownloader.h
    ├── AFImageDownloader.m
    ├── AFNetworkActivityIndicatorManager.h
    ├── AFNetworkActivityIndicatorManager.m
    ├── UIActivityIndicatorView+AFNetworking.h
    ├── UIActivityIndicatorView+AFNetworking.m
    ├── UIButton+AFNetworking.h
    ├── UIButton+AFNetworking.m
    ├── UIImageView+AFNetworking.h
    ├── UIImageView+AFNetworking.m
    ├── UIKit+AFNetworking.h
    ├── UIProgressView+AFNetworking.h
    ├── UIProgressView+AFNetworking.m
    ├── UIRefreshControl+AFNetworking.h
    ├── UIRefreshControl+AFNetworking.m
    ├── WKWebView+AFNetworking.h
    └── WKWebView+AFNetworking.m
```

```
.
├── AFNetworking.h
├── NSURLSession
│   ├── AFCompatibilityMacros.h
│   ├── AFHTTPSessionManager.h
│   ├── AFHTTPSessionManager.m
│   ├── AFURLSessionManager.h
│   └── AFURLSessionManager.m
├── Reachability
│   ├── AFNetworkReachabilityManager.h
│   └── AFNetworkReachabilityManager.m
├── Security
│   ├── AFSecurityPolicy.h
│   └── AFSecurityPolicy.m
└── Serialization
    ├── AFURLRequestSerialization.h
    ├── AFURLRequestSerialization.m
    ├── AFURLResponseSerialization.h
    └── AFURLResponseSerialization.m
```

