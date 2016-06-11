//
//  SQTableViewRow.h
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQTableViewRow : NSObject

@property (nonatomic,assign) Class tableViewCell;

@property (nonatomic,assign) Class nextViewController;

@property (nonatomic,assign) double cellHeight;

+ (instancetype)rowForTableViewCell:(Class)tableViewCell cellHeight:(double)cellHeight;

@end
