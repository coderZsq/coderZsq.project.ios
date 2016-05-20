//
//  SQCollectionViewLoopLayout.m
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import "SQCollectionViewLoopLayout.h"

static CGFloat const itemWH = 50;
static CGFloat const radius = 120;

@implementation SQCollectionViewLoopLayout

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes * layoutAttribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGPoint circleCenter = CGPointMake(self.collectionView.frame.size.width * 0.5, self.collectionView.frame.size.height * 0.5);
    CGFloat angleDelta   = M_PI * 2 / [self.collectionView numberOfItemsInSection:indexPath.section];
    CGFloat angle        = indexPath.item * angleDelta;
    
    layoutAttribute.size   = CGSizeMake(itemWH, itemWH);
    layoutAttribute.center = CGPointMake(circleCenter.x + radius * cosf(angle), circleCenter.y - radius * sinf(angle));
    layoutAttribute.zIndex = indexPath.item;
    
    return layoutAttribute;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSMutableArray * layoutAttributesArr = [NSMutableArray array];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < count; i++) {
        [layoutAttributesArr addObject:[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]]];
    }
    return layoutAttributesArr;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

@end
