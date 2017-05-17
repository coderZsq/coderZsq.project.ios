//
//  SQCollectionViewSnakeFlowLayout.m
//  Mall
//
//  Created by 双泉 朱 on 17/5/15.
//  Copyright © 2017年 _Zhizi_. All rights reserved.
//

#import "SQCollectionViewSnakeFlowLayout.h"

@interface SQCollectionViewSnakeFlowLayout ()

@property (nonatomic,strong) NSMutableArray * layoutAttributesArr;
@property (nonatomic,assign) CGFloat          contentSize_height;

@end

@implementation SQCollectionViewSnakeFlowLayout

- (NSMutableArray *)layoutAttributesArr {
    
    if (!_layoutAttributesArr) {
        self.layoutAttributesArr = @[].mutableCopy;
    }
    return _layoutAttributesArr;
}

- (void)prepareLayout {
    [super prepareLayout];
    [self.layoutAttributesArr removeAllObjects];
    for (int i = 0; i < [self.collectionView numberOfItemsInSection:0]; i++) {
        [self.layoutAttributesArr addObject:[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]]];
    }
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger item = indexPath.item;
    NSInteger row  = (item / _numPerLine);
    BOOL isOddNum  = (item / _numPerLine) % 2 == 0 ? YES : NO;
    
    CGFloat itemW = self.collectionView.width / _numPerLine;
    CGFloat itemH = itemW;
    CGFloat itemX = 0;
    CGFloat itemY = 0;
    
    if (isOddNum) {itemX = (item % _numPerLine) * itemW;}
    else {itemX = (self.collectionView.width - itemW) - itemW * (item % _numPerLine);}
    
    itemY = row * itemH;
    self.contentSize_height = itemY + itemH;
    
    UICollectionViewLayoutAttributes * layoutAttribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    layoutAttribute.frame = CGRectMake(itemX, itemY, itemW, itemH);
    return layoutAttribute;
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(self.collectionView.width, _contentSize_height);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.layoutAttributesArr;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

@end
