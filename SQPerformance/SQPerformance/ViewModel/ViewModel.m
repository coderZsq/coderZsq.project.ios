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

- (void)reloadData:(LayoutCompeltionBlock)completion error:(void(^)(void))errorCompletion {
    
    [self.service fetchMockDataWithParam:nil completion:^(NSArray<ComponentModel *> *models, NSError *error) {
        if (models.count > 0 && error == nil) {
            dispatch_queue_t queue = dispatch_queue_create("serial", DISPATCH_QUEUE_SERIAL);
            dispatch_async(queue, ^{
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
        } else {
            errorCompletion();
        }
    }];
}

- (void)loadMoreData:(LayoutCompeltionBlock)completion {
    [self reloadData:completion error:nil];
}

- (ComponentLayout *)preLayoutFrom:(ComponentModel *)model {
    
    ComponentLayout * layout = [ComponentLayout new];
    layout.cellWidth = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat cursor = 0;
    
    CGFloat x = 5.;
    CGFloat y = 0.;
    CGFloat height = 0.;
    
    NSMutableArray * textElements = [NSMutableArray array];
    NSArray * texts = model[@"texts"];
    for (NSUInteger i = 0; i < texts.count; i++) {
        NSString * text = texts[i];
        CGSize size = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:7]} context:nil].size;
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
        [textElements addObject:element];
    }
    cursor += height + 5;
    
    x = 5.; y = cursor; height = 0.;
    
    NSMutableArray * imageElements = [NSMutableArray array];
    NSArray * images = model[@"images"];
    for (NSUInteger i = 0; i < images.count; i++) {
        NSString * url = images[i];
        CGSize size = CGSizeMake(40, 40);
        if ((x + size.width) > layout.cellWidth) {
            x = 5;
            y += (size.height + 5);
            height = (y - cursor) + size.height + 5;
        }
        CGRect frame = CGRectMake(x, y, size.width, size.height);
        x += (size.width + 5);
        
        Element * element = [Element new];
        element.value = url;
        element.frame = frame;
        [imageElements addObject:element];
    }
    cursor += height + 5;
    
    layout.cellHeight = cursor;
    layout.textElements = textElements;
    layout.imageElements = imageElements;
    return layout;
}

@end
