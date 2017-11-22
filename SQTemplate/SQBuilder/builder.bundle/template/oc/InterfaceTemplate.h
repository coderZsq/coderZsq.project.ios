//
//  InterfaceTemplate.h
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/5.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol <#Root#><#Unit#>ModelInterface <NSObject>

<#ModelInterface#>
@end

@protocol <#Root#><#Unit#>ViewModelInterface <NSObject>

@optional
@property (nonatomic,strong) id<<#Root#><#Unit#>ModelInterface> model;

@optional
- (void)initializeWithModel:(id<<#Root#><#Unit#>ModelInterface>)model <#InitializeInterface#>completion:(void(^)())completion;
<#ViewModelInterface#>
@end

@protocol <#Root#><#Unit#>ViewInterface <NSObject>

@property (nonatomic,weak) id<<#Root#><#Unit#>ViewModelInterface> <#unit#>ViewModel;
@property (nonatomic,weak) id<<#Root#><#Unit#>ViewModelInterface> <#unit#>Operator;

@end
