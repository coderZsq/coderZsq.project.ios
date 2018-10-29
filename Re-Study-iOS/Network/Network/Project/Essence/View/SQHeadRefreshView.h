//
//  SQHeadRefreshView.h
//  Network
//
//  Created by 朱双泉 on 2018/10/29.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQHeadRefreshView : UIView
@property (nonatomic, assign) BOOL isRefreshing;
@property (nonatomic, assign) BOOL isNeedLoad;
+ (instancetype)headView;

@end

NS_ASSUME_NONNULL_END
