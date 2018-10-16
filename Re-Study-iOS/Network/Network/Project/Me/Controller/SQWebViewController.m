//
//  SQWebViewController.m
//  Network
//
//  Created by 朱双泉 on 2018/10/16.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQWebViewController.h"
#import <WebKit/WebKit.h>

@interface SQWebViewController ()
@property (weak, nonatomic) IBOutlet WKWebView *webView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backBarButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwordBarButtonItem;
@end

@implementation SQWebViewController

- (void)dealloc {
    [_webView removeObserver:self forKeyPath:@"canGoBack"];
    [_webView removeObserver:self forKeyPath:@"canGoForward"];
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [_webView removeObserver:self forKeyPath:@"title"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [_webView loadRequest:[NSURLRequest requestWithURL:_url]];
    [_webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    [_webView addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil];
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    _backBarButtonItem.enabled = _webView.canGoBack;
    _forwordBarButtonItem.enabled = _webView.canGoForward;
    _progressView.progress = _webView.estimatedProgress;
    _progressView.hidden = _progressView.progress >= 1;
    self.title = _webView.title;
}

- (IBAction)backBarButtonClick:(UIBarButtonItem *)sender {
    [_webView goBack];
}

- (IBAction)forwordBarButtonClick:(UIBarButtonItem *)sender {
    [_webView goForward];
}

- (IBAction)refreshBarButtonClick:(UIBarButtonItem *)sender {
    [_webView reload];
}

@end
