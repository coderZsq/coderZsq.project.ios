//
//  SQSceneView.h
//  SQNumbers
//
//  Created by 朱双泉 on 2020/9/11.
//  Copyright © 2020 朱双泉. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQSceneView : UIView

@property (nonatomic, assign) NSUInteger capacity;

- (void)renderToCanvas:(UIView *)superView;

@end

NS_ASSUME_NONNULL_END
