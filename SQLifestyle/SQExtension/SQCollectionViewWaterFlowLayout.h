//
//  SQCollectionViewWaterFlowLayout.h
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SQCollectionViewWaterFlowLayout;

@protocol SQCollectionViewWaterFlowLayoutDelegate <NSObject>

- (CGFloat)waterflowLayout:(SQCollectionViewWaterFlowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath;

@end

@interface SQCollectionViewWaterFlowLayout : UICollectionViewLayout

@property (nonatomic, assign) UIEdgeInsets sectionInset;

@property (nonatomic, assign) CGFloat      columnMargin;

@property (nonatomic, assign) CGFloat      rowMargin;

@property (nonatomic, assign) int          columnsCount;

@property (nonatomic, weak) id <SQCollectionViewWaterFlowLayoutDelegate> delegate;

@end
