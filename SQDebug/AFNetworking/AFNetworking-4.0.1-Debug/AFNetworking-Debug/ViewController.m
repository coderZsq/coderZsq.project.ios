//
//  ViewController.m
//  AFNetworking-Debug
//
//  Created by 朱双泉 on 2020/11/21.
//

#import "ViewController.h"
#import <AFNetworking.h>
#import "SQURLRequestSerialization.h"
#import "SQHTTPBodyPart.h"

@interface ViewController ()
@property (nonatomic, weak) IBOutlet UIProgressView *progressView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self debug_AFNURLRequestSerialSerialization];
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
        [formData appendPartWithFileURL:filePath name:@"file" error:nil];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"Success: %@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
    }];
}

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

- (void)sharedNetworkReachability {
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
    }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

- (void)debug_AFNURLRequestSerialSerialization {
    NSLog(@"URL: %@", AFPercentEscapedStringFromString(@"http://localhost:8080/afn/dataTask/get?a=1&b=2&c=3"));
    // URL: http%3A//localhost%3A8080/afn/dataTask/get?a%3D1%26b%3D2%26c%3D3
    
    NSLog(@"QueryString: %@", AFQueryStringFromParameters(@{@"a": @1, @"b": @2,  @"c": @3}));
    // QueryString: a=1&b=2&c=3
    
    NSLog(@"AFURLRequestSerializationErrorDomain: %@", AFURLRequestSerializationErrorDomain);
    // AFURLRequestSerializationErrorDomain: com.alamofire.error.serialization.request
    NSLog(@"AFNetworkingOperationFailingURLRequestErrorKey: %@", AFNetworkingOperationFailingURLRequestErrorKey);
    // AFNetworkingOperationFailingURLRequestErrorKey: com.alamofire.serialization.request.error.response
    NSLog(@"kAFUploadStream3GSuggestedPacketSize: %lu", kAFUploadStream3GSuggestedPacketSize);
    // kAFUploadStream3GSuggestedPacketSize: 16384
    NSLog(@"kAFUploadStream3GSuggestedDelay: %f", kAFUploadStream3GSuggestedDelay);
    // kAFUploadStream3GSuggestedDelay: 0.200000
}

@end
