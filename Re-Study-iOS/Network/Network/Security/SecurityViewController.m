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

@interface SecurityViewController ()
@property (nonatomic, copy) NSArray * dataSource;
@end

@implementation SecurityViewController

- (NSArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = @[@"base64 - excute",
                        @"md5 - excute",
                        @"aes_ecb - excute",
                        @"aes_cbc - excute",
                        @"des_ecb - excute"];
    }
    return _dataSource;
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
    [self performSelector:NSSelectorFromString([self.dataSource[indexPath.row] componentsSeparatedByString:@" - "][0])];
#pragma clang diagnostic pop
}

@end
