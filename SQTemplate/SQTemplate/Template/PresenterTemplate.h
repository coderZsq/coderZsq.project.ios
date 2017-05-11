//
//  PresenterTemplate.h
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/5.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InterfaceTemplate.h"

@interface PresenterTemplate : NSObject<ViewOperation>

@property (nonatomic,weak) id<ViewInterface> view;
@property (nonatomic,weak) id<ViewModelInterface> viewModel;

- (void)adapterWithView:(id<ViewInterface>)view viewModel:(id<ViewModelInterface>)viewModel;

@end

