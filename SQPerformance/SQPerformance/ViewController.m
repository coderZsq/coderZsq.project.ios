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

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource> {
    UISwitch * switchOn;
    UILabel * fpsLabel;
}

@property (nonatomic,strong) ViewModel * viewModel;
@property (nonatomic,strong) NSMutableArray <ComponentLayout *> * layouts;
@property (nonatomic,strong) UIScrollView * contentView;
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) UITableView * asyncTableView;
@property (nonatomic,assign, getter=isAsyncDraw) BOOL asyncDraw;

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

- (UIScrollView *)contentView {
    
    if (!_contentView) {
        _contentView = [UIScrollView new];
        _contentView.frame = self.view.bounds;
        _contentView.delegate = self;
        _contentView.scrollEnabled = NO;
        [_contentView setPagingEnabled:YES];
        [_contentView setBounces:NO];
        [_contentView addSubview:self.tableView];
        [_contentView addSubview:self.asyncTableView];
    }
    return _contentView;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (UITableView *)asyncTableView {
    
    if (!_asyncTableView) {
        _asyncTableView = [UITableView new];
        _asyncTableView.dataSource = self;
        _asyncTableView.delegate = self;
    }
    return _asyncTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"Performance optimization"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UISwitch * view = [UISwitch new]; switchOn = view;
    [view addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    UIBarButtonItem * rItem = [[UIBarButtonItem alloc]initWithCustomView:view];
    [self.navigationItem setRightBarButtonItem:rItem];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 44)];
    label.text = @"fps:  "; fpsLabel = label;
    UIBarButtonItem * lItem = [[UIBarButtonItem alloc]initWithCustomView:label];
    [self.navigationItem setLeftBarButtonItem:lItem];
    
    [[CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkAction:)] addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
    [self.view addSubview:self.contentView];
    [self.viewModel reloadData:^(NSArray<ComponentLayout *> *layouts) {
        [self.layouts removeAllObjects];
        [self.layouts addObjectsFromArray:layouts];
        [self.tableView reloadData];
        [self.asyncTableView reloadData];
    } error:^{
        UIAlertController * alertViewController = [UIAlertController alertControllerWithTitle:@"Error" message:@"please turn on the server!!!\n use command [$ node server.js] " preferredStyle:UIAlertControllerStyleAlert];
        [alertViewController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            exit(1);
        }]];
        [self presentViewController:alertViewController animated:YES completion:nil];
    }];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGFloat tableViewX = 0;
    CGFloat tableViewY = 0;
    CGFloat tableViewW = self.view.bounds.size.width;
    CGFloat tableViewH = self.view.bounds.size.height;
    _contentView.contentSize = CGSizeMake(tableViewW * 2, tableViewH);
    _tableView.frame = CGRectMake(tableViewX, tableViewY, tableViewW, tableViewH);
    _asyncTableView.frame = CGRectMake(tableViewX + tableViewW, tableViewY, tableViewW, tableViewH);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.layouts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ComponentCell * cell = [ComponentCell cellWithTableView:tableView];
    [cell setupData:self.layouts[indexPath.row] asynchronously:tableView == self.asyncTableView ? YES : NO];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ComponentLayout * layout = self.layouts[indexPath.row];
    return layout.cellHeight;
}

- (void)switchValueChanged:(UISwitch *)sender {
    [self.contentView setContentOffset:CGPointMake(sender.on ? self.view.bounds.size.width : 0, 0) animated:YES];
}

- (void)displayLinkAction:(CADisplayLink *)link {
    static NSTimeInterval lastTime = 0;
    static int frameCount = 0;
    if (lastTime == 0) {
        lastTime = link.timestamp;
        return;
    }
    frameCount++;
    NSTimeInterval passTime = link.timestamp - lastTime;
    if (passTime > 1) {
        int fps = (frameCount / passTime) + 1;
        lastTime = link.timestamp;
        frameCount = 0;
        fpsLabel.text = [NSString stringWithFormat:@"fps: %d", fps];
    }
}

@end
