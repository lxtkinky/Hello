//
//  WebViewController.m
//  HelloWorld
//
//  Created by test on 2018/1/5.
//  Copyright © 2018年 test. All rights reserved.
//

#import "WebViewController.h"
#import "NSString+Hash.h"

static NSString *token = @"eyJhbGciOiJIUzI1NiIsImV4cCI6MTUxNTEyNjIwOSwiaWF0IjoxNTE1MTIyNjA5fQ.eyJ1c2VybmFtZSI6IjE1NjAzMDc3OTMwIn0.8evkoYUCEVr014pGAkkVdRdMotjXJ_psH8V9CGqEZF4";

@interface WebViewController ()<UIWebViewDelegate>

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button1];
    button1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [button1 setTitle:@"1" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(40);
        make.centerY.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(60, 40));
    }];
    
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button2];
    button2.tag = 2;
    button2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [button2 setTitle:@"1" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).with.offset(-40);
        make.centerY.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(60, 40));
    }];
    
    
    
    
    NSLog(@"md5str:%@", [@"123456" stringByAppendingString:@"sdfasdfasdfasdfasdfasdfsadfasd"].md5String);
    
    
//    [webView goBack];
//    [webView goForward];
//    [webView reload];//重载
//    [webView stopLoading];//取消载入内容
}

- (void)buttonClick:(UIButton *)button{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.delegate = self;
    webView.scalesPageToFit = YES;
    [self.view addSubview:webView];
    NSString *urlStr = [NSString stringWithFormat:@"http://61.155.215.48:5000/api/order_index/?token=%@", token];
    webView.scalesPageToFit = YES;
    urlStr = @"http://www.a305.org/yun.php?url=http://www.iqiyi.com/v_19rreglczg.html#vfrm=19-9-0-1";
    //    http://www.a305.org/yun.php?url=http://www.iqiyi.com/v_19rrf3j77c.html#vfrm=19-9-0-1
    //    http://000o.cc/jx/ty.php?url=http://www.iqiyi.com/v_19rreglczg.html#vfrm=19-9-0-1
//    urlStr = @"http://www.iqiyi.com";
    if (button.tag == 2) {
        urlStr = @"http://www.a305.org/yun.php?url=http://www.iqiyi.com/v_19rrf3j77c.html#vfrm=19-9-0-1";
    }
    
//    urlStr = @"http://amjsc88.com";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [webView loadRequest:request];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"%@", request);
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"webViewDidStartLoad");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"webViewDidFinishLoad");
    //(initial-scale是初始缩放比,minimum-scale=1.0最小缩放比,maximum-scale=5.0最大缩放比,user-scalable=yes是否支持缩放)
//    NSString *meta = [NSString stringWithFormat:@"document.getElementsByName(\"viewport\")[0].content = \"width=self.view.frame.size.width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no\""];
//    [webView stringByEvaluatingJavaScriptFromString:meta];
    
    
    //支持缩放功能
    NSString *jsMeta = [NSString stringWithFormat:@"var meta = document.createElement('meta');meta.content='width=device-width,initial-scale=1.0,minimum-scale=.5,maximum-scale=3';meta.name='viewport';document.getElementsByTagName('head')[0].appendChild(meta);"];
    [webView stringByEvaluatingJavaScriptFromString:jsMeta];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"didFailLoadWithError");
}

@end
