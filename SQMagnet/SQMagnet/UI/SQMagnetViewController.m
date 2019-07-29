//
//  SQMagnetViewController.m
//  SQMagnet
//
//  Created by 朱双泉 on 2019/7/13.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQMagnetViewController.h"
#import "SQNetWorkTool.h"
#import "SQType2Model.h"
#import "SQMagnetTitleView.h"
#import "SQLoadingView.h"
#import "SQType2Cell.h"
#import "SQType3Cell.h"
#import "SQType4Cell.h"
#import "SQType3Model.h"
#import "UIView+SQExtension.h"
#import <MJExtension/MJExtension.h>
#import <YYWebImage.h>

@interface SQMagnetViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *names;
@property (nonatomic, strong) NSArray *values;
@property (nonatomic, copy) NSString *para;
@property (nonatomic, strong) NSMutableArray *datas;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *titleContentView;
@property (nonatomic, weak) SQMagnetTitleView *titleView;
@property (nonatomic, weak) SQLoadingView *loadingView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;

@end

@implementation SQMagnetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (@available(iOS 13.0, *)) {
        _topConstraint.constant = 0;
    }

    self.titleView = [SQMagnetTitleView titleViewWithTitle:self.query image:self.image rate:self.rate];
    if (self.dict) {
        self.titleView.imageView.yy_imageURL = [NSURL URLWithString:self.dict[@"img"]];
    }
    [self.titleContentView addSubview:self.titleView];
    
    self.loadingView = [SQLoadingView loadingView];
    [self.view addSubview:self.loadingView];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(SQType2Cell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(SQType2Cell.class)];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(SQType3Cell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(SQType3Cell.class)];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(SQType4Cell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(SQType4Cell.class)];

    [SQNetWorkTool requestInterface:@"baike" parameters:@[self.query] callback:^(NSArray * _Nonnull results) {
       SQType3Model *model = [SQType3Model mj_objectArrayWithKeyValuesArray:results].firstObject;
        self.names = model.names;
        self.values = model.values;
        self.para = model.para;
        if (self.para.length && self.names.count) {
            self.titleView.descriptionLabel.hidden = YES;
        }
        [self.tableView reloadData];
    }];
    
    
    NSDictionary *dict1 = [self getJsonDataJsonname:[NSString stringWithFormat:@"th_%@", self.query]];
    NSDictionary *dict2 = [self getJsonDataJsonname:[NSString stringWithFormat:@"ph_%@", self.query]];
    NSDictionary *dict3 = [self getJsonDataJsonname:[NSString stringWithFormat:@"bw_%@", self.query]];
    NSDictionary *dict4 = [self getJsonDataJsonname:self.query];
    self.datas = @[].mutableCopy;
    [self.datas addObjectsFromArray:[SQType2Model mj_objectArrayWithKeyValuesArray:dict1[self.query]]];
    [self.datas addObjectsFromArray:[SQType2Model mj_objectArrayWithKeyValuesArray:dict2[self.query]]];
    [self.datas addObjectsFromArray:[SQType2Model mj_objectArrayWithKeyValuesArray:dict3[self.query]]];
    [self.datas addObjectsFromArray:[SQType2Model mj_objectArrayWithKeyValuesArray:dict4[self.query]]];
    if (self.datas.count) {
        self.titleView.descriptionLabel.text = [NSString stringWithFormat:@"已帮小主找到「%lu」条资源, 请您查收!", (unsigned long)self.datas.count];
    } else {
        [self loadDataFromRemote];
    }
}

- (id)getJsonDataJsonname:(NSString *)jsonname {
    NSString *path = [[NSBundle mainBundle] pathForResource:jsonname ofType:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:path];
    if (jsonData == nil) return nil;
    NSError *error;
    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (!jsonData || error) {
        return nil;
    } else {
        return jsonObj;
    }
}

- (void)loadDataFromRemote {
    [self.loadingView show];
    
    NSString *env = @"release";
#ifdef DEBUG
    env = @"debug";
#else
    env = @"release";
#endif
    
    [SQNetWorkTool requestInterface:@"fetch" parameters:@[self.query, env] callback:^(NSArray * _Nonnull results) {
        self.datas = [SQType2Model mj_objectArrayWithKeyValuesArray:results];
        [self.loadingView hide];
        if (self.datas.count) {
            self.titleView.descriptionLabel.text = [NSString stringWithFormat:@"已帮小主找到「%lu」条资源, 请您查收!", (unsigned long)self.datas.count];
        } else {
            self.titleView.descriptionLabel.text = @"全宇宙都没有小主想要的资源呢...尝试首页直接关键词搜索哦~";
        }
        [self.tableView reloadData];
    }];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.titleView.frame = self.titleContentView.frame;
    self.loadingView.bounds = CGRectMake(0, 0, 60, 60);
    self.loadingView.center = CGPointMake(self.view.width * .5f, self.view.height * .5f);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) return 1;
    if (section == 0) return self.names.count;
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        SQType3Cell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(SQType3Cell.class)];
        NSString *para = [NSString stringWithFormat:@"\n内容简介: \n\n%@", self.para];
        cell.paraLabel.text = self.para.length ? para : @"";
        return cell;
    }
    if (indexPath.section == 0) {
        SQType4Cell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(SQType4Cell.class)];
        cell.nameLabel.text = self.names[indexPath.row];
        NSString *value = self.values[indexPath.row];
        cell.valueLabel.text = value.length ? value : @"未知";
        return cell;
    }
    SQType2Cell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(SQType2Cell.class)];
    SQType2Model *model = self.datas[indexPath.row];
    cell.nameLabel.text = model.name;
    cell.actionLabel.text = model.action;
    return cell;
}

@end
