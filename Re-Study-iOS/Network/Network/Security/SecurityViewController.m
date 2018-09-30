//
//  SecurityViewController.m
//  Network
//
//  Created by 朱双泉 on 2018/9/30.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SecurityViewController.h"
#import "NSString+Hash.h"
#import "EncryptionTools.h"
#import "RSACryptor.h"
#import <AFNetworking.h>

@interface SecurityViewController () <NSURLSessionDataDelegate>
@property (nonatomic, copy) NSArray * dataSource;
@end

@implementation SecurityViewController

- (NSArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = @[@"Encryption - base64 - excute",
                        @"Encryption - md5 - excute",
                        @"Encryption - aes_ecb - excute",
                        @"Encryption - aes_cbc - excute",
                        @"Encryption - des_ecb - excute",
                        @"Encryption - des_cbc - excute",
                        @"Encryption - rsa - excute",
                        @"Encryption - session_https - excute",
                        @"Encryption - afn_https - excute"];
    }
    return _dataSource;
}

- (void)afn_https {
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy.validatesDomainName = NO;
    [manager GET:@"https://kyfw.12306.cn/otn" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (void)session_https {
    NSURL * url = [NSURL URLWithString:@"https://kyfw.12306.cn/otn"];
    NSURLSession * session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    [[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@", [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
    }]resume] ;
}

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
    NSLog(@"%@", challenge.protectionSpace);
#if 0
    typedef NS_ENUM(NSInteger, NSURLSessionAuthChallengeDisposition) {
        NSURLSessionAuthChallengeUseCredential = 0,                                       /* Use the specified credential, which may be nil */
        NSURLSessionAuthChallengePerformDefaultHandling = 1,                              /* Default handling for the challenge - as if this delegate were not implemented; the credential parameter is ignored. */
        NSURLSessionAuthChallengeCancelAuthenticationChallenge = 2,                       /* The entire request will be canceled; the credential parameter is ignored. */
        NSURLSessionAuthChallengeRejectProtectionSpace = 3,                               /* This challenge is rejected and the next authentication protection space should be tried; the credential parameter is ignored. */
    } NS_ENUM_AVAILABLE(NSURLSESSION_AVAILABLE, 7_0);
#endif
    if (![challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        return;
    }
    completionHandler(NSURLSessionAuthChallengeUseCredential, [[NSURLCredential alloc]initWithTrust:challenge.protectionSpace.serverTrust]);
}

- (void)rsa {
    // $ openssl genrsa -out private.pem 1024
    // $ openssl req -new -key private.pem -out rsacert.csr
    // $ openssl x509 -req -days 3650 -in rsacert.csr -signkey private.pem -out rsacert.crt
    // $ openssl x509 -outform der -in rsacert.crt -out rsacert.der
    // $ openssl pkcs12 -export -out p.p12 -inkey private.pem -in rsacert.crt
    
    [[RSACryptor sharedRSACryptor] loadPublicKey:[[NSBundle mainBundle]pathForResource:@"rsacert.der" ofType:nil]];
    NSData * data = [[RSACryptor sharedRSACryptor] encryptData:[@"Castie!" dataUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"%@", [data base64EncodedStringWithOptions:0]);
    [[RSACryptor sharedRSACryptor]loadPrivateKey:[[NSBundle mainBundle] pathForResource:@"p.p12" ofType:nil] password:@"666666"];
    NSLog(@"%@", [[NSString alloc]initWithData:[[RSACryptor sharedRSACryptor] decryptData:data] encoding:NSUTF8StringEncoding]);
}

- (void)des_cbc {
    [EncryptionTools sharedEncryptionTools].algorithm = kCCAlgorithmDES;
    uint8_t iv[8] = {1, 2, 3, 4, 5, 6, 7, 8};
    NSData * data = [[NSData alloc]initWithBytes:iv length:sizeof(iv)];
    NSLog(@"%@", [[EncryptionTools sharedEncryptionTools] encryptString:@"Castiel" keyString:@"abc" iv:data]);
    NSLog(@"%@", [[EncryptionTools sharedEncryptionTools] decryptString:@"lbN/n1sCaR4=" keyString:@"abc" iv:data]);
}

- (void)des_ecb {
    [EncryptionTools sharedEncryptionTools].algorithm = kCCAlgorithmDES;
    // $ echo -n "Castiel" | openssl enc -des-ecb -K 616263 -nosalt | base64
    NSLog(@"%@", [[EncryptionTools sharedEncryptionTools] encryptString:@"Castiel" keyString:@"abc" iv:nil]);
    // $ echo -n "fzeeN1R++kY=" | base64 -D | openssl enc -des-ecb -K 616263 -nosalt -d
    NSLog(@"%@", [[EncryptionTools sharedEncryptionTools] decryptString:@"fzeeN1R++kY=" keyString:@"abc" iv:nil]);
}

- (void)aes_cbc {
    [EncryptionTools sharedEncryptionTools].algorithm = kCCAlgorithmAES;
    uint8_t iv[8] = {1, 2, 3, 4, 5, 6, 7, 8};
    NSData * data = [[NSData alloc]initWithBytes:iv length:sizeof(iv)];
    // $ echo -n "Castiel" | openssl enc -aes-128-cbc -K 616263 -nosalt -iv 0102030405060708 | base64
    NSLog(@"%@", [[EncryptionTools sharedEncryptionTools] encryptString:@"Castiel" keyString:@"abc" iv:data]);
    // $ echo -n "KvsrLIFNHGD5HvO25ZqFMw==" | base64 -D | openssl enc -aes-128-cbc -K 616263 -nosalt -iv 0102030405060708 -d
    NSLog(@"%@", [[EncryptionTools sharedEncryptionTools] decryptString:@"KvsrLIFNHGD5HvO25ZqFMw==" keyString:@"abc" iv:data]);
}

- (void)aes_ecb {
    [EncryptionTools sharedEncryptionTools].algorithm = kCCAlgorithmAES;

    // $ echo -n "Castiel" | openssl enc -aes-128-ecb -K 616263 -nosalt | base64
    NSLog(@"%@", [[EncryptionTools sharedEncryptionTools] encryptString:@"Castiel" keyString:@"abc" iv:nil]);
    // $ echo -n "yTj1irLXvMe1LmZqZIcxTQ==" | base64 -D | openssl enc -aes-128-ecb -K 616263 -nosalt -d
    NSLog(@"%@", [[EncryptionTools sharedEncryptionTools] decryptString:@"yTj1irLXvMe1LmZqZIcxTQ==" keyString:@"abc" iv:nil]);
}

- (void)md5 {
    NSLog(@"%@", [@"Castie!" md5String]);
    NSLog(@"%@", [@"Castie!" hmacMD5StringWithKey:@"666"]);
}

- (void)base64 {
    NSLog(@"%@", [self base64Encoding:@"Castie!"]);
    NSLog(@"%@", [self base64Decoding:@"Q2FzdGllIQ=="]);
}

- (NSString *)base64Encoding:(NSString *)string {
    NSData * data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:kNilOptions];
}

- (NSString *)base64Decoding:(NSString *)string {
    NSData * data = [[NSData alloc]initWithBase64EncodedString:string options:kNilOptions];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Security";
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
