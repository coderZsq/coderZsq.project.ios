//
//  PresenterTemplate.h
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/5.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "<#Root#><#Unit#>Interface.h"

@interface <#Root#><#Unit#>Presenter : NSObject<<#Root#><#Unit#>ViewModelInterface>

<#InitializeProperty#>
- (void)adapterWith<#Unit#>View:(id<<#Root#><#Unit#>ViewInterface>)<#unit#>View <#unit#>ViewModel:(id<<#Root#><#Unit#>ViewModelInterface>)<#unit#>ViewModel;

@end
