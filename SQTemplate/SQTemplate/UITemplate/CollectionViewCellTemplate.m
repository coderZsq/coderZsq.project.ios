//
//  CollectionViewCellTemplate.m
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/11.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import "CollectionViewCellTemplate.h"
#import "SubviewTemplate.h"
#import "UIImageView+load.h"

@interface CollectionViewCellTemplate ()

@property (nonatomic,strong) SubviewTemplate * subview;

@end

@implementation CollectionViewCellTemplate

- (void)dealloc {
    NSLog(@"%@ - execute %s",NSStringFromClass([self class]),__func__);
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder  {
    
    self = [super initWithCoder:coder];
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

- (void)setupSubviews {
    [self.contentView addSubview:self.subview];
}

- (void)setDataSource:(id<SubmodelInterfaceTemplate>)dataSource {
    _dataSource = dataSource;
    _subview.textLabel.text = dataSource.text;
    _subview.detailTextLabel.text = dataSource.detailText;
    [_subview.imageView loadUrl:dataSource.imageUrl placeholder:nil];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat subviewX = 0;
    CGFloat subviewY = 0;
    CGFloat subviewW = self.frame.size.width;
    CGFloat subviewH = self.frame.size.height;
    _subview.frame = CGRectMake(subviewX, subviewY, subviewW, subviewH);
}

@end
