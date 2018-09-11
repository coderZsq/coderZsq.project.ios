//
//  ContactModel.m
//  UI
//
//  Created by 朱双泉 on 2018/9/11.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "ContactModel.h"

@implementation ContactModel

+ (instancetype)contactModelWithName:(NSString *)name tel:(NSString *)tel image:(UIImage *)image {
    ContactModel * model = [self new];
    model.name = name;
    model.tel = tel;
    model.image = image;
    return model;
}

@end
