//
//  TXRACController.m
//  HelloWorld
//
//  Created by lixt on 2018/2/7.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import "TXRACController.h"

@interface TXRACController ()

@end

@implementation TXRACController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self testRACNotification];
    
    [self testControlEvent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)testRACNotification{
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"userLogin" object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"userLogin" object:nil];
}

- (void)testControlEvent{
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundColor:RGBCOLOR(250, 126, 200)];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(200, 60));
    }];
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"button click");
    }];
}

- (void)testRACKVO{
    
}

@end
