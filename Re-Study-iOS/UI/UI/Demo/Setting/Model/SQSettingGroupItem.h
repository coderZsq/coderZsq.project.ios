//
//  SQSettingGroupItem.h
//  UI
//
//  Created by 朱双泉 on 2018/9/25.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQSettingGroupItem : NSObject

@property (nonatomic, copy) NSString * headerTitle;
@property (nonatomic, copy) NSString * footerTitle;
@property (nonatomic, copy) NSArray * rowItems;

+ (instancetype)itemWithRowItems:(NSArray *)rowItems;

@end

NS_ASSUME_NONNULL_END
