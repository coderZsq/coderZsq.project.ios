//
//  CollectionViewCellTemplate.m
//  SQTemplate/Users/Doubles_Z/Desktop/SQTemplate/SQTemplate/UITemplate
//
//  Created by 双泉 朱 on 17/5/11.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import "<#Unit#>Cell.h"
<#ViewImport#>
@interface <#Unit#>Cell ()

<#ViewProperty#>
@end

@implementation <#Unit#>Cell

- (void)dealloc {
    NSLog(@"%@ - execute %s",NSStringFromClass([self class]),__func__);
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder  {
    
    self = [super initWithCoder:coder];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

<#ViewLazyLoad#>

- (void)setupSubviews {
<#ViewSetup#>
}

- (void)setAdapter:(id<<#Unit#>CellAdapter>)adapter {
    _adapter = adapter;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
<#ViewLayout#>
}

@end
