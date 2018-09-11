//
//  NavigationViewController2.h
//  UI
//
//  Created by 朱双泉 on 2018/9/11.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ContactModel;
@interface NavigationViewController2 : UITableViewController

@property (nonatomic, copy) NSString * accountName;
@property (nonatomic, strong) ContactModel * model;

@end
