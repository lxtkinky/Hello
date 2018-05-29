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

#pragma mark - 根据文本长度改变提交按钮状态
- (void)test0{
    /*
     //根据文本长度改变提交按钮状态
    RAC(nickView.submitButton, enabled) = [nickView.nickNameText.rac_textSignal map:^id(NSString *value) {
        return value.length > 3 ? @YES : @NO;
    }];
     */
}
#pragma mark - 把输入框内从和vm的属性关联起来
- (void)test1{
    /*
     //把输入框内从和vm的属性关联起来
     RAC(nickView.vm, nickName) = nickView.nickNameText.rac_textSignal;
     __weak TXNickNameView *weakObject = nickView;
     [[nickView.nickNameText rac_textSignal] subscribeNext:^(NSString *string) {
     weakObject.vm.nickName = string;
     NSLog(@"string = %@", string);
     }];
     */
}
#pragma mark -  多个信号
- (void)test2{
//    // 6.处理多个请求，都返回结果的时候，统一做处理.
//    RACSignal *request1 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//
//        // 发送请求1
//        [subscriber sendNext:@"发送请求1"];
//        return nil;
//    }];
//
//    RACSignal *request2 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        // 发送请求2
//        [subscriber sendNext:@"发送请求2"];
//        return nil;
//    }];
    
    // 使用注意：几个信号，参数一的方法就几个参数，每个参数对应信号发出的数据。
//    [self rac_liftSelector:@selector(updateUIWithR1:r2:) withSignalsFromArray:@[request1,request2]];
}

@end
