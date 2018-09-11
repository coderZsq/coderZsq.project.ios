//
//  ContactModel.m
//  UI
//
//  Created by 朱双泉 on 2018/9/11.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "ContactModel.h"

@implementation ContactModel

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.tel = [aDecoder decodeObjectForKey:@"tel"];
        self.image = [aDecoder decodeObjectForKey:@"image"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.tel forKey:@"tel"];
    [aCoder encodeObject:self.image forKey:@"image"];
}

+ (instancetype)contactModelWithName:(NSString *)name tel:(NSString *)tel image:(UIImage *)image {
    ContactModel * model = [self new];
    model.name = name;
    model.tel = tel;
    model.image = image;
    return model;
}

@end
