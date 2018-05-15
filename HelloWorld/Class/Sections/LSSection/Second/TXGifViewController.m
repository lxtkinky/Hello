//
//  TXGifViewController.m
//  HelloWorld
//
//  Created by ken on 2018/5/10.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import "TXGifViewController.h"
#import <WebKit/WebKit.h>
//#import <Photos/Photos.h>

@interface TXGifViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation TXGifViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    WKWebView *webView = [[WKWebView alloc] init];
    [webView setTintColor:[UIColor clearColor]];
    [self.view addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(362, 362));
    }];
    
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"turntable_tur_bk_gif" ofType:@"gif"]];
    [webView loadData:data MIMEType:@"image/gif" characterEncodingName:nil baseURL:nil];
    
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"turntable_tur_bk"]];
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(362, 362));
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"start/stop" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 60));
    }];
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        self.imageView.hidden = !self.imageView.hidden;
//        [self saveImageToNative:self.imageView.image];
    }];
    
    
}

- (void)saveImageToNative:(UIImage *)image{
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void*)self);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
