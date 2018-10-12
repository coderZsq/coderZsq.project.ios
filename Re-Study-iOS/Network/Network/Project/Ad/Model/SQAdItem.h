//
//  SQAdItem.h
//  Network
//
//  Created by 朱双泉 on 2018/10/12.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQAdItem : NSObject

@property (nonatomic, strong) NSString * w_picurl;
@property (nonatomic, strong) NSString * ori_curl;
@property (nonatomic, assign) CGFloat w;
@property (nonatomic, assign) CGFloat h;

@end

NS_ASSUME_NONNULL_END
