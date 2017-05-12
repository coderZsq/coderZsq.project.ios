//
//  ViewTemplate.m
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/5.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import "HYSpecialSaleView.h"
#import "HYBlockOneCell.h"
#import "HYBlockTwoCell.h"
#import "HYBlockThreeCell.h"
#import "HYBlockFourCell.h"
#import "HYBlockFiveCell.h"

@interface HYSpecialSaleView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * cellConfigArrM;

@end

@implementation HYSpecialSaleView

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

- (NSMutableArray *)cellConfigArrM {
    
    if (!_cellConfigArrM) {
        _cellConfigArrM = @[].mutableCopy;
    }
    return _cellConfigArrM;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (void)setupSubviews {
    [self addSubview:self.tableView];
}

- (void)setHyspecialsaleViewModel:(id<HYSpecialSaleViewModelInterface>)hyspecialsaleViewModel {
    _hyspecialsaleViewModel = hyspecialsaleViewModel;
    
    [self.cellConfigArrM removeAllObjects];
    [self.cellConfigArrM addObject:@{@"cell" : [HYBlockOneCell cellWithTableView:_tableView],
                                     @"height" : @([HYBlockOneCell cellHeight])}];
    [self.cellConfigArrM addObject:@{@"cell" : [HYBlockTwoCell cellWithTableView:_tableView],
                                     @"height" : @([HYBlockTwoCell cellHeight])}];
    [self.cellConfigArrM addObject:@{@"cell" : [HYBlockThreeCell cellWithTableView:_tableView],
                                     @"height" : @([HYBlockThreeCell cellHeight])}];
    [self.cellConfigArrM addObject:@{@"cell" : [HYBlockFourCell cellWithTableView:_tableView],
                                     @"height" : @([HYBlockFourCell cellHeight])}];
    [self.cellConfigArrM addObject:@{@"cell" : [HYBlockFiveCell cellWithTableView:_tableView],
                                     @"height" : @([HYBlockFiveCell cellHeight])}];
    [_tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellConfigArrM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HYBlockOneCell * cell = self.cellConfigArrM[indexPath.row][@"cell"];
    cell.adapter = nil;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSNumber * height = self.cellConfigArrM[indexPath.row][@"height"];
    return height.floatValue;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _tableView.frame = self.bounds;
}

@end


