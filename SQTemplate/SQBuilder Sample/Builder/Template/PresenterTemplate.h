//
//  PresenterTemplate.h
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/5.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "<#Unit#>Interface.h"

@interface <#Unit#>Presenter : NSObject<<#Unit#>ViewOperation>

@property (nonatomic,weak) id<<#Unit#>ViewInterface> <#unit#>View;
@property (nonatomic,weak) id<<#Unit#>ViewModelInterface> <#unit#>ViewModel;

- (void)adapterWith<#Unit#>View:(id<<#Unit#>ViewInterface>)<#unit#>View <#unit#>ViewModel:(id<<#Unit#>ViewModelInterface>)<#unit#>ViewModel;

@end
