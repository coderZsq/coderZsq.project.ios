//
//  SQFetchReachability.h
//  SQPerformance
//
//  Created by 朱双泉 on 2018/8/23.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface SQFetchReachability : NSObject

@property (nonatomic,assign) NetworkStatus status;

+ (instancetype)sharedInstance;

@end
