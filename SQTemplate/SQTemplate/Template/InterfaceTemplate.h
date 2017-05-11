//
//  InterfaceTemplate.h
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/5.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ViewOperation <NSObject>

- (void)pushTo;

@end

@protocol ModelInterface <NSObject>

@property (nonatomic,strong) NSArray * models;

@end

@protocol ViewModelInterface <NSObject>

@property (nonatomic,strong) id<ModelInterface> model;
- (void)dynamicBindingWithFinishedCallBack:(void(^)())finishCallBack;

@end


@protocol ViewInterface <NSObject>

@property (nonatomic,strong) id<ViewModelInterface> viewModel;
@property (nonatomic,strong) id<ViewOperation> operation;

@end

