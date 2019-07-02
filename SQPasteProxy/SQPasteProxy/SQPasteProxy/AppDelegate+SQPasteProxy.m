//
//  AppDelegate+SQPasteProxy.m
//  SQPasteProxy
//
//  Created by 朱双泉 on 2019/7/2.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "AppDelegate+SQPasteProxy.h"
#import <objc/runtime.h>
#import <SafariServices/SafariServices.h>

@implementation AppDelegate (SQPasteProxy)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method method1 = class_getInstanceMethod(self, @selector(applicationWillEnterForeground:));
        Method method2 = class_getInstanceMethod(self, @selector(sq_applicationWillEnterForeground:));
        method_exchangeImplementations(method1, method2);
    });
}

- (void)sq_applicationWillEnterForeground:(UIApplication *)application {
    [self sq_applicationWillEnterForeground:application];
    NSString *string = [UIPasteboard generalPasteboard].string;
    if ([string hasPrefix:@"http"]) {
        [self sq_tryToRedirectURLFromPasteBoard:string];
    } else if ([string hasPrefix:@"urlscheme"]) {
        // 业务逻辑 路由 可AOP
        
    } else {
        [self sq_tryToPasteAddressFromPasteBoard:string];
    }
}

- (void)sq_tryToRedirectURLFromPasteBoard:(NSString *)string {
    UIAlertController * altc = [UIAlertController alertControllerWithTitle:@"「已捕获」剪贴板地址" message:@"是否要一键跳转 嘻嘻" preferredStyle:(UIAlertControllerStyleAlert)];
    [altc addAction:[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        NSURL *url = [NSURL URLWithString:string];
        SFSafariViewController *safarivc = [[SFSafariViewController alloc] initWithURL:url];
        [[self sq_getCurrentViewController] presentViewController:safarivc animated:YES completion:nil];
    }]];
    [altc addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil]];
    [[self sq_getCurrentViewController] presentViewController:altc animated:YES completion:nil];
}

- (void)sq_tryToPasteAddressFromPasteBoard:(NSString *)string {
    NSArray *array = [self sq_getAddressColumnFromString:string];
    UIViewController *vc = [self sq_getCurrentViewController];
    NSDictionary *config = [self sq_loadAddressConfigFromJSON:@"address_config"];
    if ([config[@"hook-controller"] isEqualToString:NSStringFromClass(vc.class)]) {
        UIAlertController * altc = [UIAlertController alertControllerWithTitle:config[@"alert-title"] message:config[@"alert-message"] preferredStyle:(UIAlertControllerStyleAlert)];
        [altc addAction:[UIAlertAction actionWithTitle:config[@"alert-confirm-title"] style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            NSArray *bindList = config[@"bind-list"];
            NSUInteger bindListCount = bindList.count;
            if (bindListCount == 4) {
                for (int i = 0; i < bindListCount; i++) {
                    [vc setValue:array[i] forKeyPath:[NSString stringWithFormat:@"%@.text", bindList[i]]];
                }
            } else if (bindListCount == 2) {
                NSString *pca = [NSString stringWithFormat:@"%@%@%@", array[0], array[1], array[2]];
                [vc setValue:pca forKeyPath:[NSString stringWithFormat:@"%@.text", bindList[0]]];
                [vc setValue:array[3] forKeyPath:[NSString stringWithFormat:@"%@.text", bindList[1]]];
            } else {
                NSLog(@"配置错误, 请检查配置!");
            }
        }]];
        [altc addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil]];
        [[self sq_getCurrentViewController] presentViewController:altc animated:YES completion:nil];
    }
}

- (NSDictionary *)sq_loadAddressConfigFromJSON:(NSString *)jsonname {
    NSString *path = [[NSBundle mainBundle] pathForResource:jsonname ofType:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:path];
    NSError *error;
    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (!jsonData || error) {
        NSLog(@"JSON解码失败");
        return nil;
    } else {
        return jsonObj;
    }
}

- (NSArray *)sq_getAddressColumnFromString:(NSString *)string {
    NSString *pattern = @"^(.+?[省|市|区|盟|县|行政区划])";
    NSError *error = NULL;
    NSMutableArray *array = [NSMutableArray array];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    while (1) {
        NSTextCheckingResult *result = [regex firstMatchInString:string options:0 range:NSMakeRange(0, string.length)];
        if (result) {
            [array addObject:[string substringWithRange:result.range]];
            string = [string substringFromIndex:result.range.location + result.range.length];
        } else {
            [array addObject:string];
            break;
        }
    }
    if (array.count < 3) {
        NSLog(@"请复制正确格式的地址!");
    } else if (array.count >= 3) {
        NSArray *city = @[@"北京", @"天津", @"上海", @"重庆"];
        NSString *provincelevel = [array.firstObject substringToIndex:2];
        if ([city containsObject:provincelevel]) {
            [array insertObject:provincelevel atIndex:0];
        }
    }
    if (array.count > 4) {
        NSMutableString *address = [NSMutableString string];
        for (int i = 3; i < array.count; i++) {
            [address appendString:array[i]];
        }
        [array insertObject:address atIndex:3];
    }
    return array;
}

- (UIViewController *)sq_getRootViewController{
    return [UIApplication sharedApplication].delegate.window.rootViewController;
}

- (UIViewController *)sq_getCurrentViewController{
    UIViewController* currentViewController = [self sq_getRootViewController];
    BOOL flag = YES;
    while (flag) {
        if (currentViewController.presentedViewController) {
            currentViewController = currentViewController.presentedViewController;
        } else if ([currentViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController* navigationController = (UINavigationController* )currentViewController;
            currentViewController = [navigationController.childViewControllers lastObject];
        } else if ([currentViewController isKindOfClass:[UITabBarController class]]) {
            UITabBarController *tabBarController = (UITabBarController *)currentViewController;
            currentViewController = tabBarController.selectedViewController;
        } else {
            NSUInteger childViewControllerCount = currentViewController.childViewControllers.count;
            if (childViewControllerCount > 0) {
                currentViewController = currentViewController.childViewControllers.lastObject;
                return currentViewController;
            } else {
                return currentViewController;
            }
        }
    }
    return currentViewController;
}

@end
