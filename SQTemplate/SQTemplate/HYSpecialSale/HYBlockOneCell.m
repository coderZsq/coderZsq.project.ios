//
//  TableViewCellTemplate.m
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/11.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import "HYBlockOneCell.h"
#import "HYBlockOneView.h"

@interface HYBlockOneCell ()

@property (nonatomic,strong) HYBlockOneView * blockOneView;

@end

@implementation HYBlockOneCell

- (void)dealloc {
    NSLog(@"%@ - execute %s",NSStringFromClass([self class]),__func__);
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    NSString * identifier = NSStringFromClass([HYBlockOneCell class]);
    HYBlockOneCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HYBlockOneCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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

- (HYBlockOneView *)blockOneView {

    if (!_blockOneView) {
        _blockOneView = [HYBlockOneView new];
    }
    return _blockOneView;
}

- (void)setupSubviews {
    [self addSubview:self.blockOneView];
}

- (void)setAdapter:(id<HYBlockOneCellAdapter>)adapter {
    _adapter = adapter;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat blockOneViewX = 0;
    CGFloat blockOneViewY = 0;
    CGFloat blockOneViewW = self.frame.size.width;
    CGFloat blockOneViewH = self.frame.size.height;
    _blockOneView.frame = CGRectMake(blockOneViewX, blockOneViewY, blockOneViewW, blockOneViewH);

}

+ (CGFloat)cellHeight {
    return 190;
}

@end
