//
//  SQDiscoveryItem.h
//  UI
//
//  Created by 朱双泉 on 2018/9/21.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class SQDiscoveryHeaderItem;
@interface SQDiscoveryItem : NSObject

@property (nonatomic, strong) SQDiscoveryHeaderItem * header;
@property (nonatomic, copy) NSArray * themes;

+ (NSArray *)getDiscoveryList;

@end

NS_ASSUME_NONNULL_END
