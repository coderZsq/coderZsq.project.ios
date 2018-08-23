//
//  SQFetchManager.h
//  SQPerformance
//
//  Created by 朱双泉 on 2018/8/8.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SQFetchState) {
    SQFetchSerialState,
    SQFetchConcurrentState
};

@interface SQFetchManager : NSObject

@property (nonatomic,strong) SQFetchManager * (^GET)(NSString * url, NSDictionary * parameters, void(^success)(id), void(^failure)(NSError *));

@property (nonatomic,strong) SQFetchManager * (^POST)(NSString * url, NSDictionary * parameters, void(^success)(id), void(^failure)(NSError *));

+ (SQFetchManager *)managerWithState:(SQFetchState)state;

@end
