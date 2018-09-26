//
//  SQMessageViewController.m
//  UI
//
//  Created by 朱双泉 on 2018/9/20.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQMessageViewController.h"
#import "SQUpdateCell.h"

@interface SQMessageViewController ()
@property (nonatomic, weak) UIView * nearbyView;
@property (nonatomic, weak) UITableView * updateTableView;
@property (nonatomic, assign) NSInteger currentRow;
@property (nonatomic, assign, getter=isOpen) BOOL open;
@end

@implementation SQMessageViewController

- (UIView *)nearbyView {
    
    if (!_nearbyView) {
        UIView * nearbyView = [[UIView alloc]initWithFrame:self.view.bounds];
//        UIImageView * imageView = [[UIImageView alloc]initWithFrame:nearbyView.bounds];
//        imageView.image = [UIImage imageNamed:@"sq_navbg"];
//        imageView.contentMode = UIViewContentModeScaleAspectFill;
//        [nearbyView addSubview:imageView];
        UITableView * tableView = [UITableView new];
        tableView.frame = nearbyView.bounds;
        tableView.dataSource = self;
        tableView.delegate = self;
        _updateTableView = tableView;
        [nearbyView addSubview:tableView];
        [self.view addSubview:nearbyView];
        _nearbyView = nearbyView;
    }
    return _nearbyView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Message";
    UISegmentedControl * segmentedControl = [[UISegmentedControl alloc]initWithItems:@[@"Recommend", @"Nearby"]];
    segmentedControl.selectedSegmentIndex = 0;
//    segmentedControl.width =
//    segmentedControl setTitleTextAttributes:<#(nullable NSDictionary<NSAttributedStringKey,id> *)#> forState:<#(UIControlState)#>
    [segmentedControl addTarget:self action:@selector(segmentedControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segmentedControl;
    self.currentRow = -1;
}

- (void)segmentedControlValueChanged:(UISegmentedControl *)sender {
    self.nearbyView.hidden = !sender.selectedSegmentIndex;
    self.tableView.scrollEnabled = self.nearbyView.hidden;
    self.tableView.contentOffset = CGPointZero;
    CATransition  * animation = [CATransition animation];
    animation.type = @"oglFlip";
    animation.subtype = self.nearbyView.hidden ? @"fromLeft" : @"fromRight";
    animation.duration = .5;
    [self.view.layer addAnimation:animation forKey:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.updateTableView)
        return 10;
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.updateTableView) {
        SQUpdateCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SQUpdateCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"SQUpdateCell" owner:nil options:nil]firstObject];
        }
        return cell;
    }
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"identifier"];
    }
    cell.textLabel.text = @"https://coderZsq.github.io";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == self.updateTableView) {
        self.open = !self.isOpen;
        if (self.currentRow != indexPath.row) {
            self.open = YES;
        }
        self.currentRow = indexPath.row;
        [tableView beginUpdates];
        [tableView endUpdates];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.updateTableView) {}
        return self.currentRow == indexPath.row && self.isOpen ? 230 : 44;
    return 44;
}

@end
