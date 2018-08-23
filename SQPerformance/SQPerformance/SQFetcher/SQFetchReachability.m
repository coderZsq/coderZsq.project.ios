//
//  SQFetchReachability.m
//  SQPerformance
//
//  Created by 朱双泉 on 2018/8/23.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQFetchReachability.h"

@interface SQFetchReachability()
@property (nonatomic, strong) Reachability * hostReachability;
@property (nonatomic, strong) Reachability * routerReachability;
@end

@implementation SQFetchReachability

+ (void)load {
    [SQFetchReachability sharedInstance];
}

+ (instancetype)sharedInstance {
    static SQFetchReachability * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self sharedInstance];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(appReachabilityChanged:)
                                                     name:kReachabilityChangedNotification
                                                   object:nil];
        NSString * remoteHostName = @"www.baidu.com";
        self.hostReachability = [Reachability reachabilityWithHostName:remoteHostName];
        [self.hostReachability startNotifier];
        self.routerReachability = [Reachability reachabilityForInternetConnection];
        [self.routerReachability startNotifier];
    }
    return self;
}

- (void)appReachabilityChanged:(NSNotification *)notification{
    Reachability * reach = [notification object];
    if([reach isKindOfClass:[Reachability class]]){
        NetworkStatus status = [reach currentReachabilityStatus];
        self.status = status;
        if (reach == self.routerReachability) {
            if (status == NotReachable) {
                NSLog(@"routerReachability NotReachable");
            } else if (status == ReachableViaWiFi) {
                NSLog(@"routerReachability ReachableViaWiFi");
            } else if (status == ReachableViaWWAN) {
                NSLog(@"routerReachability ReachableViaWWAN");
            }
        }
        if (reach == self.hostReachability) {
            NSLog(@"hostReachability");
            if ([reach currentReachabilityStatus] == NotReachable) {
                NSLog(@"hostReachability failed");
            } else if (status == ReachableViaWiFi) {
                NSLog(@"hostReachability ReachableViaWiFi");
            } else if (status == ReachableViaWWAN) {
                NSLog(@"hostReachability ReachableViaWWAN");
            }
        }
        
    }
}

@end
