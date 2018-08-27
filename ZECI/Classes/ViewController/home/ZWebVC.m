//
//  ZWebVC.m
//  ZECI
//
//  Created by zzz on 2018/8/27.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZWebVC.h"
#import <WebKit/WebKit.h>

@interface ZWebVC ()<WKUIDelegate,UIScrollViewDelegate>
@property (nonatomic, strong)  WKWebView* iWebView;
@end

@implementation ZWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self initWebView];
}

- (void)setNavigation {
    [self.customNavBar setTitle:@"关于我们"];
    self.customNavBar.hidden = NO;
    self.customNavBar.title = @"公司信息";
}


- (void)initWebView {
    
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    [wkUController addUserScript:wkUScript];
    
    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    wkWebConfig.userContentController = wkUController;
    
    _iWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0,kSafeAreaTopHeight, kWindowW,kWindowH) configuration:wkWebConfig];
    
    [_iWebView setBackgroundColor:[UIColor whiteColor]];
    
  
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    [_iWebView loadRequest:request];
    [self.view addSubview:_iWebView];
    [_iWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(kSafeAreaTopHeight);
    }];
    
}


#pragma mark WKWebView代理方法 WKNavigationDelegate 协议
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"webView 开始加载");
    
    
}
// 内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"webView 内容开始返回");
}
// 页面加载完成时调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"webView 页面加载完成");
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(nonnull NSError *)error {
    NSLog(@"webView 页面加载失败");
}
@end
