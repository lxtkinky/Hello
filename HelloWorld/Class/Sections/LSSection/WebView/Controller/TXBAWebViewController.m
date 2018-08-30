//
//  TXBAWebViewController.m
//  HelloWorld
//
//  Created by ken on 2018/5/5.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import "TXBAWebViewController.h"
#import "TXHtmlLoader.h"
#import <ReactiveObjC/NSObject+RACKVOWrapper.h>
#import <ReactiveObjC/UIButton+RACCommandSupport.h>
#import <WebKit/WebKit.h>

@interface TXBAWebViewController ()<WKNavigationDelegate,WKScriptMessageHandler,UIWebViewDelegate>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) WKUserContentController *userContentVC;

@end

@implementation TXBAWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self jsSendToOC];
    
//    [self lodHtmlWithUIWebView];
}

/**
 JS调用OC
 1、创建一个WKWebViewConfiguration
 2、创建一个WKUserContentController对象，并赋值给WKWebViewConfiguration对象
 3、WKUserContentController对象注册可供JS调用的对象名称，[_userContentVC addScriptMessageHandler:self name:@"hello"]（此处名称为hello在JS中会使用到，可注册多个）
 4、设置WKWebView的WKScriptMessageHandler代理方法userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
 5、在JS中调用window.webkit.messageHandlers.hello.postMessage('666')
 
 OC调用JS
 [webView evaluateJavaScript:inputValueJS completionHandler:]
 inputValueJS 为要执行的js代码，如：helo(123) helo为JS函数名称,
 获取HTML元素的属性：document.getElementsByName('hello')[0].attributes['value'].value
 */
- (void)jsSendToOC{
    NSString *htmlStr =[TXHtmlLoader loadHtmlStrFromFile:@"Document.html"];
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    _userContentVC = [[WKUserContentController alloc] init];
    [_userContentVC addScriptMessageHandler:self name:@"hello"];
    [_userContentVC addScriptMessageHandler:self name:@"func"];
    config.userContentController = _userContentVC;
    
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
    self.webView = webView;
    self.webView.navigationDelegate = self;
//    self.webView.dele
    //http://112.74.202.254/html/test1.html
    //http://lgqweb.1234x.com/#/
//    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://lgqweb.1234x.com/#/"]]];
    
    [webView loadHTMLString:htmlStr baseURL:nil];
    [self.view addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
    
//    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(60, 40));
    }];
    
    [[button rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {

        NSString *inputValueJS = @"alert(111)";
        //执行JS
        [self.webView evaluateJavaScript:inputValueJS completionHandler:^(id _Nullable response, NSError * _Nullable error) {
            NSLog(@"value: %@ error: %@", response, error);
        }];
    }];
}

- (void)lodHtmlWithUIWebView{
    UIWebView *webView = [[UIWebView alloc] init];
    webView.delegate = self;
//    self.webView = webView;
//    self.webView.navigationDelegate = self;
    //    self.webView.dele
    //http://112.74.202.254/html/test1.html
    //http://lgqweb.1234x.com/#/
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://lgqweb.1234x.com/#/"]]];
    
    //    [webView loadHTMLString:htmlStr baseURL:nil];
    [self.view addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
}




- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSLog(@"message = %@", message.body);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
//    NSString *inputValueJS = @"document.getElementsByName('hello')[0].attributes['value'].value";
//    //执行JS
//    [webView evaluateJavaScript:inputValueJS completionHandler:^(id _Nullable response, NSError * _Nullable error) {
//        NSLog(@"value: %@ error: %@", response, error);
//    }];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"title"]) {
        NSLog(@"title =%@", change);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"%@", [webView valueForKey:@"title"]);
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}

- (void)dealloc{
    [_userContentVC removeScriptMessageHandlerForName:@"hello"];
}


@end
