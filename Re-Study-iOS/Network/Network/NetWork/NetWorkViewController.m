//
//  NetWorkViewController.m
//  Network
//
//  Created by 朱双泉 on 2018/9/28.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "NetWorkViewController.h"

@interface NetWorkViewController () <NSURLConnectionDataDelegate, NSURLSessionDataDelegate>
@property (nonatomic, copy) NSArray * dataSource;
@property (nonatomic, strong) NSMutableData * data;
@end

@implementation NetWorkViewController

- (NSArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = @[@"NSURLConnection - sync_request - excute",
                        @"NSURLConnection - async_request - excute",
                        @"NSURLConnection - async_request_delegate - excute",
                        @"NSURLConnection - post_request - excute",
                        @"NSURLSession - session_get_request - excute",
                        @"NSURLSession - session_post_request - excute",
                        @"NSURLSession - session_request_delegate - excute",
                        @"NSURLSession - session_serialization - excute"];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"NetWork";
}

- (void)session_serialization {
    [[[NSURLSession sharedSession]dataTaskWithURL:[NSURL URLWithString:@"http://localhost:8090/fetchMockData"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //        @[[NSNull null]];
        id obj = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"%@ - %@", [obj class], obj);
    }] resume];
    
    NSData * data = [NSJSONSerialization dataWithJSONObject:@{@"username" : @"Castie!"} options:0 error:nil];
    NSLog(@"%@", [[NSString alloc]initWithData:data encoding:(NSUTF8StringEncoding)]);
    
    if (![NSJSONSerialization isValidJSONObject:@"Castie!"])
        NSLog(@"not valid string!");
}

- (void)session_request_delegate {
    NSURL * url = [NSURL URLWithString:@"http://localhost:8090/get"];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    NSURLSession * session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
    NSURLSessionDataTask * task = [session dataTaskWithRequest:request];
    [task resume];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    NSLog(@"%s", __func__);
    NSLog(@"%@", [NSThread currentThread]);
    self.data = [NSMutableData data];
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    NSLog(@"%s", __func__);
    [self.data appendData:data];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    NSLog(@"%s", __func__);
    NSLog(@"%@", [[NSString alloc]initWithData:self.data encoding:(NSUTF8StringEncoding)]);
}

- (void)session_post_request {
    NSURL * url = [NSURL URLWithString:@"http://localhost:8090/post"];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [@"username=Castie!&pwd=666" dataUsingEncoding:(NSUTF8StringEncoding)];
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLSessionDataTask * task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@", [NSThread currentThread]);
        NSLog(@"%@", response);
        NSLog(@"%@", [[NSString alloc]initWithData:data encoding:(NSUTF8StringEncoding)]);
    }];
    [task resume];
}


- (void)session_get_request {
    NSURL * url = [NSURL URLWithString:@"http://localhost:8090/get"];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLSessionDataTask * task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@", response);
        NSLog(@"%@", [[NSString alloc]initWithData:data encoding:(NSUTF8StringEncoding)]);
    }];
    [task resume];
    
    [[[NSURLSession sharedSession]dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@", response);
        NSLog(@"%@", [[NSString alloc]initWithData:data encoding:(NSUTF8StringEncoding)]);
    }] resume];
}

- (void)post_request {
    NSURL * url = [NSURL URLWithString:@"http://localhost:8090/post"];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"iOS 12" forHTTPHeaderField:@"User-Agent"];
    request.timeoutInterval = 15.;//.0001;
    request.HTTPMethod = @"POST";
    request.HTTPBody = [@"username=Castie!&pwd=666" dataUsingEncoding:(NSUTF8StringEncoding)];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue new] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (connectionError) {
            NSLog(@"%@", connectionError);
            return;
        }
        NSLog(@"%@", response);
        NSLog(@"%@", [[NSString alloc]initWithData:data encoding:(NSUTF8StringEncoding)]);
    }];
#pragma clang diagnostic pop
}

- (void)async_request_delegate {
    NSURL * url = [NSURL URLWithString:[@"http://localhost:8090/get" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    //    NSURLConnection * conn = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    //    [conn cancel];
    NSURLConnection * conn = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
    [conn start];
#pragma clang diagnostic pop
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"%s", __func__);
    NSLog(@"%@", response);
    self.data = [NSMutableData data];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSLog(@"%s", __func__);
    [self.data appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"%s", __func__);
    NSLog(@"%@", [[NSString alloc]initWithData:self.data encoding:(NSUTF8StringEncoding)]);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"%s", __func__);
}

- (void)async_request {
    NSURL * url = [NSURL URLWithString:@"http://localhost:8090/get"];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        NSLog(@"%@", [NSThread currentThread]);
        NSLog(@"%@", response);
        NSLog(@"%@", [[NSString alloc]initWithData:data encoding:(NSUTF8StringEncoding)]);
    }];
#pragma clang diagnostic pop
}

- (void)sync_request {
    NSURL * url = [NSURL URLWithString:@"http://localhost:8090/get"];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    NSURLResponse * response = nil;
    NSError * error = nil;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
#pragma clang diagnostic pop
    NSLog(@"%@", response);
    NSLog(@"%@", [[NSString alloc]initWithData:data encoding:(NSUTF8StringEncoding)]);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"identifier"];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@">>>>>>");
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self performSelector:NSSelectorFromString([self.dataSource[indexPath.row] componentsSeparatedByString:@" - "][1])];
#pragma clang diagnostic pop
}

@end
