//
//  TXShareController.m
//  HelloWorld
//
//  Created by ken on 2018/5/9.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import "TXShareController.h"
#import "TXShareManager.h"

@interface TXShareController ()

@end

@implementation TXShareController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"分享" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(60, 40));
    }];
    
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self shareMessage];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)shareMessage{
    TXShareManager *manager = [TXShareManager sharedManager];
    BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]];
    if (canOpen) {
        [manager shareMessageToWchat:@"hello" scene:TXWXSceneTimeline];
    }else{
        NSString *urlStr = @"https://itunes.apple.com/cn/app/%E5%BE%AE%E4%BF%A1/id414478124?mt=8";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
    }
}


@end
