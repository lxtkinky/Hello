//
//  WebViewController.m
//  HelloWorld
//
//  Created by test on 2018/1/5.
//  Copyright © 2018年 test. All rights reserved.
//

#import "WebViewController.h"

static NSString *token = @"eyJhbGciOiJIUzI1NiIsImV4cCI6MTUxNTEyNjIwOSwiaWF0IjoxNTE1MTIyNjA5fQ.eyJ1c2VybmFtZSI6IjE1NjAzMDc3OTMwIn0.8evkoYUCEVr014pGAkkVdRdMotjXJ_psH8V9CGqEZF4";

@interface WebViewController ()<UIWebViewDelegate>

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.delegate = self;
    webView.scalesPageToFit = YES;
    [self.view addSubview:webView];
        NSString *urlStr = [NSString stringWithFormat:@"http://61.155.215.48:5000/api/order_index/?token=%@", token];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [webView loadRequest:request];
    
//    [webView goBack];
//    [webView goForward];
//    [webView reload];//重载
//    [webView stopLoading];//取消载入内容
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"%ld", navigationType);
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

@end
