//
//  SQTableViewSection.h
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQTableViewSection : NSObject

@property (nonatomic,strong) NSString * headerTitle;

@property (nonatomic,strong) NSString * footerTitle;

@property (nonatomic,assign) Class headerView;

@property (nonatomic,assign) Class footerView;

@property (nonatomic,assign) double headerHeight;

@property (nonatomic,assign) double footerHeight;

@property (nonatomic,strong) NSMutableArray * rows;

@end
