//
//  ViewModelTemplate.m
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/5.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import "<#Root#><#Unit#>ViewModel.h"
#import "<#Root#><#Unit#>Model.h"

@implementation <#Root#><#Unit#>ViewModel

- (<#Root#><#Unit#>Model *)model {
    
    if (!_model) {
        _model = [<#Root#><#Unit#>Model new];
    }
    return _model;
}

- (void)initializeWithModel:(id<<#Root#><#Unit#>ModelInterface>)model <#InitializeInterface#>completion:(void(^)())completion {

}

<#ViewModelImplementation#>
@end
