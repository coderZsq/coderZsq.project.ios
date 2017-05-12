//
//  TableViewCellTemplate.m
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/11.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import "HYBlockTwoCell.h"
#import "HYBlockTwoView.h"

@interface HYBlockTwoCell ()

@property (nonatomic,strong) HYBlockTwoView * blockTwoView;

@end

@implementation HYBlockTwoCell

- (void)dealloc {
    NSLog(@"%@ - execute %s",NSStringFromClass([self class]),__func__);
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    NSString * identifier = NSStringFromClass([HYBlockTwoCell class]);
    HYBlockTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HYBlockTwoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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

- (HYBlockTwoView *)blockTwoView {

    if (!_blockTwoView) {
        _blockTwoView = [HYBlockTwoView new];
    }
    return _blockTwoView;
}

- (void)setupSubviews {

    [self addSubview:self.blockTwoView];
}

- (void)setAdapter:(id<HYBlockTwoCellAdapter>)adapter {
    _adapter = adapter;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat blockTwoViewX = 0;
    CGFloat blockTwoViewY = 0;
    CGFloat blockTwoViewW = self.frame.size.width;
    CGFloat blockTwoViewH = self.frame.size.height;
    _blockTwoView.frame = CGRectMake(blockTwoViewX, blockTwoViewY, blockTwoViewW, blockTwoViewH);
}

+ (CGFloat)cellHeight {
    return 170;
}

@end
