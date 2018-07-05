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

@property (nonatomic,strong) NSMutableArray<Element *> * labels;
@property (nonatomic,strong) Element * label2;
@property (nonatomic,strong) Element * label3;
@property (nonatomic,strong) Element * label4;

@end
