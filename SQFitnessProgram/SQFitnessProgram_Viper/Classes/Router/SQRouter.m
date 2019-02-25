//
//  SQRouter.m
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/25.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQRouter.h"

@implementation SQRouter

+ (void)pushViewController:(UIViewController *)destination fromViewController:(UIViewController *)source animated:(BOOL)animated {
    NSParameterAssert([destination isKindOfClass:[UIViewController class]]);
    NSParameterAssert(source.navigationController);
    [source.navigationController pushViewController:destination animated:animated];
}

+ (void)popViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSParameterAssert(viewController.navigationController);
    [viewController.navigationController popViewControllerAnimated:animated];
}

+ (void)presentViewController:(UIViewController *)viewControllerToPresent fromViewController:(UIViewController *)source animated:(BOOL)animated completion:(void (^)(void))completion {
    NSParameterAssert(viewControllerToPresent);
    NSParameterAssert(source);
    [source presentViewController:viewControllerToPresent animated:animated completion:completion];
}

+ (void)dismissViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(void))completion {
    NSParameterAssert(viewController);
    [viewController dismissViewControllerAnimated:animated completion:completion];
}

@end
