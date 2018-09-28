//
//  WebImageViewController.m
//  Network
//
//  Created by 朱双泉 on 2018/9/27.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "WebImageViewController.h"
#import <MJExtension.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImageManager.h>
#import <SDWebImage/UIImage+GIF.h>

@interface WebImageModel : NSObject
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * icon;
@property (nonatomic, copy) NSString * download;
@end
@implementation WebImageModel @end

@interface WebImageViewController () <NSCacheDelegate>
@property (nonatomic, copy) NSArray * dataSource;
@property (nonatomic, strong) NSMutableDictionary * images;
@property (nonatomic, strong) NSMutableDictionary * operations;
@property (nonatomic, strong) NSOperationQueue * queue;
@property (nonatomic, strong) NSCache * cache;
@end

@implementation WebImageViewController

- (void)cache:(NSCache *)cache willEvictObject:(id)obj {
    NSLog(@"%s - %@", __func__, obj);
}

- (NSCache *)cache {
    
    if (!_cache) {
        _cache = [NSCache new];
        _cache.countLimit = 10;
        //        _cache.totalCostLimit = 10;
        _cache.delegate = self;
    }
    return _cache;
}

- (NSMutableDictionary *)operations {
    
    if (!_operations) {
        _operations = @{}.mutableCopy;
    }
    return _operations;
}

- (NSOperationQueue *)queue {
    
    if (!_queue) {
        _queue = [NSOperationQueue new];
    }
    return _queue;
}

- (NSMutableDictionary *)images {
    
    if (!_images) {
        _images = @{}.mutableCopy;
    }
    return _images;
}

- (NSArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = [WebImageModel mj_objectArrayWithFilename:@"webimage.plist"];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"WebImage";
    
    //    self.tableView.tableFooterView = [[UIImageView alloc]initWithImage:[UIImage sd_animatedGIFWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"test" ofType:@"gif"]]]];
    [self runloop];
}

- (void)runloop {
    NSRunLoop * mainRunLoop = [NSRunLoop mainRunLoop];
    NSRunLoop * currentRunLoop = [NSRunLoop currentRunLoop];
    //    NSLog(@"%@", mainRunLoop);
    
    CFRunLoopRef mainRunLoopRef = CFRunLoopGetMain();
    CFRunLoopRef currentRunLoopRef = CFRunLoopGetCurrent();
    NSLog(@"%p - %p", mainRunLoopRef, currentRunLoopRef);
    NSLog(@"%p - %p", mainRunLoop.getCFRunLoop, currentRunLoop.getCFRunLoop);
#if 0
    NSTimer * timer = [NSTimer timerWithTimeInterval:1. repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"%@", [NSRunLoop currentRunLoop].currentMode);
    }];
    //    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSDefaultRunLoopMode];
    //    [[NSRunLoop currentRunLoop]addTimer:timer forMode:UITrackingRunLoopMode];
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
#endif
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSRunLoop * newThreadRunLoop = [NSRunLoop currentRunLoop];
        NSLog(@"%@", newThreadRunLoop);
        NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:1. repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSLog(@"%@", [NSRunLoop currentRunLoop].currentMode);
        }];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5. * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [timer invalidate];
        });
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
        [[NSRunLoop currentRunLoop] run];
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WebImageModel * model = self.dataSource[indexPath.row];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    cell.textLabel.text = model.name;
    cell.detailTextLabel.text = model.download;
#if 1
    //    UIImage * image = self.images[model.icon];
    UIImage * image = [self.cache objectForKey:model.icon];
    if (image) {
        NSLog(@"cache - %@", image);
    }
    NSString * pathComponent = [model.icon lastPathComponent];
    NSString * cache = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    NSString * path = [cache stringByAppendingPathComponent:pathComponent];
    NSData * data = [NSData dataWithContentsOfFile:path];
    if (image) { //memory cache
        cell.imageView.image = image;
    } else if (data) { //disk cache
        UIImage * imaged = [UIImage imageWithData:data];
        cell.imageView.image = imaged;
        //        self.images[model.icon] = image;
        //        [self.cache setObject:imaged forKey:model.icon cost:2];
        [self.cache setObject:imaged forKey:model.icon];
    } else if (!self.operations[model.icon]) { //operation cache
        cell.imageView.image = nil;
        //        cell.imageView.image = [UIImage imageNamed:@"Mark"];
        NSBlockOperation * op = [NSBlockOperation blockOperationWithBlock:^{
            NSURL * url = [NSURL URLWithString:model.icon];
            NSData * data = [NSData dataWithContentsOfURL:url];
            UIImage * image = [UIImage imageWithData:data];
            //            self.images[model.icon] = image;
            [self.cache setObject:image forKey:model.icon];
            [data writeToFile:path atomically:YES];
            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                //                cell.imageView.image = image;
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationBottom)];
            }];
        }];
        self.operations[model.icon] = op;
        [self.queue addOperation:op];
    }
#endif
    //    [self downloadImage:cell.imageView URL:[NSURL URLWithString:model.icon]];
    return cell;
}

- (void)downloadImage:(UIImageView *)imageView URL:(NSURL *)URL {
    //    [imageView sd_setImageWithURL:URL placeholderImage:nil];
    [imageView sd_setImageWithURL:URL placeholderImage:nil options:SDWebImageProgressiveDownload | SDWebImageCacheMemoryOnly progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        NSLog(@"%f", 1. * receivedSize / expectedSize);
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        switch (cacheType) {
            case SDImageCacheTypeMemory:
                NSLog(@"SDImageCacheTypeMemory");
                break;
            case SDImageCacheTypeDisk:
                NSLog(@"SDImageCacheTypeDisk");
                break;
            case SDImageCacheTypeNone:
                NSLog(@"SDImageCacheTypeNone");
                break;
        }
    }];
    //    [SDWebImageManager sharedManager]loadImageWithURL:<#(nullable NSURL *)#> options:<#(SDWebImageOptions)#> progress:<#^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL)progressBlock#> completed:<#^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL)completedBlock#>
}

@end
