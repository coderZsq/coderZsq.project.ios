//
//  DownloadViewController.m
//  Network
//
//  Created by 朱双泉 on 2018/9/29.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "DownloadViewController.h"
#import <SSZipArchive.h>
#import <AFNetworking.h>

#define kPath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"Castie!.gif"]
#define kSize [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"Castie!.size"]

@interface DownloadViewController () <NSURLSessionDataDelegate, NSURLSessionDownloadDelegate, NSXMLParserDelegate>
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (nonatomic, assign) NSInteger totalSize;
@property (nonatomic, assign) NSInteger currentSize;
@property (nonatomic, strong) NSFileHandle * handle;
@property (nonatomic, strong) NSURLSessionDataTask * dataTask;
@property (nonatomic, strong) NSURLSession * session;
@property (nonatomic, strong) NSOutputStream * stream;
@property (nonatomic, strong) NSURLSessionDownloadTask * downloadTask;
@property (nonatomic, strong) NSData * resumeData;
@end

@implementation DownloadViewController

- (NSURLSessionDownloadTask *)downloadTask {
    
    if (!_downloadTask) {
        NSURL * url = [NSURL URLWithString:@"https://github.com/coderZsq/coderZsq.project.ios/blob/master/SQPerformance/contents/step2.gif?raw=true"];
        NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
#if 0
        NSURLSessionDownloadTask * task = [[NSURLSession sharedSession] downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSLog(@"%@", location);
            NSString * cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
            NSString * fullPath = [cachePath stringByAppendingPathComponent:response.suggestedFilename];
            NSLog(@"%@", [NSURL URLWithString:fullPath]);
            NSLog(@"%@", [NSURL fileURLWithPath:fullPath]);
            [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:fullPath] error:nil];
        }];
#endif
        _downloadTask = [self.session downloadTaskWithRequest:request];
    }
    return _downloadTask;
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    NSLog(@"%f", 1. * totalBytesWritten / totalBytesExpectedToWrite);
    self.progressView.progress = 1. * totalBytesWritten / totalBytesExpectedToWrite;
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    NSString * cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    NSString * fullPath = [cachePath stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:fullPath] error:nil];
    NSLog(@"%@", fullPath);
}

- (NSURLSessionDataTask *)dataTask {
    
    if (!_dataTask) {
        NSURL * url = [NSURL URLWithString:@"https://github.com/coderZsq/coderZsq.project.ios/blob/master/SQPerformance/contents/step2.gif?raw=true"];
        NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
        NSString * range = [NSString stringWithFormat:@"bytes=%li-",self.currentSize];
        [request setValue:range forHTTPHeaderField:@"Range"];
        NSLog(@"%@", range);
        
        _dataTask = [self.session dataTaskWithRequest:request];;
    }
    return _dataTask;
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    
    self.totalSize = response.expectedContentLength + self.currentSize;
    NSLog(@"%li", self.totalSize);
    
    NSData * data = [[NSString stringWithFormat:@"%li", self.totalSize] dataUsingEncoding:NSUTF8StringEncoding];
    [data writeToFile:kSize atomically:YES];
    
    NSString * fullPath = kPath;
    NSLog(@"%@", fullPath);
#if 0
    if (self.currentSize == 0) {
        [[NSFileManager defaultManager] createFileAtPath:fullPath contents:nil attributes:nil];
    }
    self.handle = [NSFileHandle fileHandleForWritingAtPath:fullPath];
    [self.handle seekToEndOfFile];
#endif
    NSOutputStream * stream = [[NSOutputStream alloc]initToFileAtPath:kPath append:YES];
    [stream open];
    self.stream = stream;
    
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    self.currentSize += data.length;
#if 0
    [self.handle writeData:data];
#endif
    [self.stream write:data.bytes maxLength:data.length];
    self.progressView.progress = 1. * self.currentSize / self.totalSize;
    NSLog(@"%f - %li - %li", self.progressView.progress, self.currentSize, self.totalSize);
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
#if 0
    [self.handle closeFile];
#endif
    [self.stream close];
}

- (NSURLSession *)session {
    
    if (!_session) {
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];;
    }
    return _session;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Download";
    
    NSDictionary * fileInfo = [[NSFileManager defaultManager] attributesOfItemAtPath:kPath error:nil];
    NSLog(@"%@", fileInfo);
    self.currentSize = fileInfo.fileSize;
    
    NSData * data = [NSData dataWithContentsOfFile:kSize];
    self.totalSize = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding].integerValue;
    if (self.totalSize != 0) {
        self.progressView.progress = 1. * self.currentSize / self.totalSize;
    }
    [self afn_reachability];
}

- (void)afn_reachability {
    AFNetworkReachabilityManager * manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"AFNetworkReachabilityStatusUnknown");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"AFNetworkReachabilityStatusNotReachable");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"AFNetworkReachabilityStatusReachableViaWWAN");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"AFNetworkReachabilityStatusReachableViaWiFi");
                break;
        }
    }];
    [manager startMonitoring];
}

- (void)afn_http_parser {
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:@"https://www.baidu.com" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (void)afn_xml_parser {
    NSURL * url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"webimage" ofType:@"xml"]];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    [manager GET:url.absoluteString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        NSXMLParser * parser = (NSXMLParser *)responseObject;
        parser.delegate = self;
        [parser parse];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (void)afn_upload {
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager POST:@"http://localhost:8090/post" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData * data = UIImagePNGRepresentation([UIImage imageNamed:@"Mark"]);
        //        [formData appendPartWithFileURL:<#(nonnull NSURL *)#> name:<#(nonnull NSString *)#> fileName:<#(nonnull NSString *)#> mimeType:<#(nonnull NSString *)#> error:<#(NSError *__autoreleasing  _Nullable * _Nullable)#>]
        [formData appendPartWithFileData:data name:@"file" fileName:@".png" mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"%f", 1. * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (void)afn_download {
    NSURL * url = [NSURL URLWithString:@"https://github.com/coderZsq/coderZsq.project.ios/blob/master/SQPerformance/contents/step2.gif?raw=true"];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [[manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%f", 1. * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSString * fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
        NSLog(@"%@", targetPath);
        NSLog(@"%@", fullPath);
        return [NSURL URLWithString:fullPath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSLog(@"%@", filePath);
    }] resume];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    NSLog(@"%@ - %@", elementName, attributeDict);
}

- (void)afn_post {
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager POST:@"http://localhost:8090/post" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@ - %@", [responseObject class], responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (void)afn_get {
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://localhost:8090/get" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@ - %@", [responseObject class], responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (void)zip {
    //    [SSZipArchive createZipFileAtPath:<#(nonnull NSString *)#> withFilesAtPaths:<#(nonnull NSArray *)#>]
    //    [SSZipArchive createZipFileAtPath:<#(nonnull NSString *)#> withContentsOfDirectory:<#(nonnull NSString *)#>]
    
    //    [SSZipArchive unzipFileAtPath:<#(nonnull NSString *)#> toDestination:<#(nonnull NSString *)#>]
}

- (IBAction)startButtonClick:(UIButton *)sender {
    //    [self.dataTask resume];
    [self.downloadTask resume];
}

- (IBAction)suspendButtonClick:(UIButton *)sender {
    //    [self.dataTask suspend];
    [self.downloadTask suspend];
}

- (IBAction)cancelButtonClick:(UIButton *)sender {
    //    [self.dataTask cancel];
    //    [self.downloadTask cancel];
    [self.downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        self.resumeData = resumeData;
    }];
    [self.session invalidateAndCancel];
    self.session = nil;
    self.dataTask = nil;
    self.downloadTask = nil;
}

- (IBAction)resumeButtonClick:(UIButton *)sender {
    //    [self.dataTask resume];
    if (self.resumeData) {
        self.downloadTask = [self.session downloadTaskWithResumeData:self.resumeData];
        self.resumeData = nil;
    }
    [self.downloadTask resume];
}

@end
