//
//  WebViewController.m
//  Network
//
//  Created by 朱双泉 on 2018/9/30.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>

@interface WebViewController () <UIWebViewDelegate>
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet WKWebView *wkWebView;
@property (nonatomic, weak) UIBarButtonItem * backItem;
@property (nonatomic, weak) UIBarButtonItem * forwordItem;
#pragma clang diagnostic pop
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"WebView";
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithTitle:@"Refresh" style:(UIBarButtonItemStylePlain) target:self action:@selector(refresh)];
    UIBarButtonItem * item2 = [[UIBarButtonItem alloc]initWithTitle:@"Forword" style:(UIBarButtonItemStylePlain) target:self action:@selector(forword)];
    UIBarButtonItem * item3 = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:(UIBarButtonItemStylePlain) target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItems = @[item, item2, item3];

//    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"xxxx.mp4" ofType:nil]]];
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.apple.com"]];
    self.webView.backgroundColor = [UIColor clearColor];
    self.webView.delegate = self;
    [self.webView loadRequest:request];
    [self.wkWebView loadRequest:request];
    
    self.backItem = item3;
    self.forwordItem = item2;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"%s", __func__);
    NSLog(@"%@", request.URL.absoluteString);
    if ([request.URL.absoluteString containsString:@"xxx"]) {
        return NO;
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"%s", __func__);
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"%s", __func__);
    self.backItem.enabled = webView.canGoBack;
    self.forwordItem.enabled = webView.canGoForward;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"%s", __func__);
}

- (void)refresh {
    [self.webView reload];
}

- (void)forword {
    [self.webView goForward];
}

- (void)back {
    [self.webView goBack];
}

@end
