//
//  SQCollectionViewCoverFlowLayout.m
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import "SQCollectionViewCoverFlowLayout.h"

@implementation SQCollectionViewCoverFlowLayout

#define SQAngle(x) ((x) / 180.0f * M_PI)

- (instancetype)init {
    
    self = [super init];
    if (self) {
        self.itemWidth      = 100;
        self.itemHeight     = 100;
        self.activeDistance = 150;
        self.maxAngle       = 60;
        self.scaleFactor    = 0.5;
        self.spaceFactor    = 0.5;
    }
    return self;
}

- (void)prepareLayout {
    
    [super prepareLayout];
    
    self.itemSize = CGSizeMake(self.itemWidth,self.itemHeight);
    CGFloat inset = (self.collectionView.frame.size.width - self.itemWidth) * 0.5;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumLineSpacing = self.itemWidth * self.spaceFactor;
}

- (NSArray*)layoutAttributesForElementsInRect:(CGRect)rect {
    
    CGRect visibleRect;
    visibleRect.size   = self.collectionView.frame.size;
    visibleRect.origin = self.collectionView.contentOffset;
    
    NSArray * layoutAttributesArr = [super layoutAttributesForElementsInRect:rect];
    
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    for (UICollectionViewLayoutAttributes * layoutAttribute in layoutAttributesArr) {
        if (!CGRectIntersectsRect(visibleRect, layoutAttribute.frame)) continue;
        
        CGFloat itemCenterX = layoutAttribute.center.x;
        CGFloat scale       = 1 + self.scaleFactor * (1 - (ABS(itemCenterX - centerX) / self.activeDistance));
        CGFloat distance    = CGRectGetMidX(visibleRect) - layoutAttribute.center.x;
        
        if (CGRectIntersectsRect(layoutAttribute.frame, rect)) {
            
            CGFloat angleFactor = distance / self.activeDistance;
            
            if (ABS(distance) < self.activeDistance) {
                
                CGFloat angle = SQAngle(self.maxAngle) * angleFactor;
                CATransform3D transfrom = CATransform3DIdentity;
                transfrom.m34 = 1.0 / 600;
                transfrom = CATransform3DRotate(transfrom, -angle, 0.0, 1.0, 0.0);
                transfrom = CATransform3DScale(transfrom, scale, scale, 1);
                layoutAttribute.transform3D = transfrom;
                
            } else {
                
                CATransform3D transfrom = CATransform3DIdentity;
                transfrom.m34 = 1.0 / 600;
                if (distance > 0) {
                    transfrom = CATransform3DRotate(transfrom, -SQAngle(self.maxAngle), 0.0, 1.0, 0.0);
                } else {
                    transfrom = CATransform3DRotate(transfrom,  SQAngle(self.maxAngle), 0.0, 1.0, 0.0);
                }
                transfrom = CATransform3DScale(transfrom, scale, scale, 1);
                layoutAttribute.transform3D = transfrom;
                
            }
        }
    }
    return layoutAttributesArr;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds {
    return YES;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    
    CGRect lastRect;
    lastRect.size   = self.collectionView.frame.size;
    lastRect.origin = proposedContentOffset;
    
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    NSArray * layoutAttributesArr = [self layoutAttributesForElementsInRect:lastRect];
    
    CGFloat adjustOffsetX = MAXFLOAT;
    for (UICollectionViewLayoutAttributes * layoutAttribute in layoutAttributesArr) {
        if (ABS(layoutAttribute.center.x - centerX) < ABS(adjustOffsetX)) {
            adjustOffsetX = layoutAttribute.center.x - centerX;
        }
    }
    
    return CGPointMake(proposedContentOffset.x + adjustOffsetX, proposedContentOffset.y);
}


@end
