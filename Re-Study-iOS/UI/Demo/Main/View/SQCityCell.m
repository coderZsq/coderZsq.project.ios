//
//  SQCityCell.m
//  UI
//
//  Created by 朱双泉 on 2018/9/21.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQCityCell.h"

@implementation SQCityCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    SQCityCell * cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    if (!cell) {
        cell = [[SQCityCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"identifier"];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = SystemColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

#if 0
- (void)setFrame:(CGRect)frame {
    frame.size.width -= 15;
    [super setFrame:frame];
}
#endif
- (void)layoutSubviews {
    [super layoutSubviews];
    self.textLabel.x = (self.width - self.textLabel.width) * .5 - 3;
}

@end
