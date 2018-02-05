//
//  AlipayViewController.m
//  HelloWorld
//
//  Created by test on 2018/1/8.
//  Copyright © 2018年 test. All rights reserved.
//

#import "AlipayViewController.h"
#import <AlipaySDK/AlipaySDK.h>

static NSString *token = @"eyJhbGciOiJIUzI1NiIsImV4cCI6MTUxNTEyNjIwOSwiaWF0IjoxNTE1MTIyNjA5fQ.eyJ1c2VybmFtZSI6IjE1NjAzMDc3OTMwIn0.8evkoYUCEVr014pGAkkVdRdMotjXJ_psH8V9CGqEZF4";

@interface AlipayViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation AlipayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark WebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    WeakType(self)
    BOOL isIntercepted = [[AlipaySDK defaultService] payInterceptorWithUrl:[request.URL absoluteString] fromScheme:@"HelloWorld" callback:^(NSDictionary *resultDic) {
        //处理支付结果
        NSLog(@"%@", resultDic);
        // isProcessUrlPay 代表 支付宝已经处理该URL
        if ([[resultDic objectForKey:@"isProcessUrlPay"] boolValue]) {
            // returnUrl 代表 第三方App需要跳转的成功页URL
            NSString* urlStr = resultDic[@"returnUrl"];
            NSLog(@"urlStr=%@", urlStr);
//            [weakself loadWithUrlStr:urlStr];
        }
        
    }];
    
    if (isIntercepted) {
        return NO;
    }
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"webViewDidStartLoad");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"webViewDidFinishLoad");
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"didFailLoadWithError");
}

#pragma mark - getter setter
/*
 UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
 webView.delegate = self;
 webView.scalesPageToFit = YES;
 [self.view addSubview:webView];
 NSString *urlStr = [NSString stringWithFormat:@"http://61.155.215.48:5000/api/order_index/?token=%@", token];
 NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
 [webView loadRequest:request];
 */
- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.delegate = self;
        _webView.scalesPageToFit = YES;
         NSString *urlStr = [NSString stringWithFormat:@"http://61.155.215.48:5000/api/order_index/?token=%@", token];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
        [_webView loadRequest:request];
    }
    return _webView;
}


@end
