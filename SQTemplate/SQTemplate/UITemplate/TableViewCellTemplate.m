//
//  TableViewCellTemplate.m
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/11.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import "TableViewCellTemplate.h"
#import "SubviewTemplate.h"
#import "CollectionViewTemplate.h"
#import "UIImageView+load.h"

@interface TableViewCellTemplate ()

@property (nonatomic,strong) SubviewTemplate * subview;
@property (nonatomic,strong) CollectionViewTemplate * collectionView;

@end

@implementation TableViewCellTemplate

- (void)dealloc {
    NSLog(@"%@ - execute %s",NSStringFromClass([self class]),__func__);
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    NSString * identifier = NSStringFromClass([TableViewCellTemplate class]);
    TableViewCellTemplate * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[TableViewCellTemplate alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (SubviewTemplate *)subview {
    
    if (!_subview) {
        _subview = [SubviewTemplate new];
    }
    return _subview;
}

- (CollectionViewTemplate *)collectionView {
    
    if (!_collectionView) {
        _collectionView = [CollectionViewTemplate new];
    }
    return _collectionView;
}

- (void)setupSubviews {
    [self.contentView addSubview:self.subview];
    [self.contentView addSubview:self.collectionView];
}

- (void)setDataSource:(id<SubmodelInterfaceTemplate>)dataSource {
    _dataSource = dataSource;
    _subview.textLabel.text = dataSource.text;
    _subview.detailTextLabel.text = dataSource.detailText;
    [_subview.imageView loadUrl:dataSource.imageUrl placeholder:nil];
}

- (void)setDataModels:(NSArray *)dataModels {
    _dataModels = dataModels;
    _collectionView.dataSourceArr = dataModels;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat subviewX = 0;
    CGFloat subviewY = 0;
    CGFloat subviewW = self.bounds.size.width;
    CGFloat subviewH = self.bounds.size.height / 2;
    _subview.frame = CGRectMake(subviewX, subviewY, subviewW, subviewH);
    
    CGFloat collectionViewX = subviewX;
    CGFloat collectionViewY = subviewY + subviewH;
    CGFloat collectionViewW = subviewW;
    CGFloat collectionViewH = subviewH;
    _collectionView.frame = CGRectMake(collectionViewX, collectionViewY, collectionViewW, collectionViewH);
}

+ (CGFloat)cellHeight {
    return 160;
}

@end
