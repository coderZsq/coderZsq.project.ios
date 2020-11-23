## AFNetworking

>AFNetworking是一个适用于iOS，macOS，watchOS和tvOS的令人愉悦的网络库。它建立在Foundation URL loading System的基础上，扩展了Cocoa中内置的强大的高级网络抽象。它具有模块化的体系结构，以及精心设计的，功能丰富的API，使用起来很愉快。

- [Github 官方文档](https://github.com/AFNetworking/AFNetworking)
- [AFNetworking 4.0.1 源码下载](https://github.com/AFNetworking/AFNetworking/archive/4.0.1.zip)
- [关注我 获取中文版源码](https://github.com/coderZsq/coderZsq.project.ios/tree/master/SQDebug)

>2020-11-21

## 0x00 准备工作

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

```shell
$ npm i koa koa-router koa-send koa-multer
```

## 0x01 搭建服务器体验AFNetworking

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
        [formData appendPartWithFileURL:filePath name:@"file" error:nil];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"Success: %@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
    }];
}
```

```js
{
  fieldname: 'file',
  originalname: 'AFN.jpg',
  encoding: '7bit',
  mimetype: 'image/jpeg',
  destination: 'uploads/',
  filename: '1606012485650.jpg',
  path: 'uploads/1606012485650.jpg',
  size: 88871
}
```

```js
Success: { msg = 'upload success!' }
```

>2020-11-22

```objc
- (void)create_an_uploadTaskFor_a_MultiPartRequestWithProgress {
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"http://localhost:8080/afn/uploadTask/upload" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            [formData appendPartWithFileURL:[NSURL fileURLWithPath:@"/Users/zhushuangquan/Desktop/AFN.png"] name:@"file" fileName:@"filename.jpg" mimeType:@"image/jpeg" error:nil];
        } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];

    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      // This is not called back on the main queue.
                      // You are responsible for dispatching to the main queue for UI updates
                      dispatch_async(dispatch_get_main_queue(), ^{
                          //Update the progress view
                          [self.progressView setProgress:uploadProgress.fractionCompleted];
                      });
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      if (error) {
                          NSLog(@"Error: %@", error);
                      } else {
                          NSLog(@"%@ %@", response, responseObject);
                      }
                  }];

    [uploadTask resume];
}
```

```objc
<NSHTTPURLResponse: 0x600000f74ee0> { URL: http://localhost:8080/afn/uploadTask/upload } { Status Code: 200, Headers {
    Connection =     (
        "keep-alive"
    );
    "Content-Length" =     (
        25
    );
    "Content-Type" =     (
        "application/json; charset=utf-8"
    );
    Date =     (
        "Sun, 22 Nov 2020 02:47:06 GMT"
    );
    "Keep-Alive" =     (
        "timeout=5"
    );
} } {
    msg = "upload success!";
}
```

```objc
- (void)create_a_dataTask {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    NSURL *URL = [NSURL URLWithString:@"http://localhost:8080/afn/dataTask/get"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"%@ %@", response, responseObject);
        }
    }];
    [dataTask resume];
}
```

```js
router.get('/dataTask/get', (ctx, next) => {
  ctx.status = 200;
  ctx.body = {
    msg: 'get success!'
  }
});
```

```objc
<NSHTTPURLResponse: 0x600002b5c960> { URL: http://localhost:8080/afn/dataTask/get } { Status Code: 200, Headers {
    Connection =     (
        "keep-alive"
    );
    "Content-Length" =     (
        22
    );
    "Content-Type" =     (
        "application/json; charset=utf-8"
    );
    Date =     (
        "Sun, 22 Nov 2020 02:55:30 GMT"
    );
    "Keep-Alive" =     (
        "timeout=5"
    );
} } {
    msg = "get success!";
}
```

```objc
/*
 * NSURLSession的配置选项。 创建会话后，将创建配置对象的副本-创建会话后，您将无法修改会话的配置。
 *
 * 共享会话使用全局单例凭证，缓存和cookie存储对象。
 *
 * 临时会话没有用于cookie，缓存或凭据的持久磁盘存储。
 *
 * 在某些约束下，后台会话可用于代表暂停的应用程序执行联网操作。
 */
API_AVAILABLE(macos(10.9), ios(7.0), watchos(2.0), tvos(9.0))
@interface NSURLSessionConfiguration : NSObject <NSCopying>
```

```objc
@interface NSURL: NSObject <NSSecureCoding, NSCopying>
{
    NSString *_urlString;
    NSURL *_baseURL;
    void *_clients;
    void *_reserved;
}
```

```objc
@interface NSURLRequest : NSObject <NSSecureCoding, NSCopying, NSMutableCopying>
{
    @private
    NSURLRequestInternal *_internal;
}
```

```objc
@interface NSMutableURLRequest : NSURLRequest
```

```objc
@interface NSURLSessionDownloadTask : NSURLSessionTask
```

```objc
@interface NSURLSessionUploadTask : NSURLSessionDataTask
```

```objc
@interface NSURLSessionDataTask : NSURLSessionTask
```

```objc
- (void)sharedNetworkReachability {
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
    }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}
```

```
Reachability: Reachable via WiFi
Reachability: Not Reachable
```

## 0x02 导览AFNetworing知识架构

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

```objc
#import <"AFNetworking.h">
```

```objc
#import <Foundation/Foundation.h>
#import <Availability.h>
#import <TargetConditionals.h>

#ifndef _AFNETWORKING_
    #define _AFNETWORKING_

    #import "AFURLRequestSerialization.h"
    #import "AFURLResponseSerialization.h"
    #import "AFSecurityPolicy.h"

#if !TARGET_OS_WATCH
    #import "AFNetworkReachabilityManager.h"
#endif

    #import "AFURLSessionManager.h"
    #import "AFHTTPSessionManager.h"

#endif /* _AFNETWORKING_ */
```

```objc
#import <Availability.h>
```

```
这些宏用于OS头文件。 它们使函数原型和Objective-C方法可以使用首次使用的OS版本进行标记。 以及不适用的操作系统版本（如果适用）。
```

```objc
#import <TargetConditionals.h>
```

```
File:       TargetConditionals.h

Contains:   Mac OS X和iPhone的TARGET_条件的自动配置

            Note:  3.4通用接口中的TargetConditionals.h适用于所有编译器。 
                   此标头仅识别已知可在Mac OS X上运行的编译器。
                   
 +----------------------------------------------------------------+
 |                TARGET_OS_MAC                                   |
 | +---+  +-----------------------------------------------------+ |
 | |   |  |          TARGET_OS_IPHONE                           | |
 | |OSX|  | +-----+ +----+ +-------+ +--------+ +-------------+ | |
 | |   |  | | IOS | | TV | | WATCH | | BRIDGE | | MACCATALYST | | |
 | |   |  | +-----+ +----+ +-------+ +--------+ +-------------+ | |
 | +---+  +-----------------------------------------------------+ |
 +----------------------------------------------------------------+
```

```objc
    #import "AFURLRequestSerialization.h"
    #import "AFURLResponseSerialization.h"
    #import "AFSecurityPolicy.h"

#if !TARGET_OS_WATCH
    #import "AFNetworkReachabilityManager.h"
#endif

    #import "AFURLSessionManager.h"
    #import "AFHTTPSessionManager.h"
```

## 0x03 AFNetworking请求序列化.h文件详解

```objc
#import "AFURLRequestSerialization.h"
```

```objc
/**
 返回遵循RFC 3986的查询字符串键或值的百分比转义字符串。
 RFC 3986声明以下字符为“保留”字符。
 -通用分隔符：“：”，“＃”，“ [”，“]”，“ @”，“？”，“ /”
 -子定界符：“！”，“ $”，“＆”，“'”，“（”，“）”，“ *”，“ +”，“，”，“，”，“ =”

 在RFC 3986-3.4节中，它指出“？” 和“ /”字符不应转义以允许查询字符串包含URL。 因此，所有“保留”字符（“？”除外） 和“ /”应该在查询字符串中转义。

 @param string 要百分号转义的字符串。

 @return换码百分比的字符串。
 */
FOUNDATION_EXPORT NSString * AFPercentEscapedStringFromString(NSString *string);
```

```objc
NSLog(@"URL: %@", AFPercentEscapedStringFromString(@"http://localhost:8080/afn/dataTask/get?a=1&b=2&c=3"));
```

```
URL: http%3A//localhost%3A8080/afn/dataTask/get?a%3D1%26b%3D2%26c%3D3
```

```objc
/**
 一种辅助方法，用于生成编码后的URL查询参数，以附加到URL的末尾。

 @param parameters 要编码的键/值的字典。

 @return网址编码的查询字符串
 */
FOUNDATION_EXPORT NSString * AFQueryStringFromParameters(NSDictionary *parameters);
```

```objc
NSLog(@"QueryString: %@", AFQueryStringFromParameters(@{@"a": @1, @"b": @2,  @"c": @3}));
```

```
QueryString: a=1&b=2&c=3
```

```objc
/**
 对象采用“ AFURLRequestSerialization”协议，该协议对指定HTTP请求的参数进行编码。 请求序列化程序可以将参数编码为查询字符串，HTTP正文，并根据需要设置适当的HTTP标头字段。

 例如，JSON请求序列化程序可以将请求的HTTP主体设置为JSON表示，并将“ Content-Type” HTTP标头字段值设置为“ application / json”。
 */
@protocol AFURLRequestSerialization <NSObject, NSSecureCoding, NSCopying>

/**
 返回带有已编码为原始请求副本的指定参数的请求。

 @param request 原始请求。
 @param parameters 要编码的参数。
 @param error 尝试对请求参数进行编码时发生的错误。

 @return 序列化的请求。
 */
- (nullable NSURLRequest *)requestBySerializingRequest:(NSURLRequest *)request
                               withParameters:(nullable id)parameters
                                        error:(NSError * _Nullable __autoreleasing *)error NS_SWIFT_NOTHROW;

@end
```

```objc
/**
  AFURLRequestSerialization.h line: 210
  默认请求参数序列化样式
 */
typedef NS_ENUM(NSUInteger, AFHTTPRequestQueryStringSerializationStyle) {
    AFHTTPRequestQueryStringDefaultStyle = 0,
};
```

```objc
/**
 AFURLRequestSerialization.h line: 281
 */
@protocol AFMultipartFormData;
```

```objc
/**
 AFMultipartFormData协议定义了AFHTTPRequestSerializer -multipartFormRequestWithMethod：URLString：parameters：constructingBodyWithBlock：的block参数中参数所支持的方法。
 */
@protocol AFMultipartFormData

/**
 附加HTTP标头`Content-Disposition：file; filename =＃{生成的文件名}; name =＃{name}”和“ Content-Type：＃{生成的mimeType}”，然后是编码的文件数据和多部分表单边界。

   表单中此数据的文件名和MIME类型将分别使用`fileURL`的最后一个路径部分和`fileURL`扩展名与系统相关的MIME类型自动生成。

   @param fileURL 对应于其内容将附加到表单的文件的URL。 该参数不能为“ nil”。
   @param name 与指定数据关联的名称。 该参数不能为“ nil”。
   @param error 如果发生错误，返回时将包含一个描述问题的NSError对象。

   @如果文件数据已成功添加，则返回“是”，否则返回“否”。
 */
- (BOOL)appendPartWithFileURL:(NSURL *)fileURL
                         name:(NSString *)name
                        error:(NSError * _Nullable __autoreleasing *)error;

/**
 附加HTTP标头`Content-Disposition：file; filename =＃{filename}; name =＃{name}”和“ Content-Type：＃{mimeType}”，然后是编码文件数据和多部分表单边界。

   @param fileURL 对应于其内容将附加到表单的文件的URL。 该参数不能为“ nil”。
   @param name 与指定数据关联的名称。 该参数不能为“ nil”。
   @param fileName 在Content-Disposition标头中使用的文件名。 该参数不能为“ nil”。
   @param mimeType 文件数据的声明的MIME类型。 该参数不能为“ nil”。
   @param error 如果发生错误，返回时将包含一个描述问题的NSError对象。

   @如果文件数据已成功添加，则返回“是”，否则返回“否”。
 */
- (BOOL)appendPartWithFileURL:(NSURL *)fileURL
                         name:(NSString *)name
                     fileName:(NSString *)fileName
                     mimeType:(NSString *)mimeType
                        error:(NSError * _Nullable __autoreleasing *)error;

/**
 附加HTTP标头`Content-Disposition：file; filename =＃{filename}; name =＃{name}”和“ Content-Type：＃{mimeType}”，然后是来自输入流的数据和多部分表单边界。

   @param inputStream 要添加到表单数据的输入流
   @param name 与指定的输入流关联的名称。 该参数不能为“ nil”。
   @param fileName 与指定输入流关联的文件名。 该参数不能为“ nil”。
   @param length 以字节为单位的指定输入流的长度。
   @param mimeType 指定数据的MIME类型。 （例如，JPEG图像的MIME类型为image / jpeg。）有关有效MIME类型的列表，请参见http://www.iana.org/assignments/media-types/。 该参数不能为“ nil”。
 */
- (void)appendPartWithInputStream:(nullable NSInputStream *)inputStream
                             name:(NSString *)name
                         fileName:(NSString *)fileName
                           length:(int64_t)length
                         mimeType:(NSString *)mimeType;

/**
 附加HTTP标头`Content-Disposition：file; filename =＃{filename}; name =＃{name}”和“ Content-Type：＃{mimeType}”，然后是编码文件数据和多部分表单边界。

   @param data 要编码并附加到表单数据的数据。
   @param name 与指定数据关联的名称。 该参数不能为“ nil”。
   @param fileName 与指定数据关联的文件名。 该参数不能为“ nil”。
   @param mimeType 指定数据的MIME类型。 （例如，JPEG图像的MIME类型为image / jpeg。）有关有效MIME类型的列表，请参见http://www.iana.org/assignments/media-types/。 该参数不能为“ nil”。
 */
- (void)appendPartWithFileData:(NSData *)data
                          name:(NSString *)name
                      fileName:(NSString *)fileName
                      mimeType:(NSString *)mimeType;

/**
 附加HTTP标头`Content-Disposition：form-data; name =＃{name}“`，后跟编码数据和多部分表单边界。

   @param data 要编码并附加到表单数据的数据。
   @param name 与指定数据关联的名称。 该参数不能为“ nil”。
 */

- (void)appendPartWithFormData:(NSData *)data
                          name:(NSString *)name;


/**
 附加HTTP标头，后跟编码数据和多部分表单边界。

   @param headers 要附加到表单数据的HTTP标头。
   @param body 要编码并附加到表单数据的数据。 该参数不能为“ nil”。
 */
- (void)appendPartWithHeaders:(nullable NSDictionary <NSString *, NSString *> *)headers
                         body:(NSData *)body;

/**
 节流通过限制数据包大小并为从上传流中读取的每个数据块增加延迟来请求带宽。

  通过3G或EDGE连接上载时，请求可能会失败，并显示“请求正文流已耗尽”。根据建议值（kAFUploadStream3GSuggestedPacketSize和kAFUploadStream3GSuggestedDelay）设置最大数据包大小和延迟，可降低输入流超过其分配带宽的风险。不幸的是，没有确定的方法来区分通过NSURLConnection的3G，EDGE或LTE连接。因此，不建议您仅根据网络可达性来限制带宽。相反，您应该考虑在故障块中检查“请求正文流已耗尽”，然后使用限制带宽重试该请求。

  @param numberOfBytes 最大数据包大小，以字节数为单位。输入流的默认数据包大小为16kb。
  @param delay 每次读取数据包时的延迟持续时间。默认情况下，不设置延迟。
 */
- (void)throttleBandwidthWithPacketSize:(NSUInteger)numberOfBytes
                                  delay:(NSTimeInterval)delay;

@end
```

```objc
/**
 AFHTTPRequestSerializer符合AFURLRequestSerialization和AFURLResponseSerialization协议，提供查询字符串/ URL格式编码的参数序列化和默认请求标头的具体基础实现，以及响应状态代码和内容类型验证。

   鼓励任何处理HTTP的请求或响应序列化器都继承AFHTTPRequestSerializer的子类，以确保一致的默认行为。
 */
@interface AFHTTPRequestSerializer : NSObject <AFURLRequestSerialization>

/**
 用于序列化参数的字符串编码。 默认情况下，`NSUTF8StringEncoding`。
 */
@property (nonatomic, assign) NSStringEncoding stringEncoding;

/**
 创建的请求是否可以使用设备的蜂窝无线电（如果有）。 默认为YES。

   @see NSMutableURLRequest -setAllowsCellularAccess：
 */
@property (nonatomic, assign) BOOL allowsCellularAccess;

/**
 创建的请求的缓存策略。 默认情况下，`NSURLRequestUseProtocolCachePolicy`。

   @see NSMutableURLRequest -setCachePolicy：
 */
@property (nonatomic, assign) NSURLRequestCachePolicy cachePolicy;

/**
 创建的请求是否应使用默认的cookie处理。 默认为YES。

   @see NSMutableURLRequest -setHTTPShouldHandleCookies：
 */
@property (nonatomic, assign) BOOL HTTPShouldHandleCookies;

/**
在收到来自较早传输的响应之前，创建的请求是否可以继续传输数据。 默认为“否”

  @see NSMutableURLRequest -setHTTPShouldUsePipelining：
 */
@property (nonatomic, assign) BOOL HTTPShouldUsePipelining;

/**
创建的请求的网络服务类型。 默认情况下为“ NSURLNetworkServiceTypeDefault”。

  @see NSMutableURLRequest -setNetworkServiceType：
 */
@property (nonatomic, assign) NSURLRequestNetworkServiceType networkServiceType;

/**
 创建的请求的超时间隔（以秒为单位）。 默认超时间隔为60秒。

   @see NSMutableURLRequest -setTimeoutInterval：
 */
@property (nonatomic, assign) NSTimeInterval timeoutInterval;

///---------------------------------------
/// @name 配置HTTP请求头
///---------------------------------------

/**
 要应用于序列化请求的默认HTTP标头字段值。 默认情况下，这些内容包括：

   -具有NSLocale + preferredLanguages内容的`Accept-Language`
   -`User-Agent`，其中包含各种捆绑包标识符和操作系统名称的内容

   @discussion 要添加或删除默认请求头，请使用`setValue：forHTTPHeaderField：`。
 */
@property (readonly, nonatomic, strong) NSDictionary <NSString *, NSString *> *HTTPRequestHeaders;

/**
 用默认配置创建并返回一个序列化器。
 */
+ (instancetype)serializer;

/**
 设置在HTTP客户端发出的请求对象中设置的HTTP标头的值。 如果为nil，则删除该标头的现有值。

   @param field 用于设置默认值的HTTP标头
   @param value 为指定的标头设置的默认值，或者为'nil'
 */
- (void)setValue:(nullable NSString *)value
forHTTPHeaderField:(NSString *)field;

/**
 返回在请求序列化程序中设置的HTTP标头的值。

   @param field 用于检索默认值的HTTP标头

   @return 为指定标题设置的默认值，或者为'nil'
 */
- (nullable NSString *)valueForHTTPHeaderField:(NSString *)field;

/**
 将HTTP客户端在请求对象中设置的“ Authorization” HTTP标头设置为具有Base64编码的用户名和密码的基本身份验证值。 这将覆盖此标头的任何现有值。

   @param username HTTP基本身份验证用户名
   @param password HTTP基本身份验证密码
 */
- (void)setAuthorizationHeaderFieldWithUsername:(NSString *)username
                                       password:(NSString *)password;

/**
 清除“Authorization” HTTP标头的任何现有值。
 */
- (void)clearAuthorizationHeader;

///-------------------------------------------------------
/// @name 配置查询字符串参数序列化
///-------------------------------------------------------

/**
 序列化请求的HTTP方法会将参数编码为查询字符串。 默认情况下，`GET`，`HEAD`和`DELETE`。
 */
@property (nonatomic, strong) NSSet <NSString *> *HTTPMethodsEncodingParametersInURI;

/**
 根据预定义的样式之一设置查询字符串序列化的方法。

   @param style 序列化样式。

   @see AFHTTPRequestQueryStringSerializationStyle
 */
- (void)setQueryStringSerializationWithStyle:(AFHTTPRequestQueryStringSerializationStyle)style;

/**
 根据指定的块设置查询字符串序列化的自定义方法。

   @param block 定义将参数编码为查询字符串的过程的块。 该块返回查询字符串，并接受三个参数：请求，要编码的参数以及尝试对给定请求的参数进行编码时发生的错误。
 */
- (void)setQueryStringSerializationWithBlock:(nullable NSString * _Nullable (^)(NSURLRequest *request, id parameters, NSError * __autoreleasing *error))block;

///-------------------------------
/// @name 创建请求对象
///-------------------------------

/**
 使用指定的HTTP方法和URL字符串创建一个NSMutableURLRequest对象。

   如果HTTP方法是`GET`，`HEAD`或`DELETE`，则参数将用于构造附加到请求URL的url编码查询字符串。 否则，将根据“ parameterEncoding”属性的值对参数进行编码，并将其设置为请求正文。

   @param method 请求的HTTP方法，例如“ GET”，“ POST”，“ PUT”或“ DELETE”。 该参数不能为“ nil”。
   @param URLString 用于创建请求URL的URL字符串。
   @param parameters 将被设置为GET请求的查询字符串或请求HTTP正文的参数。
   @param error 构造请求时发生的错误。

   @return 一个NSMutableURLRequest对象。
 */
- (nullable NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                          URLString:(NSString *)URLString
                                         parameters:(nullable id)parameters
                                              error:(NSError * _Nullable __autoreleasing *)error;

/**
 使用指定的HTTP方法和URLString创建一个“ NSMutableURLRequest”对象，并使用指定的参数和多部分表单数据块构造一个“ multipart / form-data” HTTP正文。参见http://www.w3.org/TR/html4/interact/forms.html#h-17.13.4.2

  多部分表单请求会自动进行流传输，直接从磁盘读取文件以及单个HTTP正文中的内存数据。产生的NSMutableURLRequest对象具有HTTPBodyStream属性，因此请不要在此请求对象上设置HTTPBodyStream或HTTPBody，因为它将清除多部分表单主体流。

  @param method 请求的HTTP方法。此参数不能为“ GET”，“ HEAD”或“ nil”。
  @param URLString 用于创建请求URL的URL字符串。
  @param parameters 在请求HTTP正文中要编码和设置的参数。
  @param block 一个接受单个参数并将数据附加到HTTP正文的块。 block参数是采用AFMultipartFormData协议的对象。
  @param error 构造请求时发生的错误。

  @return 一个NSMutableURLRequest对象
 */
- (NSMutableURLRequest *)multipartFormRequestWithMethod:(NSString *)method
                                              URLString:(NSString *)URLString
                                             parameters:(nullable NSDictionary <NSString *, id> *)parameters
                              constructingBodyWithBlock:(nullable void (^)(id <AFMultipartFormData> formData))block
                                                  error:(NSError * _Nullable __autoreleasing *)error;

/**
 通过从请求中删除HTTPBodyStream来创建NSMutableURLRequest，并将其内容异步写入指定的文件，并在完成时调用完成处理程序。

  @param request 多部分表单请求。 request的HTTPBodyStream属性不能为nil。
  @param fileURL 要写入多部分表单内容的文件URL。
  @param handler 要执行的处理程序块。

  @discussion NSURLSessionTask中存在一个错误，该错误导致请求从HTTP正文流传输内容时请求不发送Content-Length标头，这在与Amazon S3 Web服务进行交互时尤其成问题。解决方法是，此方法采用一个由multipartFormRequestWithMethod：URLString：parameters：constructingBodyWithBlock：error：构造的请求，或带有HTTPBodyStream的任何其他请求，将内容写入指定的文件，并返回原始请求的副本。 HTTPBodyStream属性设置为nil。在这里，文件可以传递到AFURLSessionManager -uploadTaskWithRequest：fromFile：progress：completionHandler：`，或将其内容读入分配给请求的HTTPBody属性的NSData中。

  @see https://github.com/AFNetworking/AFNetworking/issues/1398
 */
- (NSMutableURLRequest *)requestWithMultipartFormRequest:(NSURLRequest *)request
                             writingStreamContentsToFile:(NSURL *)fileURL
                                       completionHandler:(nullable void (^)(NSError * _Nullable error))handler;

@end
```

```objc
/**
 AFJSONRequestSerializer是AFHTTPRequestSerializer的子类，它使用NSJSONSerialization将参数编码为JSON，将编码请求的Content-Type设置为application / json。
 */
@interface AFJSONRequestSerializer : AFHTTPRequestSerializer

/**
 用于从Foundation对象写入请求JSON数据的选项。 有关可能的值，请参见“ NSJSONSerialization”文档部分“ NSJSONWritingOptions”。 默认为0。
 */
@property (nonatomic, assign) NSJSONWritingOptions writingOptions;

/**
 创建并返回带有指定读写选项的JSON序列化程序。

   @param writingOptions 指定的JSON写入选项。
 */
+ (instancetype)serializerWithWritingOptions:(NSJSONWritingOptions)writingOptions;
```

```objc
/**
AFPropertyListRequestSerializer是AFHTTPRequestSerializer的子类，它使用NSPropertyListSerializer将参数编码为JSON，并将编码后的请求的Content-Type设置为application / x-plist。
 */
@interface AFPropertyListRequestSerializer : AFHTTPRequestSerializer

/**
 属性列表格式。 可能的值在“ NSPropertyListFormat”中描述。
 */
@property (nonatomic, assign) NSPropertyListFormat format;

/**
 @warning`writeOptions`属性当前未使用。
 */
@property (nonatomic, assign) NSPropertyListWriteOptions writeOptions;

/**
 Creates and returns a property list serializer with a specified format, read options, and write options.

 @param format The property list format.
 @param writeOptions The property list write options.

 @warning The `writeOptions` property is currently unused.
 */
+ (instancetype)serializerWithFormat:(NSPropertyListFormat)format
                        writeOptions:(NSPropertyListWriteOptions)writeOptions;

@end
```

```objc
///----------------
/// @name 常数
///----------------

/**
 ##错误域

 以下错误域是预定义的。

 -`NSString * const AFURLRequestSerializationErrorDomain`

 ###常数

 AFURLRequestSerializationErrorDomain AFURLRequestSerializer错误。
 AFURLRequestSerializationErrorDomain的错误代码对应于NSURLErrorDomain的代码。
 */
FOUNDATION_EXPORT NSString * const AFURLRequestSerializationErrorDomain;

/**
 ##用户信息字典键

 除了为NSError定义的密钥外，这些密钥还可以存在于用户信息字典中。

 -`NSString * const AFNetworkingOperationFailingURLRequestErrorKey`

 ###常数

 AFNetworkingOperationFailingURLRequestErrorKey
 相应的值为“ NSURLRequest”，其中包含与错误相关联的操作请求。 该密钥仅存在于“ AFURLRequestSerializationErrorDomain”中。
 */
FOUNDATION_EXPORT NSString * const AFNetworkingOperationFailingURLRequestErrorKey;

/**
 ## HTTP请求输入流的限制带宽

 @see -throttleBandwidthWithPacketSize：delay：

 ###常数

 kAFUploadStream3GSuggestedPacketSize
 最大数据包大小，以字节数为单位。 等于16kb。

 kAFUploadStream3GSuggestedDelay
 每次读取数据包的延迟时间。 等于0.2秒。
 */
FOUNDATION_EXPORT NSUInteger const kAFUploadStream3GSuggestedPacketSize;
FOUNDATION_EXPORT NSTimeInterval const kAFUploadStream3GSuggestedDelay;
```

```objc
NSLog(@"AFURLRequestSerializationErrorDomain: %@", AFURLRequestSerializationErrorDomain);
```

```
AFURLRequestSerializationErrorDomain: com.alamofire.error.serialization.request
```

```objc
NSLog(@"AFNetworkingOperationFailingURLRequestErrorKey: %@", AFNetworkingOperationFailingURLRequestErrorKey);
```

```
AFNetworkingOperationFailingURLRequestErrorKey: com.alamofire.serialization.request.error.response
```

```objc
NSLog(@"kAFUploadStream3GSuggestedPacketSize: %lu", kAFUploadStream3GSuggestedPacketSize);
```

```
kAFUploadStream3GSuggestedPacketSize: 16384
```

```objc
NSLog(@"kAFUploadStream3GSuggestedDelay: %f", kAFUploadStream3GSuggestedDelay);
```

```
kAFUploadStream3GSuggestedDelay: 0.200000
```

## 0x04 AFNetworking请求序列化.m详解

```objc
NSString * const AFURLRequestSerializationErrorDomain = @"com.alamofire.error.serialization.request";
NSString * const AFNetworkingOperationFailingURLRequestErrorKey = @"com.alamofire.serialization.request.error.response";
```

```objc
/**
 AFURLRequestSerialization.m line: 191
 */
typedef NSString * (^AFQueryStringSerializationBlock)(NSURLRequest *request, id parameters, NSError *__autoreleasing *error);
```

```objc
/**
 返回遵循RFC 3986的查询字符串键或值的百分比转义字符串。
   RFC 3986声明以下字符为“保留”字符。
      -通用分隔符：“：”，“＃”，“ [”，“]”，“ @”，“？”，“ /”
      -子定界符：“！”，“ $”，“＆”，“'”，“（”，“）”，“ *”，“ +”，“，”，“，”，“ =”

   在RFC 3986-3.4节中，它指出“？” 和“ /”字符不应转义以允许查询字符串包含URL。 因此，所有“保留”字符（“？”除外） 和“ /”应该在查询字符串中转义。
      -参数字符串：要百分号转义的字符串。
      -返回：转义百分比的字符串。
 */
NSString * AFPercentEscapedStringFromString(NSString *string) {
    static NSString * const kAFCharactersGeneralDelimitersToEncode = @":#[]@"; // 不包括 ”？” 或“ /”（由于RFC 3986-第3.4节）
    static NSString * const kAFCharactersSubDelimitersToEncode = @"!$&'()*+,;=";

    NSMutableCharacterSet * allowedCharacterSet = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
    [allowedCharacterSet removeCharactersInString:[kAFCharactersGeneralDelimitersToEncode stringByAppendingString:kAFCharactersSubDelimitersToEncode]];

	// FIXME: https://github.com/AFNetworking/AFNetworking/pull/3028
    // return [string stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];

    static NSUInteger const batchSize = 50;

    NSUInteger index = 0;
    NSMutableString *escaped = @"".mutableCopy;

    while (index < string.length) {
        NSUInteger length = MIN(string.length - index, batchSize);
        NSRange range = NSMakeRange(index, length);

        //为了避免破坏诸如👴🏻👮🏽之类的字符序列
        range = [string rangeOfComposedCharacterSequencesForRange:range];

        NSString *substring = [string substringWithRange:range];
        NSString *encoded = [substring stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
        [escaped appendString:encoded];

        index += range.length;
    }

	return escaped;
}
```

```objc
@interface AFQueryStringPair : NSObject
@property (readwrite, nonatomic, strong) id field;
@property (readwrite, nonatomic, strong) id value;

- (instancetype)initWithField:(id)field value:(id)value;

- (NSString *)URLEncodedStringValue;
@end

@implementation AFQueryStringPair

- (instancetype)initWithField:(id)field value:(id)value {
    self = [super init];
    if (!self) {
        return nil;
    }

    self.field = field;
    self.value = value;

    return self;
}

- (NSString *)URLEncodedStringValue {
    if (!self.value || [self.value isEqual:[NSNull null]]) {
        return AFPercentEscapedStringFromString([self.field description]);
    } else {
        return [NSString stringWithFormat:@"%@=%@", AFPercentEscapedStringFromString([self.field description]), AFPercentEscapedStringFromString([self.value description])];
    }
}

@end
```

```objc
SQQueryStringPair *pair = [[SQQueryStringPair alloc] initWithField:@"a" value:@1];
```

```objc
NSLog(@"%@", [pair URLEncodedStringValue]);
```

```
a=1
```

```objc
SQQueryStringPair *pair2 = [[SQQueryStringPair alloc] initWithField:@"b" value:nil];
```

```objc
NSLog(@"%@", [pair2 URLEncodedStringValue]);
```

```
b
```

```objc
FOUNDATION_EXPORT NSArray * AFQueryStringPairsFromDictionary(NSDictionary *dictionary);
FOUNDATION_EXPORT NSArray * AFQueryStringPairsFromKeyAndValue(NSString *key, id value);

NSString * AFQueryStringFromParameters(NSDictionary *parameters) {
    NSMutableArray *mutablePairs = [NSMutableArray array];
    for (AFQueryStringPair *pair in AFQueryStringPairsFromDictionary(parameters)) {
        [mutablePairs addObject:[pair URLEncodedStringValue]];
    }

    return [mutablePairs componentsJoinedByString:@"&"];
}

NSArray * AFQueryStringPairsFromDictionary(NSDictionary *dictionary) {
    return AFQueryStringPairsFromKeyAndValue(nil, dictionary);
}

NSArray * AFQueryStringPairsFromKeyAndValue(NSString *key, id value) {
    NSMutableArray *mutableQueryStringComponents = [NSMutableArray array];

    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"description" ascending:YES selector:@selector(compare:)];

    if ([value isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dictionary = value;
        // 对字典键进行排序以确保查询字符串中的顺序一致，这在反序列化可能含糊的序列（例如字典数组）时很重要
        for (id nestedKey in [dictionary.allKeys sortedArrayUsingDescriptors:@[ sortDescriptor ]]) {
            id nestedValue = dictionary[nestedKey];
            if (nestedValue) {
                [mutableQueryStringComponents addObjectsFromArray:AFQueryStringPairsFromKeyAndValue((key ? [NSString stringWithFormat:@"%@[%@]", key, nestedKey] : nestedKey), nestedValue)];
            }
        }
    } else if ([value isKindOfClass:[NSArray class]]) {
        NSArray *array = value;
        for (id nestedValue in array) {
            [mutableQueryStringComponents addObjectsFromArray:AFQueryStringPairsFromKeyAndValue([NSString stringWithFormat:@"%@[]", key], nestedValue)];
        }
    } else if ([value isKindOfClass:[NSSet class]]) {
        NSSet *set = value;
        for (id obj in [set sortedArrayUsingDescriptors:@[ sortDescriptor ]]) {
            [mutableQueryStringComponents addObjectsFromArray:AFQueryStringPairsFromKeyAndValue(key, obj)];
        }
    } else {
        [mutableQueryStringComponents addObject:[[AFQueryStringPair alloc] initWithField:key value:value]];
    }

    return mutableQueryStringComponents;
}
```

```objc
NSLog(@"%@", SQQueryStringPairsFromKeyAndValue(@"a", @1));
```
```
(
    "a=1"
)
``` 

```objc 
NSLog(@"%@", SQQueryStringPairsFromKeyAndValue(@"a", @{@"b": @{@"c": @3}, @"d": @""}));
```

```
(
    "a[b][c]=3",
    "a[d]="
)
```

```objc
NSLog(@"%@", SQQueryStringPairsFromKeyAndValue(@"a", @[@"b", @{@"c": @3}, @"d"]));
```

```
(
    "a[]=b",
    "a[][c]=3",
    "a[]=d"
)
```

```objc
NSLog(@"%@", SQQueryStringPairFromDictionary(@{@"a": @{@"b": @{@"c": @3}, @"d": @""}}));
```

```
(
    "a[b][c]=3",
    "a[d]="
)
```

```objc
NSLog(@"%@", SQQueryStringFromParameters(@{@"a": @{@"b": @{@"c": @3}, @"d": @""}}));
```

```
a[b][c]=3&a[d]=
```

>2020-11-23

```objc
@interface AFStreamingMultipartFormData : NSObject <AFMultipartFormData>
- (instancetype)initWithURLRequest:(NSMutableURLRequest *)urlRequest
                    stringEncoding:(NSStringEncoding)encoding;

- (NSMutableURLRequest *)requestByFinalizingMultipartFormData;
@end
```

```objc
AFMultipartFormData -> AFURLRequestSerialization.h line 281
AFStreamingMultipartFormData -> AFURLRequestSerialization.m line 663
AFMultipartBodyStream -> AFURLRequestSerialization.m line 642
AFHTTPBodyPart -> AFURLRequestSerialization.m line 624
```

```objc
static NSString * AFCreateMultipartFormBoundary() {
    return [NSString stringWithFormat:@"Boundary+%08X%08X", arc4random(), arc4random()];
}

static NSString * const kAFMultipartFormCRLF = @"\r\n";

static inline NSString * AFMultipartFormInitialBoundary(NSString *boundary) {
    return [NSString stringWithFormat:@"--%@%@", boundary, kAFMultipartFormCRLF];
}

static inline NSString * AFMultipartFormEncapsulationBoundary(NSString *boundary) {
    return [NSString stringWithFormat:@"%@--%@%@", kAFMultipartFormCRLF, boundary, kAFMultipartFormCRLF];
}

static inline NSString * AFMultipartFormFinalBoundary(NSString *boundary) {
    return [NSString stringWithFormat:@"%@--%@--%@", kAFMultipartFormCRLF, boundary, kAFMultipartFormCRLF];
}

static inline NSString * AFContentTypeForPathExtension(NSString *extension) {
    NSString *UTI = (__bridge_transfer NSString *)UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)extension, NULL);
    NSString *contentType = (__bridge_transfer NSString *)UTTypeCopyPreferredTagWithClass((__bridge CFStringRef)UTI, kUTTagClassMIMEType);
    if (!contentType) {
        return @"application/octet-stream";
    } else {
        return contentType;
    }
}

NSUInteger const kAFUploadStream3GSuggestedPacketSize = 1024 * 16;
NSTimeInterval const kAFUploadStream3GSuggestedDelay = 0.2;
```

```objc
@interface AFHTTPBodyPart : NSObject
@property (nonatomic, assign) NSStringEncoding stringEncoding;
@property (nonatomic, strong) NSDictionary *headers;
@property (nonatomic, copy) NSString *boundary;
@property (nonatomic, strong) id body;
@property (nonatomic, assign) unsigned long long bodyContentLength;
@property (nonatomic, strong) NSInputStream *inputStream;

@property (nonatomic, assign) BOOL hasInitialBoundary;
@property (nonatomic, assign) BOOL hasFinalBoundary;

@property (readonly, nonatomic, assign, getter = hasBytesAvailable) BOOL bytesAvailable;
@property (readonly, nonatomic, assign) unsigned long long contentLength;

- (NSInteger)read:(uint8_t *)buffer
        maxLength:(NSUInteger)length;
@end
```

```objc
typedef enum {
    AFEncapsulationBoundaryPhase = 1,
    AFHeaderPhase                = 2,
    AFBodyPhase                  = 3,
    AFFinalBoundaryPhase         = 4,
} AFHTTPBodyPartReadPhase;

@interface AFHTTPBodyPart () <NSCopying> {
    AFHTTPBodyPartReadPhase _phase;
    NSInputStream *_inputStream;
    unsigned long long _phaseReadOffset;
}

- (BOOL)transitionToNextPhase;
- (NSInteger)readData:(NSData *)data
           intoBuffer:(uint8_t *)buffer
            maxLength:(NSUInteger)length;
@end

@implementation AFHTTPBodyPart

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }

    [self transitionToNextPhase];

    return self;
}

- (void)dealloc {
    if (_inputStream) {
        [_inputStream close];
        _inputStream = nil;
    }
}

- (NSInputStream *)inputStream {
    if (!_inputStream) {
        if ([self.body isKindOfClass:[NSData class]]) {
            _inputStream = [NSInputStream inputStreamWithData:self.body];
        } else if ([self.body isKindOfClass:[NSURL class]]) {
            _inputStream = [NSInputStream inputStreamWithURL:self.body];
        } else if ([self.body isKindOfClass:[NSInputStream class]]) {
            _inputStream = self.body;
        } else {
            _inputStream = [NSInputStream inputStreamWithData:[NSData data]];
        }
    }

    return _inputStream;
}

- (NSString *)stringForHeaders {
    NSMutableString *headerString = [NSMutableString string];
    for (NSString *field in [self.headers allKeys]) {
        [headerString appendString:[NSString stringWithFormat:@"%@: %@%@", field, [self.headers valueForKey:field], kAFMultipartFormCRLF]];
    }
    [headerString appendString:kAFMultipartFormCRLF];

    return [NSString stringWithString:headerString];
}

- (unsigned long long)contentLength {
    unsigned long long length = 0;

    NSData *encapsulationBoundaryData = [([self hasInitialBoundary] ? AFMultipartFormInitialBoundary(self.boundary) : AFMultipartFormEncapsulationBoundary(self.boundary)) dataUsingEncoding:self.stringEncoding];
    length += [encapsulationBoundaryData length];

    NSData *headersData = [[self stringForHeaders] dataUsingEncoding:self.stringEncoding];
    length += [headersData length];

    length += _bodyContentLength;

    NSData *closingBoundaryData = ([self hasFinalBoundary] ? [AFMultipartFormFinalBoundary(self.boundary) dataUsingEncoding:self.stringEncoding] : [NSData data]);
    length += [closingBoundaryData length];

    return length;
}

- (BOOL)hasBytesAvailable {
    // 如果AFMultipartFormFinalBoundary不适合可用缓冲区，则允许再次调用read：maxLength：
    if (_phase == AFFinalBoundaryPhase) {
        return YES;
    }

    switch (self.inputStream.streamStatus) {
        case NSStreamStatusNotOpen:
        case NSStreamStatusOpening:
        case NSStreamStatusOpen:
        case NSStreamStatusReading:
        case NSStreamStatusWriting:
            return YES;
        case NSStreamStatusAtEnd:
        case NSStreamStatusClosed:
        case NSStreamStatusError:
        default:
            return NO;
    }
}

- (NSInteger)read:(uint8_t *)buffer
        maxLength:(NSUInteger)length
{
    NSInteger totalNumberOfBytesRead = 0;

    if (_phase == AFEncapsulationBoundaryPhase) {
        NSData *encapsulationBoundaryData = [([self hasInitialBoundary] ? AFMultipartFormInitialBoundary(self.boundary) : AFMultipartFormEncapsulationBoundary(self.boundary)) dataUsingEncoding:self.stringEncoding];
        totalNumberOfBytesRead += [self readData:encapsulationBoundaryData intoBuffer:&buffer[totalNumberOfBytesRead] maxLength:(length - (NSUInteger)totalNumberOfBytesRead)];
    }

    if (_phase == AFHeaderPhase) {
        NSData *headersData = [[self stringForHeaders] dataUsingEncoding:self.stringEncoding];
        totalNumberOfBytesRead += [self readData:headersData intoBuffer:&buffer[totalNumberOfBytesRead] maxLength:(length - (NSUInteger)totalNumberOfBytesRead)];
    }

    if (_phase == AFBodyPhase) {
        NSInteger numberOfBytesRead = 0;

        numberOfBytesRead = [self.inputStream read:&buffer[totalNumberOfBytesRead] maxLength:(length - (NSUInteger)totalNumberOfBytesRead)];
        if (numberOfBytesRead == -1) {
            return -1;
        } else {
            totalNumberOfBytesRead += numberOfBytesRead;

            if ([self.inputStream streamStatus] >= NSStreamStatusAtEnd) {
                [self transitionToNextPhase];
            }
        }
    }

    if (_phase == AFFinalBoundaryPhase) {
        NSData *closingBoundaryData = ([self hasFinalBoundary] ? [AFMultipartFormFinalBoundary(self.boundary) dataUsingEncoding:self.stringEncoding] : [NSData data]);
        totalNumberOfBytesRead += [self readData:closingBoundaryData intoBuffer:&buffer[totalNumberOfBytesRead] maxLength:(length - (NSUInteger)totalNumberOfBytesRead)];
    }

    return totalNumberOfBytesRead;
}

- (NSInteger)readData:(NSData *)data
           intoBuffer:(uint8_t *)buffer
            maxLength:(NSUInteger)length
{
    NSRange range = NSMakeRange((NSUInteger)_phaseReadOffset, MIN([data length] - ((NSUInteger)_phaseReadOffset), length));
    [data getBytes:buffer range:range];

    _phaseReadOffset += range.length;

    if (((NSUInteger)_phaseReadOffset) >= [data length]) {
        [self transitionToNextPhase];
    }

    return (NSInteger)range.length;
}

- (BOOL)transitionToNextPhase {
    if (![[NSThread currentThread] isMainThread]) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self transitionToNextPhase];
        });
        return YES;
    }

    switch (_phase) {
        case AFEncapsulationBoundaryPhase:
            _phase = AFHeaderPhase;
            break;
        case AFHeaderPhase:
            [self.inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
            [self.inputStream open];
            _phase = AFBodyPhase;
            break;
        case AFBodyPhase:
            [self.inputStream close];
            _phase = AFFinalBoundaryPhase;
            break;
        case AFFinalBoundaryPhase:
        default:
            _phase = AFEncapsulationBoundaryPhase;
            break;
    }
    _phaseReadOffset = 0;

    return YES;
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone {
    AFHTTPBodyPart *bodyPart = [[[self class] allocWithZone:zone] init];

    bodyPart.stringEncoding = self.stringEncoding;
    bodyPart.headers = self.headers;
    bodyPart.bodyContentLength = self.bodyContentLength;
    bodyPart.body = self.body;
    bodyPart.boundary = self.boundary;

    return bodyPart;
}

@end
```

```objc
SQHTTPBodyPart *bodyPart = [[SQHTTPBodyPart alloc] init];
bodyPart.headers = @{
    @"accept": @"application/json, text/javascript, */*; q=0.01",
    @"accept-encoding": @"gzip, deflate, br",
    @"accept-language": @"en-US,en;q=0.9,zh;q=0.8",
    @"content-length": @"9",
    @"content-type": @"application/json; charset=UTF-8"
};
NSLog(@"%@", [bodyPart stringForHeaders]);
```

```
accept: application/json, text/javascript, */*; q=0.01
accept-language: en-US,en;q=0.9,zh;q=0.8
content-length: 9
accept-encoding: gzip, deflate, br
content-type: application/json; charset=UTF-8

```


```objc
#import "AFURLSessionManager.h"
```

```
AFURLSessionManager基于指定的NSURLSessionConfiguration对象创建和管理NSURLSession对象，该对象符合<NSURLSessionTaskDelegate>，<NSURLSessionDataDelegate>，<NSURLSessionDownloadDelegate>和<NSURLSessionDelegate>。
```
