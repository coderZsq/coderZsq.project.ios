//
//  Service.h
//  SQPerformance
//
//  Created by 朱双泉 on 2018/7/5.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ComponentModel;

typedef void(^RequestCompletionBlock)(NSArray <ComponentModel *> *models, NSError *error);

@interface Service : NSObject

@property (nonatomic, strong, readonly) NSArray <ComponentModel *> *models;

- (void)fetchMockDataWithParam:(NSDictionary *)param completion:(RequestCompletionBlock)block;

@end
