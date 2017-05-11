//
//  ViewModelTemplate.h
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/5.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InterfaceTemplate.h"

@interface ViewModelTemplate : NSObject <ViewModelInterface>

@property (nonatomic,strong) id<ModelInterface> model;

- (void)dynamicBindingWithFinishedCallBack:(void (^)())finishCallBack;

@end
