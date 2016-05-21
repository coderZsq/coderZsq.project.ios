//
//  SQBadgeView.m
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//


#import "SQBadgeView.h"
#import "UIImage+SQExtension.h"

@implementation SQBadgeView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareForSetup];
    }
    return self;
}

- (void)prepareForSetup {
    [self setHidden:YES];
    [self setUserInteractionEnabled:NO];
    [self setBackgroundImage:[UIImage imageResizableNamed:@""] forState:UIControlStateNormal];
    [self.titleLabel setFont:[UIFont systemFontOfSize:11]];
}

- (void)setBadgeValue:(NSString *)badgeValue {

    _badgeValue = badgeValue.copy;
    
    if (badgeValue) {
        [self setHidden:NO];
        [self setTitle:badgeValue forState:UIControlStateNormal];
        
        CGRect frame   = self.frame;
        CGFloat badgeW = self.currentBackgroundImage.size.width;
        CGFloat badgeH = self.currentBackgroundImage.size.height;
        if (badgeValue.length > 1) {
            CGSize badgeSize = [badgeValue sizeWithAttributes:@{NSFontAttributeName : self.titleLabel.font}];
            badgeW = badgeSize.width + 10;
        }
        frame.size.width = badgeW;
        frame.size.height = badgeH;
        self.frame = frame;
    } else {
        self.hidden = YES;
    }
}

@end
