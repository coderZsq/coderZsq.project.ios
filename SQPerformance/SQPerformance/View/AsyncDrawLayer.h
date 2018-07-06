//
//  AsyncDrawLayer.h
//  SQPerformance
//
//  Created by 朱双泉 on 2018/7/6.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface AsyncDrawLayer : CALayer

@property (nonatomic,assign, readonly) NSInteger drawsCount;

- (void)increaseCount;

@end
