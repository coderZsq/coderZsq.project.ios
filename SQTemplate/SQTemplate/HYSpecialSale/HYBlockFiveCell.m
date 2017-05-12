//
//  TableViewCellTemplate.m
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/11.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import "HYBlockFiveCell.h"
#import "HYBlockFiveView.h"

@interface HYBlockFiveCell ()

@property (nonatomic,strong) HYBlockFiveView * blockFiveView;

@end

@implementation HYBlockFiveCell

- (void)dealloc {
    NSLog(@"%@ - execute %s",NSStringFromClass([self class]),__func__);
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    NSString * identifier = NSStringFromClass([HYBlockFiveCell class]);
    HYBlockFiveCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HYBlockFiveCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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

- (HYBlockFiveView *)blockFiveView {

    if (!_blockFiveView) {
        _blockFiveView = [HYBlockFiveView new];
    }
    return _blockFiveView;
}



- (void)setupSubviews {

    [self addSubview:self.blockFiveView];
}

- (void)setAdapter:(id<HYBlockFiveCellAdapter>)adapter {
    _adapter = adapter;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat blockFiveViewX = 0;
    CGFloat blockFiveViewY = 0;
    CGFloat blockFiveViewW = self.frame.size.width;
    CGFloat blockFiveViewH = self.frame.size.height;
    _blockFiveView.frame = CGRectMake(blockFiveViewX, blockFiveViewY, blockFiveViewW, blockFiveViewH);

}

+ (CGFloat)cellHeight {
    return 50 + [UIScreen mainScreen].bounds.size.width + 100;
}

@end
