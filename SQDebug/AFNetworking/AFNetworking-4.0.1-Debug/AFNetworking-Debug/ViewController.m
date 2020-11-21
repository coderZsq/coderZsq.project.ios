//
//  ViewController.m
//  AFNetworking-Debug
//
//  Created by 朱双泉 on 2020/11/21.
//

#import "ViewController.h"
#import <AFNetworking.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self create_an_uploadTask];
}

- (void)create_a_downloadTask {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"http://localhost:8080/afn/downloadTask/download.zip"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSLog(@"targetPath: %@", targetPath);
        /**
         targetPath: file:///Users/zhushuangquan/Library/Developer/CoreSimulator/Devices/384515F7-F815-4CD8-89F8-90481BD7EB0C/data/Containers/Data/Application/8D91694B-11F9-4537-A914-3C4EB61BED37/tmp/CFNetworkDownload_xPcOB5.tmp
         */
        NSLog(@"response: %@", response);
        /**
         response: <NSHTTPURLResponse: 0x600001ba82c0> { URL: http://localhost:8080/afn/downloadTask/download.zip } { Status Code: 200, Headers {
         "Cache-Control" =     (
         "max-age=0"
         );
         Connection =     (
         "keep-alive"
         );
         "Content-Disposition" =     (
         "attachment; filename=\"download.zip\""
         );
         "Content-Length" =     (
         655724
         );
         "Content-Type" =     (
         "application/zip"
         );
         Date =     (
         "Sat, 21 Nov 2020 07:09:02 GMT"
         );
         "Keep-Alive" =     (
         "timeout=5"
         );
         "Last-Modified" =     (
         "Sat, 21 Nov 2020 07:04:18 GMT"
         );
         } }
         */
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error: nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSLog(@"response: %@", response);
        /**
         response: <NSHTTPURLResponse: 0x600001ba82c0> { URL: http://localhost:8080/afn/downloadTask/download.zip } { Status Code: 200, Headers {
         "Cache-Control" =     (
         "max-age=0"
         );
         Connection =     (
         "keep-alive"
         );
         "Content-Disposition" =     (
         "attachment; filename=\"download.zip\""
         );
         "Content-Length" =     (
         655724
         );
         "Content-Type" =     (
         "application/zip"
         );
         Date =     (
         "Sat, 21 Nov 2020 07:09:02 GMT"
         );
         "Keep-Alive" =     (
         "timeout=5"
         );
         "Last-Modified" =     (
         "Sat, 21 Nov 2020 07:04:18 GMT"
         );
         } }
         */
        NSLog(@"File downloaded to: %@", filePath);
        /**
         File downloaded to: file:///Users/zhushuangquan/Library/Developer/CoreSimulator/Devices/384515F7-F815-4CD8-89F8-90481BD7EB0C/data/Containers/Data/Application/8D91694B-11F9-4537-A914-3C4EB61BED37/Documents/download.zip
         */
    }];
    [downloadTask resume];
}

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

@end