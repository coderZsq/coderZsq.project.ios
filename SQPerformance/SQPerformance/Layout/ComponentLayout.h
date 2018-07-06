//
//  ComponentLayout.h
//  SQPerformance
//
//  Created by 朱双泉 on 2018/7/5.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "CellLayout.h"

@class Element;

@interface ComponentLayout : CellLayout

@property (nonatomic,strong) NSMutableArray<Element *> * textElements;
@property (nonatomic,strong) NSMutableArray<Element *> * imageElements;

@end
