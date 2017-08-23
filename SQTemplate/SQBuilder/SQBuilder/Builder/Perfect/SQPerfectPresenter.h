//
//  PresenterTemplate.h
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/5.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQPerfectInterface.h"

@interface SQPerfectPresenter : NSObject<SQPerfectViewModelInterface>

@property (nonatomic,copy) NSString * kksss;
@property (nonatomic,assign) NSInteger tabId;

- (void)adapterWithPerfectView:(id<SQPerfectViewInterface>)perfectView perfectViewModel:(id<SQPerfectViewModelInterface>)perfectViewModel;

@end
