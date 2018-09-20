//
//  SQCoverView.h
//  UI
//
//  Created by 朱双泉 on 2018/9/20.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SQCoverView;
@protocol SQCoverViewDelegate <NSObject>
- (void)coverViewDidClosed:(SQCoverView *)coverView;
@end

@interface SQCoverView : UIView

@property (nonatomic, weak) id<SQCoverViewDelegate> delegate;
@property (nonatomic, copy) void(^didClosedBlock)(SQCoverView *);
+ (instancetype)show;

@end

NS_ASSUME_NONNULL_END
