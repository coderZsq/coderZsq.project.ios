//
//  SQCollectionViewScaleFlowLayout.h
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SQCollectionViewScaleFlowLayout : UICollectionViewFlowLayout

@property (nonatomic,assign) CGFloat itemWidth;

@property (nonatomic,assign) CGFloat itemHeight;

@property (nonatomic,assign) CGFloat activeDistance;

@property (nonatomic,assign) CGFloat scaleFactor;

@property (nonatomic,assign) CGFloat spaceFactor;

@end
