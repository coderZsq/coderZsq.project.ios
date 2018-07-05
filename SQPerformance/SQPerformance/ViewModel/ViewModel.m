//
//  ViewModel.m
//  SQPerformance
//
//  Created by 朱双泉 on 2018/7/5.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "ViewModel.h"
#import "ComponentModel.h"
#import "ComponentLayout.h"
#import "Element.h"
#import <UIKit/UIKit.h>

@implementation ViewModel

- (Service *)service {
    
    if (!_service) {
        _service = [Service new];
    }
    return _service;
}

- (void)reloadData:(LayoutCompeltionBlock)completion {
    [self.service fetchMockDataWithParam:nil completion:^(NSArray<ComponentModel *> *models, NSError *error) {
        
        if (models.count > 0 && error == nil) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                NSMutableArray * array = [NSMutableArray new];
                for (ComponentModel * model in models) {
                    ComponentLayout * layout = [self preLayoutFrom:model];
                    [array addObject:layout];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (completion) {
                        completion(array);
                    }
                });
            });
        }
    }];
}

- (void)loadMoreData:(LayoutCompeltionBlock)completion {
    [self reloadData:completion];
}

- (ComponentLayout *)preLayoutFrom:(ComponentModel *)model {
    
    ComponentLayout * layout = [ComponentLayout new];
    layout.cellWidth = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat spaceYStart = 0;
    
    NSMutableArray * elements = [NSMutableArray new];
    CGFloat x = 5.;
    CGFloat y = 0.;
    CGFloat height = 0.;
    for (NSInteger i = 0; i < model.count; i++) {
        NSString * text = model[i];
        CGSize size = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size;
        if ((x + size.width) > layout.cellWidth) {
            x = 5;
            y += (size.height + 10);
            height = y + size.height + 5;
        }
        CGRect frame = CGRectMake(x, y, size.width + 5, size.height + 5);
        x += (size.width + 10);

        Element * element = [Element new];
        element.value = text;
        element.frame = frame;
        [elements addObject:element];
    }
    
    layout.labels = elements;
    spaceYStart += height;
    layout.cellHeight = spaceYStart;
    return layout;
}

@end
