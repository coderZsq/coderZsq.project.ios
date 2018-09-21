//
//  SQMessageViewController.m
//  UI
//
//  Created by 朱双泉 on 2018/9/20.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQMessageViewController.h"

@interface SQMessageViewController ()
@property (nonatomic, weak) UIView * nearbyView;
@end

@implementation SQMessageViewController

- (UIView *)nearbyView {
    
    if (!_nearbyView) {
        UIView * nearbyView = [[UIView alloc]initWithFrame:self.view.bounds];
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:nearbyView.bounds];
        imageView.image = [UIImage imageNamed:@"sq_navbg"];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [nearbyView addSubview:imageView];
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
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"identifier"];
    }
    cell.textLabel.text = @"https://coderZsq.github.io";
    return cell;
}

@end
