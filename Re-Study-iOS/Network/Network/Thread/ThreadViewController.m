//
//  ThreadViewController.m
//  Network
//
//  Created by 朱双泉 on 2018/9/26.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "ThreadViewController.h"
#import <pthread.h>

@interface Singleton : NSObject <NSCopying, NSMutableCopying>  @end

@implementation Singleton

+ (instancetype)sharedSingleton {
    return [self new];
}

- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _instance;
}

static Singleton * _instance;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
#if 0
    @synchronized (self) {
        if (_instance == nil) {
            _instance = [super allocWithZone:zone];
        }
    }
#endif
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

@end

@interface Thread : NSThread @end
@implementation Thread

- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
@interface ThreadViewController ()
@property (nonatomic, copy) NSArray * dataSource;

@property (nonatomic, strong) NSThread * thread1;
@property (nonatomic, strong) NSThread * thread2;
@property (nonatomic, strong) NSThread * thread3;
@property (nonatomic, assign) NSInteger ticketCount;
//@property (nonatomic, strong) NSObject * lock;

@property (nonatomic, strong) UIImage * image;
@property (nonatomic, strong) UIImage * image1;
@property (nonatomic, strong) UIImage * image2;

@end

@implementation ThreadViewController

- (NSArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = @[@"NSThread - thread_safe - excute",
                        @"NSThread - thread_communication - excute",
                        @"GCD - async_concurrent - excute",
                        @"GCD - async_serial - excute",
                        @"GCD - sync_concurrent - excute",
                        @"GCD - sync_serial - excute",
                        @"GCD - async_main - excute",
                        @"GCD - gcd_communication - excute",
                        @"GCD - gcd_once - excute",
                        @"GCD - gcd_after - excute",
                        @"GCD - gcd_apply - excute",
                        @"GCD - gcd_barrier - excute",
                        @"GCD - gcd_group - excute"];
    }
    return _dataSource;
}

- (IBAction)pthread {
    pthread_t thread = nil;
    pthread_create(&thread, NULL, run, NULL);
}

void *run (void * param) {
    //    for (int i = 0; i < 10000000; ++i) {
    NSLog(@"%@", [NSThread currentThread]);
    //    }
    return NULL;
}

- (IBAction)nsthread {
    
    NSThread * thread = [[Thread alloc]initWithTarget:self selector:@selector(run) object:nil];
    thread.name = @"thread - 01";
    thread.threadPriority = 1.;
    [thread start];
#if 0
    [NSThread detachNewThreadSelector:@selector(run) toTarget:self withObject:nil];
    [self performSelectorInBackground:@selector(run) withObject:nil];
#endif
}

- (void)run {
    NSLog(@"%@ start", [NSThread currentThread]);
    [NSThread sleepForTimeInterval:1.];
    [NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:2.]];
    //    [NSThread sleepUntilDate:[NSDate distantFuture]];
    [NSThread exit];
    //    return;
    NSLog(@"%@ end", [NSThread currentThread]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Thread";
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSThread * mainThread = [NSThread mainThread];
    NSLog(@"%@", mainThread);
    
    NSThread * currentThread = [NSThread currentThread];
    NSLog(@"%@", currentThread);
    
    NSLog(@"%i", [NSThread isMainThread]);
    NSLog(@"%i", [currentThread isMainThread]);
    
    //    self.lock = [NSObject new];
}

- (void)gcd_group {
    dispatch_queue_t queue = dispatch_queue_create("Test", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue2 = dispatch_queue_create("Test", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        NSLog(@"0 - %@", [NSThread currentThread]);
        NSURL * url = [NSURL URLWithString:@"https://avatars2.githubusercontent.com/u/19483268?s=400&u=97869a443baab2820618a8a575cee677b80849c7&v=4"];
        NSData * data = [NSData dataWithContentsOfURL:url];
        UIImage * image = [UIImage imageWithData:data];
        self.image1 = image;
        dispatch_group_leave(group);
    });
    
    dispatch_group_async(group, queue2, ^{
        NSLog(@"1 - %@", [NSThread currentThread]);
        NSURL * url = [NSURL URLWithString:@"https://avatars2.githubusercontent.com/u/19483268?s=400&u=97869a443baab2820618a8a575cee677b80849c7&v=4"];
        NSData * data = [NSData dataWithContentsOfURL:url];
        UIImage * image = [UIImage imageWithData:data];
        self.image2 = image;

    });
    
    dispatch_async_f(queue, NULL, group_run);

    dispatch_group_async(group, queue, ^{
        NSLog(@"3 - %@", [NSThread currentThread]);
    });
    dispatch_group_async(group, queue2, ^{
        NSLog(@"4 - %@", [NSThread currentThread]);
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"group - %@", [NSThread currentThread]);
        UIGraphicsBeginImageContext(CGSizeMake(300, 300));
        [self.image1 drawInRect:CGRectMake(0, 0, 150, 300)];
        [self.image2 drawInRect:CGRectMake(150, 0, 150, 300)];
        UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.image = image;
        //        dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        //        });
    });
    
#if 0
    dispatch_barrier_async(dispatch_get_main_queue(), ^{
        NSLog(@"barrier - %@", [NSThread currentThread]);
    });
#endif
}

void group_run(void * param) {NSLog(@"2 - %@", [NSThread currentThread]);}

- (void)gcd_barrier {
    dispatch_queue_t queue = dispatch_queue_create("Test", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"1 - %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"2 - %@", [NSThread currentThread]);
    });
    //do not use global queue in barrier!
    dispatch_barrier_async(queue, ^{
        NSLog(@"barrier - %@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"3 - %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"4 - %@", [NSThread currentThread]);
    });
}

- (void)gcd_apply {
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    //on main queue will be deadlock! use serial equal to for loop
    dispatch_apply(10, queue, ^(size_t i) {
        NSLog(@"%@ - %li", [NSThread currentThread], i);
    });
#if 0
    __block NSString * path = @"/Users/zhushuangquan/Native Drive/GitHub/coderZsq.project.ios/Re-Study-iOS/Network/Network/Base.lproj";
    __block NSString * toPath = @"/Users/zhushuangquan/Native Drive/GitHub/coderZsq.project.ios/Re-Study-iOS/Network/Network/gcd_apply";
    NSArray * subPaths = [[NSFileManager defaultManager]subpathsAtPath:path];
    for (int i = 0; i < subPaths.count; i++) {
        path = [path stringByAppendingPathComponent:subPaths[i]];
        toPath = [toPath stringByAppendingPathComponent:subPaths[i]];
        [[NSFileManager defaultManager]copyItemAtPath:path toPath:toPath error:nil];
        NSLog(@"%@ - %@", subPaths[i], [NSThread currentThread]);
    }
    dispatch_apply(subPaths.count, dispatch_get_global_queue(0, 0), ^(size_t i) {
        path = [path stringByAppendingPathComponent:subPaths[i]];
        toPath = [toPath stringByAppendingPathComponent:subPaths[i]];
        [[NSFileManager defaultManager]copyItemAtPath:path toPath:toPath error:nil];
        NSLog(@"%@ - %@", subPaths[i], [NSThread currentThread]);
    });
#endif
}

- (void)gcd_after {
    //    [self performSelector:<#(nonnull SEL)#> withObject:<#(nullable id)#> afterDelay:<#(NSTimeInterval)#>]
    //    [NSTimer scheduledTimerWithTimeInterval:<#(NSTimeInterval)#> repeats:<#(BOOL)#> block:<#^(NSTimer * _Nonnull timer)block#>]
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2. * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
        NSLog(@"delay");
    });
}

- (void)gcd_once {
    static dispatch_once_t onceToken;
    NSLog(@"%zd", onceToken);
    dispatch_once(&onceToken, ^{
        NSLog(@"once");
    });
}

- (void)gcd_communication {
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        NSURL * url = [NSURL URLWithString:@"https://avatars2.githubusercontent.com/u/19483268?s=400&u=97869a443baab2820618a8a575cee677b80849c7&v=4"];
        NSDate * start = [NSDate date];
        CFTimeInterval start_cf = CFAbsoluteTimeGetCurrent();
        NSData * data = [NSData dataWithContentsOfURL:url];
        NSDate * end = [NSDate date];
        CFTimeInterval end_cf = CFAbsoluteTimeGetCurrent();
        NSLog(@"%f", [end timeIntervalSinceDate:start]);
        NSLog(@"%f cf", end_cf - start_cf);
        self.image = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
}

- (void)sync_main {
    //deadlock on main thread
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_sync(queue, ^{
        NSLog(@"1 - %@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"2 - %@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"3 - %@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"4 - %@", [NSThread currentThread]);
    });
}

- (void)async_main {
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        NSLog(@"1 - %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"2 - %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"3 - %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"4 - %@", [NSThread currentThread]);
    });
}

- (void)sync_serial {
    dispatch_queue_t queue = dispatch_queue_create("com.coderZsq.www.DownloadQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(queue, ^{
        NSLog(@"1 - %@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"2 - %@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"3 - %@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"4 - %@", [NSThread currentThread]);
    });
}

- (void)sync_concurrent {
    dispatch_queue_t queue = dispatch_queue_create("com.coderZsq.www.DownloadQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(queue, ^{
        NSLog(@"1 - %@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"2 - %@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"3 - %@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"4 - %@", [NSThread currentThread]);
    });
}

- (void)async_serial {
    dispatch_queue_t queue = dispatch_queue_create("com.coderZsq.www.DownloadQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSLog(@"1 - %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"2 - %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"3 - %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"4 - %@", [NSThread currentThread]);
    });
}

- (void)async_concurrent {
    //    dispatch_queue_t queue = dispatch_queue_create("com.coderZsq.www.DownloadQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        NSLog(@"1 - %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"2 - %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"3 - %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"4 - %@", [NSThread currentThread]);
    });
}

- (void)thread_communication {
    [NSThread detachNewThreadWithBlock:^{
        NSURL * url = [NSURL URLWithString:@"https://avatars2.githubusercontent.com/u/19483268?s=400&u=97869a443baab2820618a8a575cee677b80849c7&v=4"];
        NSDate * start = [NSDate date];
        CFTimeInterval start_cf = CFAbsoluteTimeGetCurrent();
        NSData * data = [NSData dataWithContentsOfURL:url];
        NSDate * end = [NSDate date];
        CFTimeInterval end_cf = CFAbsoluteTimeGetCurrent();
        NSLog(@"%f", [end timeIntervalSinceDate:start]);
        NSLog(@"%f cf", end_cf - start_cf);
        self.image = [UIImage imageWithData:data];
#if 0
        [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
        [self performSelector:@selector(reloadData) onThread:[NSThread mainThread] withObject:nil waitUntilDone:YES];
#endif
        [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    }];
}
#if 0
- (void)reloadData {
    [self.tableView reloadData];
}
#endif
- (void)saleTicket {
    while (1) {
        @synchronized (self /*self.lock*/) {
            NSInteger count = self.ticketCount;
            if (count > 0) {
                self.ticketCount = count - 1;
                for (int i = 0; i < 10000000; i++) {}
                NSLog(@"%@ - remain %li", [NSThread currentThread].name, self.ticketCount);
            } else {
                NSLog(@"%@ end", [NSThread currentThread].name);
                break;
            }
        }
    }
}

- (void)thread_safe {
    self.ticketCount = 100;
    
    self.thread1 = [[NSThread alloc]initWithTarget:self selector:@selector(saleTicket) object:nil];
    self.thread2 = [[NSThread alloc]initWithTarget:self selector:@selector(saleTicket) object:nil];
    self.thread3 = [[NSThread alloc]initWithTarget:self selector:@selector(saleTicket) object:nil];
    
    self.thread1.name = @"thread1";
    self.thread2.name = @"thread2";
    self.thread3.name = @"thread3";
    
    [self.thread1 start];
    [self.thread2 start];
    [self.thread3 start];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"identifier"];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    cell.imageView.image = self.image;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@">>>>>>");
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self performSelector:NSSelectorFromString([self.dataSource[indexPath.row] componentsSeparatedByString:@" - "][1])];
#pragma clang diagnostic pop
}

@end
