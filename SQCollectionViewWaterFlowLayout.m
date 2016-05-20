//
//  SQCollectionViewWaterFlowLayout.m
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import "SQCollectionViewWaterFlowLayout.h"

@interface SQCollectionViewWaterFlowLayout();

@property (nonatomic, strong) NSMutableDictionary * maxYDict;
@property (nonatomic, strong) NSMutableArray      * layoutAttributesArr;

@end

@implementation SQCollectionViewWaterFlowLayout

- (instancetype)init {
    
    if (self = [super init]) {
        self.columnMargin = 10;
        self.rowMargin    = 10;
        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        self.columnsCount = 3;
    }
    return self;
}

- (NSMutableDictionary *)maxYDict {
    
    if (!_maxYDict) {
        self.maxYDict = @{}.mutableCopy;
    }
    return _maxYDict;
}

- (NSMutableArray *)layoutAttributesArr {
    
    if (!_layoutAttributesArr) {
        self.layoutAttributesArr = @[].mutableCopy;
    }
    return _layoutAttributesArr;
}

- (void)prepareLayout {

    [super prepareLayout];
    
    for (int i = 0; i < self.columnsCount; i++) {
        self.maxYDict[[NSString stringWithFormat:@"%i", i]] = @(self.sectionInset.top);
    }
    
    [self.layoutAttributesArr removeAllObjects];
    for (int i = 0; i < [self.collectionView numberOfItemsInSection:0]; i++) {
        [self.layoutAttributesArr addObject:[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]]];
    }
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    __block NSString *minColumn = @"0";
    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(NSString * column, NSNumber * maxY, BOOL *stop) {
        if ([maxY floatValue] < [self.maxYDict[minColumn] floatValue]) {
            minColumn = column;
        }
    }];
    
    CGFloat width = (self.collectionView.frame.size.width - self.sectionInset.left - self.sectionInset.right - (self.columnsCount - 1) * self.columnMargin)/self.columnsCount;
    CGFloat height = [self.delegate waterflowLayout:self heightForWidth:width atIndexPath:indexPath];
    CGFloat x = self.sectionInset.left + (width + self.columnMargin) * [minColumn intValue];
    CGFloat y = [self.maxYDict[minColumn] floatValue] + self.rowMargin;
    
    self.maxYDict[minColumn] = @(y + height);
    
    UICollectionViewLayoutAttributes * layoutAttribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    layoutAttribute.frame = CGRectMake(x, y, width, height);
    return layoutAttribute;
}

- (CGSize)collectionViewContentSize {
    
    __block NSString * maxColumn = @"0";
    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(NSString * column, NSNumber * maxY, BOOL *stop) {
        if ([maxY floatValue] > [self.maxYDict[maxColumn] floatValue]) {
            maxColumn = column;
        }
    }];
    return CGSizeMake(0, [self.maxYDict[maxColumn] floatValue] + self.sectionInset.bottom);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.layoutAttributesArr;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

@end
