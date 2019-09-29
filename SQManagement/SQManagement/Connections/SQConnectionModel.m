//
//  SQConnectionModel.m
//  SQManagement
//
//  Created by 朱双泉 on 2019/9/28.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQConnectionModel.h"

typedef NS_ENUM(NSInteger, SQConnectionProperty) {
    SQConnectionName = 0,
    SQConnectionRole,
    SQConnectionOccupation,
    SQConnectionRegion,
    SQConnectionIndustry,
    SQConnectionEffect,
    SQConnectionIntimacy,
    SQConnectionGoldenCircle,
};

@implementation SQConnectionModel

- (void)map:(NSUInteger)row bind:(UIView *)view {
    switch (row) {
        case SQConnectionName:
            if ([view isKindOfClass:UITextField.class]) {
                self.name = [view valueForKey:@"text"];
            } else if ([view isKindOfClass:UILabel.class]) {
                [view setValue:self.name forKey:@"text"];
            }
            break;
        case SQConnectionRole:
            if ([view isKindOfClass:UITextField.class]) {
                self.role = [view valueForKey:@"text"];
            } else if ([view isKindOfClass:UILabel.class]) {
                [view setValue:self.role forKey:@"text"];
            }
            break;
        case SQConnectionOccupation:
            if ([view isKindOfClass:UITextField.class]) {
                self.occupation = [view valueForKey:@"text"];
            } else if ([view isKindOfClass:UILabel.class]) {
                [view setValue:self.occupation forKey:@"text"];
            }
            break;
        case SQConnectionRegion:
            if ([view isKindOfClass:UITextField.class]) {
                self.region = [view valueForKey:@"text"];
            } else if ([view isKindOfClass:UILabel.class]) {
                [view setValue:self.region forKey:@"text"];
            }
            break;
        case SQConnectionIndustry:
            if ([view isKindOfClass:UITextField.class]) {
                self.industry = [view valueForKey:@"text"];
            } else if ([view isKindOfClass:UILabel.class]) {
                [view setValue:self.industry forKey:@"text"];
            }
            break;
        case SQConnectionEffect:
            if ([view isKindOfClass:UITextField.class]) {
                self.effect = [view valueForKey:@"text"];
            } else if ([view isKindOfClass:UILabel.class]) {
                [view setValue:self.effect forKey:@"text"];
            }
            break;
        case SQConnectionIntimacy:
            if ([view isKindOfClass:UITextField.class]) {
                self.intimacy = [view valueForKey:@"text"];
            } else if ([view isKindOfClass:UILabel.class]) {
                [view setValue:self.intimacy forKey:@"text"];
            }
            break;
        case SQConnectionGoldenCircle:
            if ([view isKindOfClass:UITextField.class]) {
                self.goldenCircle = [view valueForKey:@"text"];
            } else if ([view isKindOfClass:UILabel.class]) {
                [view setValue:self.goldenCircle forKey:@"text"];
            }
            break;
        default:
            break;
    }
}

@end
