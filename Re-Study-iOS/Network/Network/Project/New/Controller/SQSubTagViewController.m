//
//  SQSubTagViewController.m
//  Network
//
//  Created by 朱双泉 on 2018/10/15.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQSubTagViewController.h"
#import <AFNetworking.h>
#import "SQSubTagItem.h"
#import <MJExtension.h>
#import "SQSubTagCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SVProgressHUD.h>

@interface SQSubTagViewController ()
@property (nonatomic, copy) NSArray * dataSource;
//@property (nonatomic, weak) NSURLSessionDataTask * task;
@property (nonatomic, weak) AFHTTPSessionManager * manager;
@end

@implementation SQSubTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"SubTag";
    
    self.tableView.rowHeight = 60;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    [self.tableView registerNib:[UINib nibWithNibName:@"SQSubTagCell" bundle:nil] forCellReuseIdentifier:@"identifier"];
    
    [SVProgressHUD showInfoWithStatus:@"Loading..."];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    _manager = manager;
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"tag_recommend";
    parameters[@"c"] = @"topic";
    parameters[@"action"] = @"sub";
    /*self.task =*/ [manager GET:BaseURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.dataSource = [SQSubTagItem mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        [SVProgressHUD dismiss];
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
//    [self.task cancel];
    [_manager.tasks makeObjectsPerformSelector:@selector(cancel)];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SQSubTagItem * item = self.dataSource[indexPath.row];
    SQSubTagCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    cell.layoutMargins = UIEdgeInsetsZero;
    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:item.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        /*UIGraphicsBeginImageContextWithOptions(image.size, NO, [UIScreen mainScreen].scale);
        UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        [path addClip];
        [image drawAtPoint:CGPointZero];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        cell.iconImageView.image = image;*/
    }];
    cell.nameLabel.text = item.theme_name;
    CGFloat sub_number = [item.sub_number floatValue];
    NSString * sub_numbser_text = [NSString stringWithFormat:@"%@人订阅", item.sub_number];
    if (sub_number > 10000) {
        sub_number /= 10000.;
        sub_numbser_text = [NSString stringWithFormat:@"%.1f万人订阅", sub_number];
        sub_numbser_text = [sub_numbser_text stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    cell.numLabel.text = sub_numbser_text;
    return cell;
}

@end
