//
//  ViewController.m
//  SQPerformance
//
//  Created by 朱双泉 on 2018/7/5.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "ViewController.h"
#import "ViewModel.h"
#import "ComponentLayout.h"
#import "ComponentCell.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong) ViewModel * viewModel;
@property (nonatomic,strong) NSMutableArray <ComponentLayout *> * layouts;
@property (nonatomic,strong) UITableView * tableView;

@end

@implementation ViewController

- (NSMutableArray<ComponentLayout *> *)layouts {
    
    if (!_layouts) {
        _layouts = [NSMutableArray new];
    }
    return _layouts;
}

- (ViewModel *)viewModel {
    
    if (!_viewModel) {
        _viewModel = [ViewModel new];
    }
    return _viewModel;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.frame = self.view.bounds;
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.tableView];
    [self.viewModel reloadData:^(NSArray<ComponentLayout *> *layouts) {
        [self.layouts removeAllObjects];
        [self.layouts addObjectsFromArray:layouts];
        [self.tableView reloadData];
    }];
    
    [self.viewModel loadMoreData:^(NSArray<ComponentLayout *> *layouts) {
        [self.layouts addObjectsFromArray:layouts];
        [self.tableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.layouts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ComponentCell * cell = [ComponentCell cellWithTableView:tableView];
    [cell setupData:self.layouts[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ComponentLayout * layout = self.layouts[indexPath.row];
    return layout.cellHeight;
}


@end
