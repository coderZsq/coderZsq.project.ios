//
//  ComponentCell.m
//  SQPerformance
//
//  Created by 朱双泉 on 2018/7/5.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "ComponentCell.h"
#import "ComponentLayout.h"
#import "Element.h"
#import "ReusePool.h"

@interface ComponentCell ()
@property (nonatomic, strong) ReusePool * reusePool;
@end

@implementation ComponentCell

- (void)dealloc {
#if DEBUG
    NSLog(@"--------");
    NSLog(@"%@ - execute %s",NSStringFromClass([self class]),__func__);
    NSLog(@"--------");
#endif
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    NSString * identifier = NSStringFromClass([ComponentCell class]);
    ComponentCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ComponentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell setupConfig];
    }
    return cell;
}

- (void)setupConfig {
    _reusePool = [ReusePool new];
}

- (void)setupData:(ComponentLayout *)layout {

    for (Element * element in layout.labels) {
        UILabel * label = (UILabel *)[_reusePool dequeueReusableView];
        if (!label) {
            label = [UILabel new];
            [_reusePool addUsingView:label];
        }
        label.text = element.value;
        label.frame = element.frame;
        label.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:label];
    }
    [_reusePool reset];
}

@end
