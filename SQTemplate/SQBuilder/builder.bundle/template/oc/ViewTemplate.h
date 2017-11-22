//
//  ViewTemplate.h
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/5.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "<#Root#><#Unit#>Interface.h"

@interface <#Root#><#Unit#>View : UIView <<#Root#><#Unit#>ViewInterface>

@property (nonatomic,weak) id<<#Root#><#Unit#>ViewModelInterface> <#unit#>ViewModel;
@property (nonatomic,weak) id<<#Root#><#Unit#>ViewModelInterface> <#unit#>Operator;

@end
