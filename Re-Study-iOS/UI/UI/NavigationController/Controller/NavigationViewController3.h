//
//  NavigationViewController3.h
//  UI
//
//  Created by 朱双泉 on 2018/9/11.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ContactModel, NavigationViewController3;

@protocol NavigationViewController3Delegate <NSObject>
- (void)navigationViewController3:(NavigationViewController3 *)vc addModel:(ContactModel *)model;
- (void)navigationViewController3:(NavigationViewController3 *)vc saveModel:(ContactModel *)model;
@end

@interface NavigationViewController3 : UIViewController
@property (nonatomic, strong) ContactModel * model;
@property (nonatomic, weak) id<NavigationViewController3Delegate> delegate;
@end
