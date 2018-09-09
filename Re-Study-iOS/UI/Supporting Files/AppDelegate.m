//
//  AppDelegate.m
//  UI
//
//  Created by 朱双泉 on 2018/9/5.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface Application : NSObject
+ (instancetype)shareApplication;
- (void)setIconBadgeNumber:(NSInteger)number;
- (void)setNetworkActivityState:(BOOL)visible;
- (void)setStateBarStyle:(UIStatusBarStyle)style;
- (void)openURL:(NSString *)URLString;
@end

@implementation Application

static Application * application;
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        application = [self new];
    });
}

+ (instancetype)shareApplication {
    return application;
}

+ (instancetype)alloc {
    if (application) {
        [[NSException exceptionWithName:@"NSInternalInconsistencyException" reason:@"There can only be one Application instance." userInfo:nil] raise];
    }
    return [super alloc];
}

- (void)setIconBadgeNumber:(NSInteger)number {
    UIApplication * app = [UIApplication sharedApplication];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    [app registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil]];
#pragma clang diagnostic pop
    app.applicationIconBadgeNumber = number;
}

- (void)setNetworkActivityState:(BOOL)visible {
    UIApplication * app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = visible;
}

- (void)setStateBarStyle:(UIStatusBarStyle)style {
    UIApplication * app = [UIApplication sharedApplication];
    app.statusBarStyle = style;
}

- (void)openURL:(NSString *)URLString {
    UIApplication * app = [UIApplication sharedApplication];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    [app openURL:[NSURL URLWithString:URLString]];
#pragma clang diagnostic pop
}

@end

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
#if 0
    Application * app = [Application shareApplication];
    Application * app2 = [Application shareApplication];
//    Application * app3 = [[Application alloc]init];
    NSLog(@"%p - %p", app, app2);
    [app setIconBadgeNumber:0];
    [app setNetworkActivityState:YES];
    [app openURL:@"https://github.com/coderZsq"];
    [app setStateBarStyle:UIStatusBarStyleLightContent];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    UINavigationController * nc = [[UINavigationController alloc]initWithRootViewController:[ViewController new]];
    //    UIViewController * vc = [[ViewController alloc]initWithNibName:nil bundle:nil];
    UIViewController * vc = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
    UINavigationController * nc2 = [[UINavigationController alloc]initWithRootViewController:vc];
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //    [sb instantiateViewControllerWithIdentifier:@"identifier"];
    UINavigationController * nc3 = [sb instantiateInitialViewController];
    self.window.rootViewController = nc2;
    self.window.windowLevel = UIWindowLevelNormal;
    [self.window makeKeyAndVisible];

    UIKIT_EXTERN const UIWindowLevel UIWindowLevelNormal;
    UIKIT_EXTERN const UIWindowLevel UIWindowLevelAlert;
    UIKIT_EXTERN const UIWindowLevel UIWindowLevelStatusBar __TVOS_PROHIBITED;
#endif
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"%s", __func__);
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"%s", __func__);
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"%s", __func__);
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"%s", __func__);
}


- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"%s", __func__);
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    NSLog(@"%s", __func__);
}

@end
