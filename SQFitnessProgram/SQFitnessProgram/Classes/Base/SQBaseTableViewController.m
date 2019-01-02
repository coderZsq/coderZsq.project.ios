//
//  SQBaseTableViewController.m
//  SQFitnessProgram
//
//  Created by 朱双泉 on 2018/12/30.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQBaseTableViewController.h"

@interface SQBaseTableViewController ()

@property (nonatomic, strong) NSArray * models;
@property (nonatomic, copy) LoadCellType loadCell;
@property (nonatomic, copy) LoadCellHType loadCellH;
@property (nonatomic, copy) BindType bind;

@end

@implementation SQBaseTableViewController

- (void)setupDataSource:(NSArray *)models loadCell:(LoadCellType)loadCell loadCellHeight:(LoadCellHType)loadCellHeight bind:(BindType)bind {
    self.loadCell = loadCell;
    self.loadCellH = loadCellHeight;
    self.bind = bind;
    self.models = models;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
    [self setupUI];
}

- (void)setupUI {
    
}

- (void)setupData {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:@"reloadData" object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
