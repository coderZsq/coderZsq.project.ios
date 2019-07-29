//
//  SQListViewController.m
//  SQMagnet
//
//  Created by 朱双泉 on 2019/7/13.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQListViewController.h"
#import "UIView+SQExtension.h"
#import "SQType1SubCell.h"
#import "SQNetWorkTool.h"
#import "SQType1Model.h"
#import "UIColor+SQExtension.h"
#import <MJExtension/MJExtension.h>
#import <YYWebImage.h>

@interface SQListViewController ()

@property (nonatomic, strong) NSArray *datas;

@end

@implementation SQListViewController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 15;
        layout.minimumInteritemSpacing = 15;
        CGFloat itemWidth = ([UIScreen mainScreen].bounds.size.width - 60) / 3;
        CGFloat itemHeight = itemWidth * 200 / 120;
        layout.itemSize = CGSizeMake(itemWidth, itemHeight);
        layout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);
        return [super initWithCollectionViewLayout:layout];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self hookApplicationWillEnterForeground];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(SQType1SubCell.class) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];

    [self loadDataFromLocal];
//    [self loadDataFromRemote];
}

- (void)hookApplicationWillEnterForeground {
    self.collectionView.backgroundColor = [UIColor whiteColor];
    if (@available(iOS 13.0, *)) {
        self.collectionView.backgroundColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trait) {
            if (trait.userInterfaceStyle == UIUserInterfaceStyleDark) {
                return [UIColor colorWithHexString:@"#1c1c1e"];
            } else {
                return [UIColor whiteColor];
            }
        }];
    }
}

- (void)loadDataFromLocal {
    if ([self.title isEqualToString:@"推荐"]) {
        self.datas = [SQType1Model mj_objectArrayWithKeyValuesArray: [NSArray arrayWithContentsOfFile:[[NSBundle bundleForClass:self.class] pathForResource:@"SQChartList" ofType:@"plist"]]];
    } else if ([self.title isEqualToString:@"神作"]) {
        self.datas = [SQType1Model mj_objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:[[NSBundle bundleForClass:self.class] pathForResource:@"SQTop250List" ofType:@"plist"]]];
    } else {
        self.datas = [SQType1Model mj_objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:[[NSBundle bundleForClass:self.class] pathForResource:[NSString stringWithFormat:@"SQ%@%@List", self.type.capitalizedString, self.title.capitalizedString] ofType:@"plist"]]];
    }
}

- (void)loadDataFromRemote {
    if ([self.title isEqualToString:@"推荐"]) {
        [SQNetWorkTool requestInterface:@"chart" parameters:@[] callback:^(NSArray * _Nonnull results) {
            [results writeToFile:@"/System/Volumes/Data/Users/zhushuangquan/Native Drive/GitHub/coderZsq.practice.data/magnet/data/SQChartList.plist" atomically:YES];
            self.datas = [SQType1Model mj_objectArrayWithKeyValuesArray:results];
        }];
    } else if ([self.title isEqualToString:@"神作"]) {
        NSMutableDictionary *datas = @{}.mutableCopy;
        dispatch_group_t group = dispatch_group_create();
        dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
        for (NSUInteger i = 0; i < 10; i++) {
            NSString *start = [NSString stringWithFormat:@"%ld", i * 25];
            dispatch_group_async(group, queue, ^{
                dispatch_group_enter(group);
                [SQNetWorkTool requestInterface:@"top250" parameters:@[start] callback:^(NSArray * _Nonnull results) {
                    dispatch_group_leave(group);
                    datas[start] = results;
                }];
            });
        }
        dispatch_group_notify(group, queue, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                NSArray *keys = datas.allKeys;
                NSArray *sortedkeys = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                    return [obj1 compare:obj2 options:NSNumericSearch];
                }];
                NSMutableArray *jsondata = @[].mutableCopy;
                for (NSString *key in sortedkeys) {
                    [jsondata addObjectsFromArray:datas[key]];
                }
                [jsondata writeToFile:@"/System/Volumes/Data/Users/zhushuangquan/Native Drive/GitHub/coderZsq.practice.data/magnet/data/SQTop250List.plist" atomically:YES];
                self.datas = [SQType1Model mj_objectArrayWithKeyValuesArray: jsondata];
                [self.collectionView reloadData];
            });
        });
    } else {
        NSMutableDictionary *datas = @{}.mutableCopy;
        dispatch_group_t group = dispatch_group_create();
        dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
        NSString *tag = self.title;
        for (NSUInteger i = 0; i < 30; i++) {
            NSString *page_start = [NSString stringWithFormat:@"%ld", i * 20];
            dispatch_group_async(group, queue, ^{
                dispatch_group_enter(group);
                [SQNetWorkTool requestInterface:self.type parameters:@[tag, page_start] callback:^(NSArray * _Nonnull results) {
                    dispatch_group_leave(group);
                    datas[page_start] = results;
                }];
            });
        }
        dispatch_group_notify(group, queue, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                NSArray *keys = datas.allKeys;
                NSArray *sortedkeys = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                    return [obj1 compare:obj2 options:NSNumericSearch];
                }];
                NSMutableArray *jsondata = @[].mutableCopy;
                for (NSString *key in sortedkeys) {
                    [jsondata addObjectsFromArray:datas[key]];
                }
                [jsondata writeToFile:[NSString stringWithFormat:@"/System/Volumes/Data/Users/zhushuangquan/Native Drive/GitHub/coderZsq.practice.data/magnet/data/SQ%@%@List.plist", self.type.capitalizedString, self.title.capitalizedString] atomically:YES];
                self.datas = [SQType1Model mj_objectArrayWithKeyValuesArray: jsondata];
                [self.collectionView reloadData];
            });
        });
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SQType1SubCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    SQType1Model *model = self.datas[indexPath.row];
    cell.titleLabel.text = model.title;
    cell.rateLabel.text = [NSString stringWithFormat:@"%@分", model.rate];
    cell.imageView.yy_imageURL = [NSURL URLWithString:model.img];
    return cell;
}

@end
