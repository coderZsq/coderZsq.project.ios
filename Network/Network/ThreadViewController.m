//
//  ThreadViewController.m
//  Network
//
//  Created by 朱双泉 on 2018/9/26.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "ThreadViewController.h"
#import <pthread.h>

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
];
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

- (void)sync_main {
    //死锁
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
    if ([self.dataSource[indexPath.row] rangeOfString:@"thread_communication"].location != NSNotFound) {
        cell.imageView.image = self.image;
    } else {
        cell.imageView.image = nil;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString * title = self.dataSource[indexPath.row];
    if ([title rangeOfString:@"thread_safe"].location != NSNotFound) {
        [self thread_safe];
        return;
    }
    if ([title rangeOfString:@"thread_communication"].location != NSNotFound) {
        [self thread_communication];
        return;
    }
    if ([title rangeOfString:@"async_concurrent"].location != NSNotFound) {
        [self async_concurrent];
        return;
    }
    if ([title rangeOfString:@"async_serial"].location != NSNotFound) {
        [self async_serial];
        return;
    }
    if ([title rangeOfString:@"sync_concurrent"].location != NSNotFound) {
        [self sync_concurrent];
        return;
    }
    if ([title rangeOfString:@"sync_serial"].location != NSNotFound) {
        [self sync_serial];
        return;
    }
    if ([title rangeOfString:@"async_main"].location != NSNotFound) {
        [self async_main];
        return;
    }
}

@end
