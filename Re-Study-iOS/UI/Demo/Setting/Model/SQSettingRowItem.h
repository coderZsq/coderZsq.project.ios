//
//  SQSettingRowItem.h
//  UI
//
//  Created by 朱双泉 on 2018/9/25.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    SQRowTypeArrow,
    SQRowTypeSwitch,
} SQRowType;

@interface SQSettingRowItem : NSObject

@property (nonatomic, strong) UIImage * image;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, assign) SQRowType rowType;
@property (nonatomic, assign) Class destinationClass;

+ (instancetype)itemWithImage:(UIImage *)image title:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
