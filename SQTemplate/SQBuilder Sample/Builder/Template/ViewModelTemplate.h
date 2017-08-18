//
//  ViewModelTemplate.h
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/5.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "<#Unit#>Interface.h"

@interface <#Unit#>ViewModel : NSObject <<#Unit#>ViewModelInterface>

@property (nonatomic,strong) id<<#Unit#>ModelInterface> model;

- (void)initializeWithParameter:(NSDictionary *)parameter finishedCallBack:(void(^)())finishCallBack;
<#ViewModelInterface#>

@end
