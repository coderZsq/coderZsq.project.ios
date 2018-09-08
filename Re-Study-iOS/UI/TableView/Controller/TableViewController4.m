//
//  TableViewController4.m
//  UI
//
//  Created by 朱双泉 on 2018/9/8.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "TableViewController4.h"
#import <MJExtension.h>

@interface __Model3: NSObject
@property (nonatomic, copy) NSString * text;
@property (nonatomic, copy) NSString * subtitle;
@property (nonatomic, assign) NSInteger count;
@end

@implementation __Model3
@end

@interface __Button2 : UIButton
@end

@implementation __Button2

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.borderColor = [UIColor colorWithRed:47./255. green:47./131. blue:244./255. alpha:.5].CGColor;
    self.layer.borderWidth = 1.;
    self.layer.cornerRadius = self.frame.size.width * .5;
    self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 5, 0);
}

@end

@class TableViewCell2;
@protocol TableViewCell2Delegate <NSObject>
@optional
- (void)tableViewCell2DidClickedPlusButton:(TableViewCell2 *)cell;
- (void)tableViewCell2DidClickedMinusButton:(TableViewCell2 *)cell;
@end

@interface TableViewCell2 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (nonatomic, strong) __Model3 * model;
@property (nonatomic, weak) id<TableViewCell2Delegate> delegate;
@end

@interface TableViewCell2 ()
@property (weak, nonatomic) IBOutlet __Button2 *plusButton;
@property (weak, nonatomic) IBOutlet __Button2 *minusButton;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@end

@implementation TableViewCell2

- (void)setModel:(__Model3 *)model {
    _model = model;
    self.label1.text = model.text;
    self.label2.text = [NSString stringWithFormat:@"€ %@", model.subtitle];
    self.countLabel.text = [NSString stringWithFormat:@"%ld", self.model.count];
    self.minusButton.enabled = model.count > 0;
}

- (IBAction)plusButtonClick:(__Button2 *)sender {
    self.countLabel.text = [NSString stringWithFormat:@"%ld", ++self.model.count];
    self.minusButton.enabled = YES;
    if ([self.delegate respondsToSelector:@selector(tableViewCell2DidClickedPlusButton:)]) {
        [self.delegate tableViewCell2DidClickedPlusButton:self];
    }
#if 0
    [[NSNotificationCenter defaultCenter] postNotificationName:@"plusButtonClickNotification" object:self];
#endif
}

- (IBAction)minusButtonClick:(__Button2 *)sender {
    self.countLabel.text = [NSString stringWithFormat:@"%ld", --self.model.count];
    if (self.model.count == 0)
        self.minusButton.enabled = NO;
    if ([self.delegate respondsToSelector:@selector(tableViewCell2DidClickedMinusButton:)]) {
        [self.delegate tableViewCell2DidClickedMinusButton:self];
    }
#if 0
    [[NSNotificationCenter defaultCenter] postNotificationName:@"minusButtonClickNotification" object:self];
#endif
}

@end

@interface TableViewController4 () <UITableViewDataSource, UITableViewDelegate, TableViewCell2Delegate>
@property (nonatomic, copy) NSArray * dataSource;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *buyButton;
@property (nonatomic, strong) NSMutableSet * cartSet;
@end

@implementation TableViewController4
#if 0
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    for (__Model3 * model in self.dataSource) {
        [model removeObserver:self forKeyPath:@"count"];
    }
}
#endif
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Cart Demo";

#if 0
    NSLog(@"%@", [UIDevice currentDevice].systemVersion);
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(plusButtonClick:) name:@"plusButtonClickNotification" object:nil];
    [center addObserver:self selector:@selector(minusButtonClick:) name:@"minusButtonClickNotification" object:nil];
#endif
}

- (IBAction)clearButtonClick:(UIButton *)sender {
    NSMutableArray * indexArray = [NSMutableArray array];
    for (NSInteger i = 0; i < self.dataSource.count; i++) {
        __Model3 * model = self.dataSource[i];
        if (model.count != 0) {
            model.count = 0;
            [indexArray addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        }
    }
    [self.tableView reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationAutomatic];
    self.totalPriceLabel.text = @"0";
    self.buyButton.enabled = NO;
    [self.cartSet removeAllObjects];
}

- (IBAction)buyButtonClick:(UIButton *)sender {
    NSLog(@"{\n");
    for (__Model3 * model in self.cartSet) {
        NSLog(@"%@ - %ldpcs - €%@", model.text, model.count, model.subtitle);
    }
    NSLog(@"}\n");
}
#if 0
- (void)plusButtonClick:(NSNotification *)sender {
    TableViewCell2 * cell = sender.object;
    NSInteger totolPrice = self.totalPriceLabel.text.integerValue + cell.model.subtitle.integerValue;
    self.totalPriceLabel.text = [NSString stringWithFormat:@"%ld", totolPrice];
    self.buyButton.enabled = YES;
}

- (void)minusButtonClick:(NSNotification *)sender {
    TableViewCell2 * cell = sender.object;
    NSInteger totolPrice = self.totalPriceLabel.text.integerValue - cell.model.subtitle.integerValue;
    self.totalPriceLabel.text = [NSString stringWithFormat:@"%ld", totolPrice];
    self.buyButton.enabled = totolPrice > 0;
}
#endif

- (NSMutableSet *)cartSet {
    
    if (!_cartSet) {
        _cartSet = [NSMutableSet set];
    }
    return _cartSet;
}

- (NSArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = [__Model3 mj_objectArrayWithFilename:@"cart.plist"];
#if 0
        for (__Model3 * model in _dataSource) {
            [model addObserver:self forKeyPath:@"count" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
        }
#endif
    }
    return _dataSource;
}
#if 0
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([object isKindOfClass:[__Model3 class]]) {
        __Model3 * model = (__Model3 *)object;
        NSInteger old = [change[NSKeyValueChangeOldKey] integerValue];
        NSInteger new = [change[NSKeyValueChangeNewKey] integerValue];
        if (new > old) {
            NSInteger totolPrice = self.totalPriceLabel.text.integerValue + model.subtitle.integerValue;
            self.totalPriceLabel.text = [NSString stringWithFormat:@"%ld", totolPrice];
            self.buyButton.enabled = YES;
        } else {
            NSInteger totolPrice = self.totalPriceLabel.text.integerValue - model.subtitle.integerValue;
            self.totalPriceLabel.text = [NSString stringWithFormat:@"%ld", totolPrice];
            self.buyButton.enabled = totolPrice > 0;
        }
    }
}
#endif
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    __Model3 * model = self.dataSource[indexPath.row];
    TableViewCell2 * cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    cell.model = model;
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableViewCell2DidClickedPlusButton:(TableViewCell2 *)cell {
    NSInteger totolPrice = self.totalPriceLabel.text.integerValue + cell.model.subtitle.integerValue;
    self.totalPriceLabel.text = [NSString stringWithFormat:@"%ld", totolPrice];
    self.buyButton.enabled = YES;
    [self.cartSet addObject:cell.model];
}

- (void)tableViewCell2DidClickedMinusButton:(TableViewCell2 *)cell {
    NSInteger totolPrice = self.totalPriceLabel.text.integerValue - cell.model.subtitle.integerValue;
    self.totalPriceLabel.text = [NSString stringWithFormat:@"%ld", totolPrice];
    self.buyButton.enabled = totolPrice > 0;
    if (cell.model.count == 0) {
        [self.cartSet removeObject:cell.model];
    }
}

@end
