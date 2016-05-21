//
//  SQCollectionViewStackLayout.m
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import "SQCollectionViewStackLayout.h"

#define SQAngle(x) ((x) / 180.0f * M_PI)

static CGFloat const itemWH = 100;

@implementation SQCollectionViewStackLayout

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray * angles = @[@SQAngle(0), @SQAngle(8), @SQAngle(-5), @SQAngle(5), @SQAngle(-8)];
    UICollectionViewLayoutAttributes * layoutAttribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    layoutAttribute.size = CGSizeMake(itemWH, itemWH);
    layoutAttribute.center = CGPointMake(self.collectionView.frame.size.width * 0.5, self.collectionView.frame.size.height * 0.5);
    if (indexPath.item >= 5) {
        layoutAttribute.hidden = YES;
    } else {
        layoutAttribute.transform = CGAffineTransformMakeRotation([angles[indexPath.item] floatValue]);
        layoutAttribute.zIndex = [self.collectionView numberOfItemsInSection:indexPath.section] - indexPath.item;
    }
    return layoutAttribute;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSMutableArray * layoutAttributesArr = [NSMutableArray array];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i<count; i++) {
        UICollectionViewLayoutAttributes * layoutAttribute = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [layoutAttributesArr addObject:layoutAttribute];
    }
    return layoutAttributesArr;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

@end
