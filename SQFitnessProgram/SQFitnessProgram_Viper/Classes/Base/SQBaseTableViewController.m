//
//  SQBaseTableViewController.m
//  SQFitnessProgram
//
//  Created by 朱双泉 on 2018/12/30.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQBaseTableViewController.h"
#import "SQViperViewEventHandler.h"
#import "UIViewController+SQViperRouter.h"

@interface SQBaseTableViewController ()

@property (nonatomic, strong) NSArray * models;
@property (nonatomic, copy) LoadCellType loadCell;
@property (nonatomic, copy) LoadCellHType loadCellH;
@property (nonatomic, copy) BindType bind;

@property (nonatomic, assign) BOOL appeared;
@property (nonatomic, strong) id<SQViperViewEventHandler> eventHandler;
@property (nonatomic, strong) id viewDataSource;

@end

@implementation SQBaseTableViewController

- (UIViewController *)routeSource {
    return self;
}

- (void)setupDataSource:(NSArray *)models loadCell:(LoadCellType)loadCell loadCellHeight:(LoadCellHType)loadCellHeight bind:(BindType)bind {
    self.loadCell = loadCell;
    self.loadCellH = loadCellHeight;
    self.bind = bind;
    self.models = models;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.appeared == NO) {
        [self setupData];
        if ([self.eventHandler respondsToSelector:@selector(handleViewReady)]) {
            [self.eventHandler handleViewReady];
        }
        [self setupUI];
        self.appeared = YES;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([self.eventHandler respondsToSelector:@selector(handleViewWillAppear:)]) {
        [self.eventHandler handleViewWillAppear:animated];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([self.eventHandler respondsToSelector:@selector(handleViewDidAppear:)]) {
        [self.eventHandler handleViewDidAppear:animated];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([self.eventHandler respondsToSelector:@selector(handleViewDidDisappear:)]) {
        [self.eventHandler handleViewDidDisappear:animated];
    }
    if (self.SQ_isRemoving == YES) {
        if ([self.eventHandler respondsToSelector:@selector(handleViewRemoved)]) {
            [self.eventHandler handleViewRemoved];
        }
    }
}

- (void)setupUI {
    
}

- (void)setupData {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:@"reloadData" object:nil];
}

- (void)reloadData {

}

- (void)setModels:(NSArray *)models {
    _models = models;
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.loadCell(tableView, indexPath);
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    id model = self.models[indexPath.row];
    self.bind(cell, model);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id model = self.models[indexPath.row];
    if (self.loadCellH) {
        return  self.loadCellH(model);
    }
    return 44;
}

@end
