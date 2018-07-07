//
//  ViewModel.h
//  SQPerformance
//
//  Created by 朱双泉 on 2018/7/5.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Service.h"

@class ComponentModel;
@class ComponentLayout;

typedef void(^LayoutCompeltionBlock)(NSArray <ComponentLayout *>* layouts);

@interface ViewModel : NSObject

@property (nonatomic,strong) Service *service;

- (void)reloadData:(LayoutCompeltionBlock)completion error:(void(^)(void))error;

- (void)loadMoreData:(LayoutCompeltionBlock)completion;

@end
