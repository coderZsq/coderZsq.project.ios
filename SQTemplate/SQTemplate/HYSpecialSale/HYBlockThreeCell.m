//
//  TableViewCellTemplate.m
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/11.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import "HYBlockThreeCell.h"
#import "HYBlockThreeView.h"

@interface HYBlockThreeCell ()

@property (nonatomic,strong) HYBlockThreeView * blockThreeView;

@end

@implementation HYBlockThreeCell

- (void)dealloc {
    NSLog(@"%@ - execute %s",NSStringFromClass([self class]),__func__);
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    NSString * identifier = NSStringFromClass([HYBlockThreeCell class]);
    HYBlockThreeCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HYBlockThreeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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

- (HYBlockThreeView *)blockThreeView {

    if (!_blockThreeView) {
        _blockThreeView = [HYBlockThreeView new];
    }
    return _blockThreeView;
}



- (void)setupSubviews {
    [self addSubview:self.blockThreeView];
}

- (void)setAdapter:(id<HYBlockThreeCellAdapter>)adapter {
    _adapter = adapter;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat blockThreeViewX = 0;
    CGFloat blockThreeViewY = 0;
    CGFloat blockThreeViewW = self.frame.size.width;
    CGFloat blockThreeViewH = self.frame.size.height;
    _blockThreeView.frame = CGRectMake(blockThreeViewX, blockThreeViewY, blockThreeViewW, blockThreeViewH);

}

+ (CGFloat)cellHeight {
    return 270;
}

@end
