//
//  SQSectionItem.h
//  UI
//
//  Created by 朱双泉 on 2018/9/20.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQSectionItem : NSObject

@property (nonatomic, copy) NSString * color;
@property (nonatomic, copy) NSString * tag_name;
@property (nonatomic, copy) NSString * section_count;
@property (nonatomic, copy) NSArray * body;

+ (NSArray *)getSectionItem;

@end

NS_ASSUME_NONNULL_END
