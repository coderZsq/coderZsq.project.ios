//
//  SQSettingCell.m
//  UI
//
//  Created by 朱双泉 on 2018/9/26.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQSettingCell.h"

@implementation SQSettingCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style {
    
    NSString * identifier = NSStringFromClass([self class]);
    SQSettingCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[SQSettingCell alloc]initWithStyle:style reuseIdentifier:identifier];
        cell.layer.cornerRadius = 8;
    }
    return cell;
}

- (void)setFrame:(CGRect)frame {
    CGFloat margin = 10;
    frame.origin.x = margin;
    frame.size.width -= 2 * margin;
    frame.size.height -= 5;
    [super setFrame:frame];
}

@end
