//
//  TableViewCellTemplate.m
//  SQTemplate
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

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    NSString * identifier = NSStringFromClass([<#Unit#>Cell class]);
    <#Unit#>Cell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[<#Unit#>Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
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

+ (CGFloat)cellHeight {
    return <#cellHeight#>;
}

@end
