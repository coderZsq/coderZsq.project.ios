//
//  SQBaseTabViewController.m
//  Network
//
//  Created by 朱双泉 on 2018/10/16.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQBaseTabViewController.h"
#define Top ([[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.frame.size.height)

@interface SQBaseTabViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, weak) UIScrollView * scrollView;
@property (nonatomic, weak) UICollectionView * collectionView;
@property (nonatomic, weak) UIButton * preButton;
@property (nonatomic, strong) NSMutableArray * buttons;
@property (nonatomic, weak) UIView * underLine;
@property (nonatomic, assign) BOOL isInitial;
@end

@implementation SQBaseTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupButtonContainerView];
    [self setupTopTitleView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_isInitial == NO) {
        [self setupAllTitleButton];
        _isInitial = YES;
    }
}

- (NSMutableArray *)buttons {
    
    if (!_buttons) {
        _buttons = @[].mutableCopy;
    }
    return _buttons;
}

- (void)setupAllTitleButton {
    NSInteger count = self.childViewControllers.count;
    CGFloat buttonX = 0;
    CGFloat buttonY = 0;
    CGFloat buttonW = self.view.width / count;
    CGFloat buttonH = _scrollView.height;
    for (int i = 0; i < count; i++) {
        UIButton * button = [UIButton new];
        buttonX = i * buttonW;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        UIViewController * vc = self.childViewControllers[i];
        [button setTitle:vc.title forState:UIControlStateNormal];
        [_scrollView addSubview:button];
        button.tag = i;
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttons addObject:button];
        if (i == 0) {
            UIView * underLine = [UIView new];
            underLine.backgroundColor = [UIColor redColor];
            [_scrollView addSubview:underLine];
            [button.titleLabel sizeToFit];
            underLine.width = button.titleLabel.width;
            underLine.height = 2;
            underLine.centerX = button.centerX;
            underLine.y = _scrollView.height - underLine.height;
            [self buttonClick:button];
            _underLine = underLine;
        }
    }
}

- (void)buttonClick:(UIButton *)sender {
    [self selectButton:sender];
    NSInteger i = sender.tag;
    [_collectionView setContentOffset:CGPointMake(i * self.view.width, 0) animated:YES];
}

- (void)selectButton:(UIButton *)button {
    _preButton.selected = NO;
    button.selected = YES;
    _preButton = button;
    [UIView animateWithDuration:.25 animations:^{
        self.underLine.centerX = button.centerX;
    }];
}

- (void)setupButtonContainerView {
    UICollectionViewFlowLayout * layout = [UICollectionViewFlowLayout new];
    layout.itemSize = self.view.bounds.size;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.pagingEnabled = YES;
    collectionView.bounces = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"identifier"];
    collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [self.view addSubview:collectionView];
    _collectionView = collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.childViewControllers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"identifier" forIndexPath:indexPath];
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UITableViewController * vc = self.childViewControllers[indexPath.row];
    vc.tableView.contentInset = UIEdgeInsetsMake(_scrollView.height, 0, 0, 0);
    [cell.contentView addSubview:vc.view];
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger page = scrollView.contentOffset.x / self.view.width;
    UIButton * button = self.buttons[page];
    [self selectButton:button];
}

- (void)setupTopTitleView {
    UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, Top, self.view.width, 35)];
    scrollView.backgroundColor = [UIColor colorWithWhite:1 alpha:.6];
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
}

@end
