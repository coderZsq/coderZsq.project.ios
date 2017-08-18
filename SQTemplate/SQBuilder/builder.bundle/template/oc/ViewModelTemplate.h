//
//  ViewModelTemplate.h
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/5.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "<#Root#><#Unit#>Interface.h"

@interface <#Root#><#Unit#>ViewModel : NSObject <<#Root#><#Unit#>ViewModelInterface>

@property (nonatomic,strong) id<<#Root#><#Unit#>ModelInterface> model;

- (void)initializeWithModel:(id<<#Root#><#Unit#>ModelInterface>)model <#InitializeInterface#>completion:(void(^)())completion;
<#ViewModelInterface#>

@end
