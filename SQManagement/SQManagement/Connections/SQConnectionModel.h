//
//  SQConnectionModel.h
//  SQManagement
//
//  Created by 朱双泉 on 2019/9/28.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQConnectionModel : NSObject

@property (nonatomic, strong) NSData *profile;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *role;
@property (nonatomic, copy) NSString *occupation;
@property (nonatomic, copy) NSString *region;
@property (nonatomic, copy) NSString *industry;
@property (nonatomic, copy) NSString *effect;
@property (nonatomic, copy) NSString *intimacy;
@property (nonatomic, copy) NSString *goldenCircle;

- (void)map:(NSUInteger)row bind:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
