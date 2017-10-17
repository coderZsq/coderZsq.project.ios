//
//  SQSwiperView.h
//  Mall
//
//  Created by 朱双泉 on 12/10/2017.
//  Copyright © 2017 _Zhizi_. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SQSwiperView : UIView

@property (nonatomic,assign) NSInteger numberOfPages;
@property (nonatomic,copy) void(^loadImage)(UIImageView * imageView, NSInteger index);
@property (nonatomic,copy) void(^didSelect)(NSInteger index);

@end
