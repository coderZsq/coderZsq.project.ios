//
//  TableViewCellTemplate.m
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/11.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import "HYBlockFourCell.h"
#import "HYBlockFourView.h"

@interface HYBlockFourCell ()

@property (nonatomic,strong) HYBlockFourView * blockFourView;

@end

@implementation HYBlockFourCell

- (void)dealloc {
    NSLog(@"%@ - execute %s",NSStringFromClass([self class]),__func__);
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    NSString * identifier = NSStringFromClass([HYBlockFourCell class]);
    HYBlockFourCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HYBlockFourCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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

- (HYBlockFourView *)blockFourView {

    if (!_blockFourView) {
        _blockFourView = [HYBlockFourView new];
    }
    return _blockFourView;
}



- (void)setupSubviews {

    [self addSubview:self.blockFourView];
}

- (void)setAdapter:(id<HYBlockFourCellAdapter>)adapter {
    _adapter = adapter;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat blockFourViewX = 0;
    CGFloat blockFourViewY = 0;
    CGFloat blockFourViewW = self.frame.size.width;
    CGFloat blockFourViewH = self.frame.size.height;
    _blockFourView.frame = CGRectMake(blockFourViewX, blockFourViewY, blockFourViewW, blockFourViewH);

}

+ (CGFloat)cellHeight {
    return 50 + [UIScreen mainScreen].bounds.size.width;
}

@end
