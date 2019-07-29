//
//  SQType2Cell.m
//  SQMagnet
//
//  Created by 朱双泉 on 2019/7/14.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQType2Cell.h"
#import "NSObject+SQExtension.h"

@implementation SQType2Cell

- (IBAction)copyLink:(id)sender {
    [[UIPasteboard generalPasteboard] setString:self.actionLabel.text];
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"已经成功复制链接" message:@"请前往迅雷下载或百度云离线下载\n即可获得资源!" preferredStyle:(UIAlertControllerStyleAlert)];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"知道啦~" style:(UIAlertActionStyleDefault) handler:nil]];
    [[self getCurrentViewController] presentViewController:alertVC animated:YES completion:nil];
}

@end

