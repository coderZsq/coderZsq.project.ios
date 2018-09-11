//
//  ContactModel.h
//  UI
//
//  Created by 朱双泉 on 2018/9/11.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactModel : NSObject

@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * tel;
@property (nonatomic, strong) UIImage * image;
+ (instancetype)contactModelWithName:(NSString *)name tel:(NSString *)tel image:(UIImage *)image;

@end
